import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

from telegram import InlineKeyboardButton, InlineKeyboardMarkup, ParseMode, Update
from telegram.ext import (
    CallbackContext,
    CallbackQueryHandler,
    CommandHandler,
    Dispatcher,
    Updater,
)

from config import BOT_TOKEN
from db import create_setlist, fetch_song_by_id, fetch_songs, get_setlist_songs

orig_process_update = Dispatcher.process_update


def logged_process_update(self, update):
    print(f"UPDATE: {update}")
    return orig_process_update(self, update)


Dispatcher.process_update = logged_process_update


def format_song(song):
    key = f"{song['key_letter']}{'m' if song['is_minor'] else ''}"
    playback = "✅" if song["has_playback"] else "❌"
    chords = f'<a href="{song["chords_url"]}">Ссылка</a>' if song["chords_url"] else "—"
    notes = song["notes"] or "—"
    lyrics = song["lyrics"] or "—"
    title_en = f" / {song['title_en']}" if song["title_en"] else ""
    return (
        f"<b>{song['title']}{title_en}</b>\n"
        f"\n{lyrics}\n\n"
        f"_____________________________\n\n"
        f"ID: <code>{song['id']}</code>\n"
        f"BPM: <b>{song['bpm']}</b>\n"
        f"Тональность: <b>{key}</b>\n"
        f"Плэйбэк: {playback}\n"
        f"Аккорды: {chords}\n"
        f"Заметки: {notes}\n"
    )


def format_song_short(song):
    key = f"{song['key_letter']}{'m' if song['is_minor'] else ''}"
    title_en = f" ({song['title_en']})" if song["title_en"] else " "
    return f"<b>{song['id']}. {song['title']}</b>{title_en}— <i>{key}, {song['bpm']} BPM</i>"


def songs_command(update: Update, context: CallbackContext):
    songs = fetch_songs()
    if not songs:
        update.message.reply_text("Песен не найдено.")
        return
    text = "\n\n".join([format_song_short(song) for song in songs])
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def song_command(update: Update, context: CallbackContext):
    args = context.args
    if not args or not args[0].isdigit():
        update.message.reply_text("Используйте: /song <id>")
        return
    song_id = int(args[0])
    song = fetch_song_by_id(song_id)
    if not song:
        update.message.reply_text("Песня не найдена.")
        return
    update.message.reply_text(
        format_song(song), parse_mode=ParseMode.HTML, disable_web_page_preview=True
    )


def search_command(update: Update, context: CallbackContext):
    if not context.args:
        update.message.reply_text("Используйте: /search <текст для поиска>")
        return
    query = " ".join(context.args).lower()
    songs = fetch_songs()
    results = []
    for song in songs:
        if (
            query in (song["title"] or "").lower()
            or query in (song["title_en"] or "").lower()
            or query in (song["lyrics"] or "").lower()
        ):
            results.append(song)
    if not results:
        update.message.reply_text("Ничего не найдено.")
        return
    text = "\n".join([format_song_short(song) for song in results])
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def set_command(update: Update, context: CallbackContext):
    if not context.args or len(context.args) < 2:
        update.message.reply_text("Используйте: /set <имя> <id1,id2,id3>")
        return
    name = context.args[0]
    ids_part = context.args[1]
    try:
        song_ids = [int(x) for x in ids_part.split(",") if x.isdigit()]
    except Exception:
        update.message.reply_text(
            "Ошибка в формате номеров песен. Пример: /set myset 1,2,3"
        )
        return
    if not song_ids:
        update.message.reply_text("Не указаны номера песен.")
        return
    setlist_id = create_setlist(name, song_ids)
    songs = get_setlist_songs(setlist_id)
    keyboard = [
        [
            InlineKeyboardButton(
                f"{i + 1}. {song['title']}", callback_data=f"set_{setlist_id}_{i}"
            )
        ]
        for i, song in enumerate(songs)
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)
    update.message.reply_text(
        f"Создан сет '{name}' (#{setlist_id}):", reply_markup=reply_markup
    )


def setlist_callback(update: Update, context: CallbackContext):
    query = update.callback_query
    if not query or not query.data:
        logger.warning("CallbackQuery пустой или без data")
        return

    try:
        logger.info(f"Получен callback: {query.data}")  # 1

        query.answer()
        data = query.data
        if data.startswith("set_"):
            _, setlist_id, idx = data.split("_")
            logger.info(f"setlist_id: {setlist_id}, idx: {idx}")  # 2

            setlist_id = int(setlist_id)
            idx = int(idx)
            songs = get_setlist_songs(setlist_id)
            song = songs[idx]
            total = len(songs)
            keyboard = []
            if idx > 0:
                keyboard.append(
                    [
                        InlineKeyboardButton(
                            "⬅️ Назад", callback_data=f"set_{setlist_id}_{idx - 1}"
                        )
                    ]
                )
            keyboard.append(
                [
                    InlineKeyboardButton(
                        "🔙 К списку", callback_data=f"setmenu_{setlist_id}"
                    )
                ]
            )
            if idx < total - 1:
                keyboard.append(
                    [
                        InlineKeyboardButton(
                            "Дальше ➡️", callback_data=f"set_{setlist_id}_{idx + 1}"
                        )
                    ]
                )
            reply_markup = InlineKeyboardMarkup(keyboard)
            query.edit_message_text(
                format_song(song),
                parse_mode=ParseMode.HTML,
                reply_markup=reply_markup,
                disable_web_page_preview=True,
            )
            logger.info("edit_message_text выполнен")  # 3

        elif data.startswith("setmenu_"):
            setlist_id = int(data.split("_")[1])
            songs = get_setlist_songs(setlist_id)
            keyboard = [
                [
                    InlineKeyboardButton(
                        f"{i + 1}. {song['title']}",
                        callback_data=f"set_{setlist_id}_{i}",
                    )
                ]
                for i, song in enumerate(songs)
            ]
            reply_markup = InlineKeyboardMarkup(keyboard)
            text = f"Сет #{setlist_id}:\n\n" + "\n".join(
                [f"{i + 1}. {song['title']}" for i, song in enumerate(songs)]
            )
            query.edit_message_text(text, reply_markup=reply_markup)
            logger.info("edit_message_text (меню) выполнен")  # 3

    except Exception as e:
        logger.exception("Ошибка в setlist_callback")  # 4
        try:
            query.edit_message_text(f"Произошла ошибка: {repr(e)}")
        except:
            logger.error("Не удалось отредактировать сообщение об ошибке")  # 5


def delset_command(update: Update, context: CallbackContext):
    if not context.args or not context.args[0].isdigit():
        update.message.reply_text("Используйте: /delset <id>")
        return
    setlist_id = int(context.args[0])
    from db import delete_setlist

    delete_setlist(setlist_id)
    update.message.reply_text(f"Сет #{setlist_id} удалён.")


def main():
    updater = Updater(BOT_TOKEN, use_context=True)
    dp = updater.dispatcher

    dp.add_handler(CommandHandler("songs", songs_command))
    dp.add_handler(CommandHandler("song", song_command, pass_args=True))
    dp.add_handler(CommandHandler("search", search_command, pass_args=True))
    dp.add_handler(CommandHandler("set", set_command, pass_args=True))
    dp.add_handler(CommandHandler("delset", delset_command, pass_args=True))
    dp.add_handler(CallbackQueryHandler(setlist_callback))

    updater.start_polling(allowed_updates=["message", "callback_query"])
    updater.idle()
