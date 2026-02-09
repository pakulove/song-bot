from datetime import date
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

from telegram import InlineKeyboardButton, InlineKeyboardMarkup, ParseMode, Update
from telegram.ext import (
    CallbackContext,
    CallbackQueryHandler,
    CommandHandler,
    Dispatcher,
    MessageHandler,
    Filters,
    Updater,
)

from config import BOT_TOKEN
from export import export, EXPORT_PATH
from db import (
    create_setlist,
    fetch_all_setlists,
    fetch_setlist_by_id,
    fetch_song_by_id,
    fetch_songs,
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
        "• /songs — список всех песен\n"
        "• /worship — песни поклонения\n"
        "• /praise— песни прославления\n"
        "• /song номер_или_имя — открыть песню по номеру или названию1\n"
        "• /search текст — поиск по названию, тексту или переводу\n\n"
        "<b>Работа с сетами:</b>\n"
        "• /sets — список всех сетов\n"
        "• /set номер — открыть сет по номеру или вхождению имени\n"
        "• /newset \"имя сета в кавычках\" номера_через_запятую — создать сет\n"
        "• /delset номер — удалить сет\n\n"
        "<b>Работа с файлами:</b>\n"
        "• /export — Выгрузить песни в документ Word\n"
    )
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def export_command(update: Update, context: CallbackContext):
    """Экспорт всех песен в Word и отправка файла пользователю"""
    try:
        update.message.reply_text("Формирование документа, подождите немного...")
        export()
        with open(EXPORT_PATH, "rb") as f:
            filename = f"Песни прославления VoG {date.today().strftime("%d.%m.%Y")}.docx"
            update.message.reply_document(
                document=f,
                filename=filename,
                caption="Успешно!",
            )
    except Exception as e:
        logger.exception("Ошибка при экспорте песен")
        update.message.reply_text(f"Ошибка при экспорте песен: {e}")


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
        f"\n<b>{mode_text}</b> №<code>{song['id']}</code>\n"
        f"BPM: <b>{song['bpm']}</b>\n"
        f"Тональность: <b>{song['key_letter']}</b>\n"
        f"Плэйбэк: {playback}\n"
        f"Аккорды: {chords}\n"
        f"Заметки: {notes}\n"
        f"{separator}"
        f"{lyrics_part}"
    )


def format_song_short(song):
    key = f"{song['key_letter']}"
    title = song['title'].title() if song.get('title') else ""
    title_en = f" ({song['title_en'].title()})" if song.get("title_en") else ""
    return f"{song['id']}. {title}{title_en} — <i>{key} | {song['bpm']} BPM</i>"


def songs_command(update: Update, context: CallbackContext):
    songs = fetch_songs("ORDER BY type, title")
    if not songs:
        update.message.reply_text("Песен не найдено.")
        return
    
    poklonenie = [song for song in songs if song.get("type") == 0]
    proslavlenie = [song for song in songs if song.get("type") == 1]
    
    parts = []
    if proslavlenie:
        parts.append("<b>Прославление:</b>")
        parts.append("\n\n".join([format_song_short(song) for song in proslavlenie]))
    if poklonenie:
        if parts:
            parts.append("")
        parts.append("<b>Поклонение:</b>")
        parts.append("\n\n".join([format_song_short(song) for song in poklonenie]))
    
    text = "\n\n".join(parts)
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def worship_command(update: Update, context: CallbackContext):
    songs = fetch_songs()
    if not songs:
        update.message.reply_text("Песен не найдено.")
        return
    
    poklonenie = [song for song in songs if song.get("type") == 0]
    if not poklonenie:
        update.message.reply_text("Песен поклонения не найдено.")
        return
    
    count = len(poklonenie)
    if count % 10 == 1 and count % 100 != 11:
        count_text = f"Найдено {count} песня:"
    elif count % 10 in [2, 3, 4] and count % 100 not in [12, 13, 14]:
        count_text = f"Найдено {count} песни:"
    else:
        count_text = f"Найдено {count} песен:"
    
    song_list = "\n\n".join([format_song_short(song) for song in poklonenie])
    text = f"{count_text}\n\n{song_list}"
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def praise_command(update: Update, context: CallbackContext):
    songs = fetch_songs()
    if not songs:
        update.message.reply_text("Песен не найдено.")
        return
    
    proslavlenie = [song for song in songs if song.get("type") == 1]
    if not proslavlenie:
        update.message.reply_text("Песен прославления не найдено.")
        return
    
    count = len(proslavlenie)
    if count % 10 == 1 and count % 100 != 11:
        count_text = f"Найдено {count} песня:"
    elif count % 10 in [2, 3, 4] and count % 100 not in [12, 13, 14]:
        count_text = f"Найдено {count} песни:"
    else:
        count_text = f"Найдено {count} песен:"
    
    song_list = "\n\n".join([format_song_short(song) for song in proslavlenie])
    text = f"{count_text}\n\n{song_list}"
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def perform_song(song_id, update: Update):
    """Выполняет открытие песни по ID"""
    
    song = fetch_song_by_id(song_id)
    if not song:
        update.message.reply_text("Песня не найдена.")
        return

    song_id = song['id']
    
    keyboard = [[InlineKeyboardButton("📖 Развернуть текст", callback_data=f"toggle_lyrics_song_{song_id}_0")]]
    reply_markup = InlineKeyboardMarkup(keyboard)
    
    update.message.reply_text(
        format_song(song, show_lyrics=False),
        parse_mode=ParseMode.HTML,
        disable_web_page_preview=True,
        reply_markup=reply_markup,
    )


def song_command(update: Update, context: CallbackContext):
    args = context.args
    if not args:
        # Режим ожидания номера песни
        context.user_data["waiting_for_song"] = True
        update.message.reply_text("Отправьте номер или название песни в следующем сообщении.\nНапример: 21 или \"кровь\"")
        return
    perform_song(args[0], update)
    # Сбрасываем флаг ожидания, если он был установлен
    context.user_data.pop("waiting_for_song", None)


def perform_search(query_text, update: Update):
    """Выполняет поиск песен по запросу"""
    query = query_text.lower()
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


def search_command(update: Update, context: CallbackContext):
    if not context.args:
        # Режим ожидания поискового запроса
        context.user_data["waiting_for_search"] = True
        update.message.reply_text("Отправьте поисковый запрос в следующем сообщении.")
        return
    
    # Режим с аргументами - выполняем поиск сразу
    query = " ".join(context.args)
    perform_search(query, update)
    # Сбрасываем флаг ожидания, если он был установлен
    context.user_data.pop("waiting_for_search", None)


def message_handler(update: Update, context: CallbackContext):
    """Обрабатывает текстовые сообщения, если пользователь ожидает ввод данных"""
    text = update.message.text
    
    # Проверяем ожидание поискового запроса
    if context.user_data.get("waiting_for_search"):
        context.user_data.pop("waiting_for_search", None)
        perform_search(text, update)
        return
    
    # Проверяем ожидание номера песни
    if context.user_data.get("waiting_for_song"):
        context.user_data.pop("waiting_for_song", None)
        perform_song(text, update)
        return
    
    # Проверяем ожидание данных для создания сета
    if context.user_data.get("waiting_for_newset"):
        context.user_data.pop("waiting_for_newset", None)
        perform_newset(text, update)
        return
    
    # Проверяем ожидание номера сета для удаления
    if context.user_data.get("waiting_for_delset"):
        context.user_data.pop("waiting_for_delset", None)
        if text.isdigit():
            perform_delset(int(text), update)
        else:
            update.message.reply_text("Пожалуйста, отправьте число (номер сета).")
        return


def perform_newset(args_str, update: Update):
    """Выполняет создание сета из строки аргументов"""
    name = ""
    ids_part = ""
    
    if args_str.startswith('"'):
        end_quote = args_str.find('"', 1)
        if end_quote == -1:
            update.message.reply_text("Не найдена закрывающая кавычка в имени сета.")
            return
        name = args_str[1:end_quote]
        ids_part = args_str[end_quote + 1:].strip()
    else:
        # Если нет кавычек, пробуем разделить по пробелу
        parts = args_str.split(None, 1)
        if len(parts) < 2:
            update.message.reply_text("Неверный формат. Используйте: \"имя сета\" id1,id2,id3\nНапример: \"18_11_2025\" 1,4,18")
            return
        name = parts[0]
        ids_part = parts[1]
    
    if not name:
        update.message.reply_text("Имя сета не может быть пустым.")
        return
    
    try:
        song_ids = [int(x) for x in ids_part.split(",") if x.strip().isdigit()]
    except Exception:
        update.message.reply_text(
            "Ошибка в формате номеров песен. Пример: \"myset\" 1,2,3"
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
    # Добавляем кнопку "Открыть все"
    keyboard.append([
        InlineKeyboardButton("📄 Открыть все", callback_data=f"setall_{setlist_id}")
    ])
    reply_markup = InlineKeyboardMarkup(keyboard)
    song_list = "\n".join([f"{i + 1}. {song['title']}" for i, song in enumerate(songs)])
    text = f"<b>{setlist_id}. {name}</b> ({len(songs)} песен)\n\n{song_list}"
    update.message.reply_text(text, parse_mode=ParseMode.HTML, reply_markup=reply_markup)


def newset_command(update: Update, context: CallbackContext):
    if not context.args or len(context.args) < 2:
        # Режим ожидания данных для создания сета
        context.user_data["waiting_for_newset"] = True
        update.message.reply_text("Отправьте данные для создания сета в следующем сообщении.\n\nФормат: \"имя сета в кавычках\" id1,id2,id3\nНапример: \"18_11_2025\" 1,4,18")
        return
    
    args_str = " ".join(context.args)
    perform_newset(args_str, update)
    # Сбрасываем флаг ожидания, если он был установлен
    context.user_data.pop("waiting_for_newset", None)


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
        # Сначала проверяем "setall_" (должно быть до "set_", т.к. "setall_" начинается с "set_")
        elif data.startswith("setall_"):
            setlist_id = int(data.split("_")[1])
            setlist = fetch_setlist_by_id(setlist_id)
            if not setlist:
                query.edit_message_text("Сет не найден.")
                return
            songs = get_setlist_songs(setlist_id)
            if not songs:
                query.edit_message_text("Сет пуст.")
                return
            
            # Собираем тексты песен
            songs_with_lyrics = []
            for song in songs:
                lyrics = song.get("lyrics") or ""
                if lyrics:
                    songs_with_lyrics.append(lyrics)
            
            if not songs_with_lyrics:
                query.edit_message_text("В песнях сета нет текстов.")
                return
            
            # Удаляем кнопки из исходного сообщения
            query.edit_message_reply_markup(reply_markup=None)
            
            # Отправляем каждый текст отдельным сообщением
            for lyrics in songs_with_lyrics:
                query.message.reply_text(
                    lyrics,
                    parse_mode=ParseMode.HTML,
                    disable_web_page_preview=True,
                )
            
            logger.info(f"Отправлено {len(songs_with_lyrics)} текстов песен отдельными сообщениями")
        
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
                setlist = fetch_setlist_by_id(setlist_id)
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
                # Добавляем кнопку "Открыть все"
                keyboard.append([
                    InlineKeyboardButton("📄 Открыть все", callback_data=f"setall_{setlist_id}")
                ])
                reply_markup = InlineKeyboardMarkup(keyboard)
                song_list = "\n".join([f"{i + 1}. {song['title']}" for i, song in enumerate(songs)])
                text = f"<b>{setlist_id}. {setlist['name']}</b> ({len(songs)} песен)\n\n{song_list}"
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
        parts.append(f"<b>{setlist['id']}. {setlist['name']}</b> ({song_count} песен)")
    
    text = "\n".join(parts)
    update.message.reply_text(text, parse_mode=ParseMode.HTML)


def set_command(update: Update, context: CallbackContext):
    args = context.args
    if not args:
        update.message.reply_text(
            "Используйте: /set номер_или_часть_имени\nНапример: /set 61 или /set 09.02"
        )
        return

    query = " ".join(args).strip()

    setlist = fetch_setlist_by_id(query)
    if not setlist:
        update.message.reply_text("Сет не найден.")
        return

    setlist_id = setlist["id"]

    songs = get_setlist_songs(setlist_id)
    if not songs:
        update.message.reply_text(f"<b>{setlist_id}. {setlist['name']}</b> пуст.", parse_mode=ParseMode.HTML)
        return
    
    keyboard = [
        [
            InlineKeyboardButton(
                f"{i + 1}. {song['title']}", callback_data=f"set_{setlist_id}_{i}"
            )
        ]
        for i, song in enumerate(songs)
    ]
    # Добавляем кнопку "Открыть все"
    keyboard.append([
        InlineKeyboardButton("📄 Открыть все", callback_data=f"setall_{setlist_id}")
    ])
    reply_markup = InlineKeyboardMarkup(keyboard)
    
    song_list = "\n".join([f"{i + 1}. {song['title']}  —  {song['key_letter']} | {song['bpm']} BPM" for i, song in enumerate(songs)])
    text = f"<b>{setlist_id}. {setlist['name']}</b> ({len(songs)} песен)\n\n{song_list}"
    update.message.reply_text(text, parse_mode=ParseMode.HTML, reply_markup=reply_markup)


def perform_delset(setlist_id, update: Update):
    """Выполняет удаление сета по ID"""
    from db import delete_setlist
    delete_setlist(setlist_id)
    update.message.reply_text(f"Сет №{setlist_id} удалён.", parse_mode=ParseMode.HTML)


def delset_command(update: Update, context: CallbackContext):
    if not context.args or not context.args[0].isdigit():
        # Режим ожидания номера сета для удаления
        context.user_data["waiting_for_delset"] = True
        update.message.reply_text("Отправьте номер сета для удаления в следующем сообщении.\nНапример: 31")
        return
    setlist_id = int(context.args[0])
    perform_delset(setlist_id, update)
    # Сбрасываем флаг ожидания, если он был установлен
    context.user_data.pop("waiting_for_delset", None)


def main():
    updater = Updater(BOT_TOKEN, use_context=True)
    dp = updater.dispatcher

    dp.add_handler(CommandHandler("start", start_command))
    dp.add_handler(CommandHandler("songs", songs_command))
    dp.add_handler(CommandHandler("worship", worship_command))
    dp.add_handler(CommandHandler("praise", praise_command))
    dp.add_handler(CommandHandler("song", song_command, pass_args=True))
    dp.add_handler(CommandHandler("search", search_command, pass_args=True))
    dp.add_handler(CommandHandler("newset", newset_command, pass_args=True))
    dp.add_handler(CommandHandler("sets", sets_command))
    dp.add_handler(CommandHandler("set", set_command, pass_args=True))
    dp.add_handler(CommandHandler("delset", delset_command, pass_args=True))
    dp.add_handler(CommandHandler("export", export_command))
    dp.add_handler(CallbackQueryHandler(callback_handler))
    # Обработчик текстовых сообщений для команд в режиме ожидания (должен быть после CommandHandler)
    dp.add_handler(MessageHandler(Filters.text & ~Filters.command, message_handler))

    updater.start_polling(allowed_updates=["message", "callback_query"])
    updater.idle()
