"""Load the signup CSV into SQLite and run the queries in sql/."""

import sqlite3
from pathlib import Path

import pandas as pd

ROOT = Path(__file__).resolve().parent
DATA = ROOT / "data" / "deepgram_plg_cohort-analysttakehome.csv"
DB_PATH = ROOT / "cohort.sqlite"
SQL_DIR = ROOT / "sql"

_con = None


# Open SQLite, load the CSV, and build the accounts view. Reuse the same connection after the first call.
def connect():
    global _con
    if _con is not None:
        return _con
    _con = sqlite3.connect(DB_PATH)
    raw = pd.read_csv(DATA, dtype=str, keep_default_na=False)
    raw.to_sql("signups_raw", _con, index=False, if_exists="replace")
    _con.executescript((SQL_DIR / "accounts.sql").read_text())
    return _con


# Run sql/<name>.sql and return the result as a dataframe.
def q(name):
    sql = (SQL_DIR / f"{name}.sql").read_text()
    return pd.read_sql_query(sql, connect())
