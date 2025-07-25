from telegram import ParseMode, Update
from telegram.ext import CallbackContext, CommandHandler, Updater

from config import BOT_TOKEN
from db import fetch_song_by_id, fetch_songs


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
    text = "\n".join([format_song_short(song) for song in songs])
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


def main():
    updater = Updater(BOT_TOKEN, use_context=True)
    dp = updater.dispatcher

    dp.add_handler(CommandHandler("songs", songs_command))
    dp.add_handler(CommandHandler("song", song_command, pass_args=True))

    updater.start_polling()
    updater.idle()
