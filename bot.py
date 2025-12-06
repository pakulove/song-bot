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
from db import (
    create_setlist,
    fetch_all_setlists,
    fetch_song_by_id,
    fetch_songs,
    get_setlist_by_id,
    get_setlist_songs,
)

orig_process_update = Dispatcher.process_update


def logged_process_update(self, update):
    print(f"UPDATE: {update}")
    return orig_process_update(self, update)


Dispatcher.process_update = logged_process_update


def start_command(update: Update, context: CallbackContext):
    text = (
        "<b>🎵 Бот для работы с песнями команды прославления \"Голос Божий\"</b>\n\n"
        "<b>Команды:</b>\n"
        "• /songs — список всех песен (разделены на Поклонение и Прославление)\n"
        "• /song &lt;id&gt; — открыть песню по номеру\n"
        "• /search &lt;текст&gt; — поиск по названию, тексту или переводу\n\n"
        "<b>Работа с сетами:</b>\n"
        "• /sets — список всех сетов\n"
        "• /set &lt;id&gt; — открыть сет по номеру\n"
        "• /newset &lt;имя&gt; &lt;id1,id2,id3&gt; — создать сет\n"
        "• /delset &lt;id&gt; — удалить сет\n\n"
    )
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def format_song(song, show_lyrics=False):
    playback = "✅" if song["has_playback"] else "❌"
    chords = f'<a href="{song["chords_url"]}">Ссылка</a>' if song["chords_url"] else "—"
    notes = song["notes"] or "—"
    lyrics = song["lyrics"] or "—"
    title_en = f" / {song['title_en']}" if song["title_en"] else ""
    mode_text = "Прославление" if song.get("type") == 1 else "Поклонение"
    
    lyrics_part = f"\n{lyrics}\n" if show_lyrics else ""
    separator = "\n_____________________________\n" if show_lyrics else ""
    
    return (
        f"<b>{song['title']}{title_en}</b>\n"
        f"{lyrics_part}"
        f"{separator}"
        f"\n<b>{mode_text}</b> №<code>{song['id']}</code>\n"
        f"BPM: <b>{song['bpm']}</b>\n"
        f"Тональность: <b>{song['key_letter']}</b>\n"
        f"Плэйбэк: {playback}\n"
        f"Аккорды: {chords}\n"
        f"Заметки: {notes}\n"
    )


def format_song_short(song):
    key = f"{song['key_letter']}"
    title_en = f" ({song['title_en']})" if song.get("title_en") else ""
    return f"<b>{song['id']}. {song['title']}{title_en}</b> — <i>{key} | {song['bpm']} BPM</i>"


def songs_command(update: Update, context: CallbackContext):
    songs = fetch_songs()
    if not songs:
        update.message.reply_text("Песен не найдено.")
        return
    
    poklonenie = [song for song in songs if song.get("type") == 0]
    proslavlenie = [song for song in songs if song.get("type") == 1]
    
    parts = []
    if poklonenie:
        parts.append("<b>Поклонение:</b>")
        parts.append("\n\n".join([format_song_short(song) for song in poklonenie]))
    if proslavlenie:
        if parts:
            parts.append("")
        parts.append("<b>Прославление:</b>")
        parts.append("\n\n".join([format_song_short(song) for song in proslavlenie]))
    
    text = "\n\n".join(parts)
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
    
    keyboard = [[InlineKeyboardButton("📖 Развернуть текст", callback_data=f"toggle_lyrics_song_{song_id}_0")]]
    reply_markup = InlineKeyboardMarkup(keyboard)
    
    update.message.reply_text(
        format_song(song, show_lyrics=False),
        parse_mode=ParseMode.HTML,
        disable_web_page_preview=True,
        reply_markup=reply_markup,
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


def newset_command(update: Update, context: CallbackContext):
    if not context.args or len(context.args) < 2:
        update.message.reply_text("Используйте: /newset <имя> <id1,id2,id3>")
        return
    name = context.args[0]
    ids_part = context.args[1]
    try:
        song_ids = [int(x) for x in ids_part.split(",") if x.isdigit()]
    except Exception:
        update.message.reply_text(
            "Ошибка в формате номеров песен. Пример: /newset myset 1,2,3"
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
    song_list = "\n".join([f"{i + 1}. {song['title']}" for i, song in enumerate(songs)])
    text = f"Сет <b>№{setlist_id} - {name}</b>\n\n{song_list}:"
    update.message.reply_text(text, parse_mode=ParseMode.HTML, reply_markup=reply_markup)


def callback_handler(update: Update, context: CallbackContext):
    query = update.callback_query
    if not query or not query.data:
        logger.warning("CallbackQuery пустой или без data")
        return

    data = query.data
    
    try:
        query.answer()
        
        # Обрабатываем callback'и для /song команды
        if data.startswith("toggle_lyrics_song_"):
            logger.info(f"Получен callback для переключения текста: {query.data}")
            
            # Формат: toggle_lyrics_song_{song_id}_{show_lyrics}
            parts = data.split("_")
            if len(parts) < 4:
                query.edit_message_text("Неверный формат callback.")
                return
            
            song_id = int(parts[3])
            # Если есть 5 частей, значит есть состояние (show_lyrics), иначе по умолчанию False
            if len(parts) >= 5:
                show_lyrics = parts[4] == "1"
            else:
                show_lyrics = False
            
            song = fetch_song_by_id(song_id)
            if not song:
                query.edit_message_text("Песня не найдена.")
                return
            
            # Переключаем состояние
            new_show_lyrics = not show_lyrics
            lyrics_button_text = "📖 Свернуть текст" if new_show_lyrics else "📖 Развернуть текст"
            lyrics_callback = f"toggle_lyrics_song_{song_id}_{1 if new_show_lyrics else 0}"
            
            keyboard = [[InlineKeyboardButton(lyrics_button_text, callback_data=lyrics_callback)]]
            reply_markup = InlineKeyboardMarkup(keyboard)
            
            query.edit_message_text(
                format_song(song, show_lyrics=new_show_lyrics),
                parse_mode=ParseMode.HTML,
                disable_web_page_preview=True,
                reply_markup=reply_markup,
            )
            return
        
        # Обрабатываем callback'и для сетов
        elif data.startswith("set_") or data.startswith("setmenu_"):
            logger.info(f"Получен callback для сета: {query.data}")
            
            if data.startswith("set_") and not data.startswith("setmenu_"):
                parts = data.split("_")
                if len(parts) == 3:
                    # set_{setlist_id}_{idx} - обычный переход к песне
                    _, setlist_id, idx = parts
                    setlist_id = int(setlist_id)
                    idx = int(idx)
                    songs = get_setlist_songs(setlist_id)
                    if not songs or idx < 0 or idx >= len(songs):
                        query.edit_message_text("Песня не найдена в сете.")
                        return
                    song = songs[idx]
                    total = len(songs)
                    show_lyrics = False
                elif len(parts) == 4:
                    # set_{setlist_id}_{idx}_{show_lyrics} - переключение текста или навигация
                    _, setlist_id, idx, show_lyrics_str = parts
                    setlist_id = int(setlist_id)
                    idx = int(idx)
                    # show_lyrics_str содержит новое состояние (1 = показать, 0 = скрыть)
                    show_lyrics = show_lyrics_str == "1"
                    songs = get_setlist_songs(setlist_id)
                    if not songs or idx < 0 or idx >= len(songs):
                        query.edit_message_text("Песня не найдена в сете.")
                        return
                    song = songs[idx]
                    total = len(songs)
                else:
                    query.edit_message_text("Неверный формат callback.")
                    return
                
                keyboard = []
                # Кнопка развернуть/свернуть текст (первая)
                lyrics_button_text = "📖 Свернуть текст" if show_lyrics else "📖 Развернуть текст"
                lyrics_callback = f"set_{setlist_id}_{idx}_{1 if not show_lyrics else 0}"
                keyboard.append(
                    [
                        InlineKeyboardButton(
                            lyrics_button_text, callback_data=lyrics_callback
                        )
                    ]
                )
                # Кнопка Назад (если есть песни перед текущей)
                if idx > 0:
                    keyboard.append(
                        [
                            InlineKeyboardButton(
                                "⬅️ Предыдущая", callback_data=f"set_{setlist_id}_{idx - 1}_{1 if show_lyrics else 0}"
                            )
                        ]
                    )
                # Кнопка К списку
                keyboard.append(
                    [
                        InlineKeyboardButton(
                            "🔙 К списку", callback_data=f"setmenu_{setlist_id}"
                        )
                    ]
                )
                # Кнопка Далее (если есть песни после текущей)
                if idx < total - 1:
                    keyboard.append(
                        [
                            InlineKeyboardButton(
                                "Дальше ➡️", callback_data=f"set_{setlist_id}_{idx + 1}_{1 if show_lyrics else 0}"
                            )
                        ]
                    )
                reply_markup = InlineKeyboardMarkup(keyboard)
                query.edit_message_text(
                    format_song(song, show_lyrics=show_lyrics),
                    parse_mode=ParseMode.HTML,
                    reply_markup=reply_markup,
                    disable_web_page_preview=True,
                )
                logger.info("edit_message_text выполнен")
            
            elif data.startswith("setmenu_"):
                setlist_id = int(data.split("_")[1])
                setlist = get_setlist_by_id(setlist_id)
                if not setlist:
                    query.edit_message_text("Сет не найден.")
                    return
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
                song_list = "\n".join([f"{i + 1}. {song['title']}" for i, song in enumerate(songs)])
                text = f"Сет <b>№{setlist_id} - {setlist['name']}</b>\n\n{song_list}:"
                query.edit_message_text(text, parse_mode=ParseMode.HTML, reply_markup=reply_markup)
                logger.info("edit_message_text (меню) выполнен")

    except Exception as e:
        logger.exception("Ошибка в callback_handler")
        try:
            query.edit_message_text(f"Произошла ошибка: {repr(e)}")
        except:
            logger.error("Не удалось отредактировать сообщение об ошибке")


def sets_command(update: Update, context: CallbackContext):
    setlists = fetch_all_setlists()
    if not setlists:
        update.message.reply_text("Сетов не найдено.")
        return
    
    parts = []
    for setlist in setlists:
        song_count = setlist.get("song_count", 0)
        parts.append(f"<b>№{setlist['id']}</b> - {setlist['name']} ({song_count} песен)")
    
    text = "<b>Список сетов:</b>\n\n" + "\n".join(parts)
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def set_command(update: Update, context: CallbackContext):
    args = context.args
    if not args or not args[0].isdigit():
        update.message.reply_text("Используйте: /set <id>")
        return
    
    setlist_id = int(args[0])
    setlist = get_setlist_by_id(setlist_id)
    if not setlist:
        update.message.reply_text("Сет не найден.")
        return
    
    songs = get_setlist_songs(setlist_id)
    if not songs:
        update.message.reply_text(f"Сет <b>№{setlist_id} - {setlist['name']}</b> пуст.", parse_mode=ParseMode.HTML)
        return
    
    keyboard = [
        [
            InlineKeyboardButton(
                f"{i + 1}. {song['title']}", callback_data=f"set_{setlist_id}_{i}"
            )
        ]
        for i, song in enumerate(songs)
    ]
    reply_markup = InlineKeyboardMarkup(keyboard)
    
    song_list = "\n".join([f"{i + 1}. {song['title']}" for i, song in enumerate(songs)])
    text = f"Сет <b>№{setlist_id}: {setlist['name']}</b>\n\n{song_list}"
    update.message.reply_text(text, parse_mode=ParseMode.HTML, reply_markup=reply_markup)


def delset_command(update: Update, context: CallbackContext):
    if not context.args or not context.args[0].isdigit():
        update.message.reply_text("Используйте: /delset <id>")
        return
    setlist_id = int(context.args[0])
    from db import delete_setlist

    delete_setlist(setlist_id)
    update.message.reply_text(f"Сет №{setlist_id} удалён.")


def main():
    updater = Updater(BOT_TOKEN, use_context=True)
    dp = updater.dispatcher

    dp.add_handler(CommandHandler("start", start_command))
    dp.add_handler(CommandHandler("songs", songs_command))
    dp.add_handler(CommandHandler("song", song_command, pass_args=True))
    dp.add_handler(CommandHandler("search", search_command, pass_args=True))
    dp.add_handler(CommandHandler("newset", newset_command, pass_args=True))
    dp.add_handler(CommandHandler("sets", sets_command))
    dp.add_handler(CommandHandler("set", set_command, pass_args=True))
    dp.add_handler(CommandHandler("delset", delset_command, pass_args=True))
    dp.add_handler(CallbackQueryHandler(callback_handler))

    updater.start_polling(allowed_updates=["message", "callback_query"])
    updater.idle()
