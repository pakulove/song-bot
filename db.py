import psycopg2
from psycopg2.extras import RealDictCursor

from config import DB_DSN


def get_conn():
    return psycopg2.connect(dsn=DB_DSN, cursor_factory=RealDictCursor)


def fetch_songs():
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM songs ORDER BY id")
            return cur.fetchall()


def fetch_song_by_id(song_id):
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM songs WHERE id = %s", (song_id,))
            return cur.fetchone()
