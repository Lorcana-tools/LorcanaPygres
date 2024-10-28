import os
import sqlalchemy

import pandas.io.sql as psql

from dotenv import load_dotenv

load_dotenv()



def create_engine():
    db_server = os.getenv('db_server')
    db_port = os.getenv('db_port')
    db_name = os.getenv('db_name')
    db_user = os.getenv('db_user')
    db_secret = os.getenv('db_secret')
    db_url = f'postgresql+psycopg2://{db_user}:{db_secret}@{db_server}:{db_port}/{db_name}'

    # Configure pool_size, max_overflow, and pool_timeout to handle connection loads gracefully
    engine = sqlalchemy.create_engine(
        url=db_url,
        pool_size=20,
        max_overflow=0,
        pool_timeout=30,
        pool_recycle=1800
    )
    return engine

# Singleton engine instance
engine = create_engine()

def execute_db(query, force_refresh=False):
    with engine.connect() as conn, conn.begin():
        conn.execute(sqlalchemy.text(query))
    if force_refresh:
        refesh_session()


def query_db(query):
    response = psql.read_sql_query(query, con=engine)
    return response



def sqlalchemy_escape(sql_string):
    fixed_string = sql_string.replace('%', '%%').replace("'", "''")
    return fixed_string

def refesh_session():
    global engine
    engine.dispose()
    engine = create_engine()
