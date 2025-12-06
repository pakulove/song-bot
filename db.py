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


def create_setlist(name, song_ids):
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute(
                "INSERT INTO setlists (name) VALUES (%s) RETURNING id;", (name,)
            )
            setlist_id = cur.fetchone()["id"]
            for order, song_id in enumerate(song_ids):
                cur.execute(
                    "INSERT INTO setlist_songs (setlist_id, song_id, song_order) VALUES (%s, %s, %s)",
                    (setlist_id, song_id, order),
                )
            conn.commit()
            return setlist_id


def get_setlist_songs(setlist_id):
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT s.* FROM setlist_songs ss JOIN songs s ON ss.song_id = s.id WHERE ss.setlist_id = %s ORDER BY ss.song_order",
                (setlist_id,),
            )
            rows = cur.fetchall()
            # Преобразуем к списку dict, чтобы не было Ellipsis
            return [dict(row) for row in rows]


def delete_setlist(setlist_id):
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute("DELETE FROM setlists WHERE id = %s", (setlist_id,))
            conn.commit()


def fetch_all_setlists():
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute(
                "SELECT s.id, s.name, s.created_at, COUNT(ss.song_id) as song_count "
                "FROM setlists s "
                "LEFT JOIN setlist_songs ss ON s.id = ss.setlist_id "
                "GROUP BY s.id, s.name, s.created_at "
                "ORDER BY s.id"
            )
            rows = cur.fetchall()
            return [dict(row) for row in rows]


def get_setlist_by_id(setlist_id):
    with get_conn() as conn:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM setlists WHERE id = %s", (setlist_id,))
            row = cur.fetchone()
            return dict(row) if row else None