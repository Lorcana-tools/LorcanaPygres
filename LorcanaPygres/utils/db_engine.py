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
    engine = sqlalchemy.create_engine(url=db_url, pool_size=20, max_overflow=0)
    return engine



engine = create_engine()

def execute_db(query):
    with engine.connect() as conn, conn.begin():
        conn.execute(sqlalchemy.text(query))


def query_db(query):
    response = psql.read_sql_query(query, con=engine)
    return response



def sqlalchemy_escape(sql_string):
    fixed_string = sql_string.replace('%', '%%').replace("'", "''")
    return fixed_string