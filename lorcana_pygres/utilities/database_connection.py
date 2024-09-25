import os
import pandas.io.sql as psql

from dotenv import load_dotenv
from sqlalchemy import create_engine, text

load_dotenv()

# Database connection parameters
DB_HOST = os.getenv('db_server')
DB_PORT = os.getenv('db_port')
DB_USER = os.getenv('db_user')
DB_PASSWORD = os.getenv('db_password')
DB_NAME = os.getenv('db_name')

db_uri = f'postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'


def execute_db(query):
    clean_query = sqlalchemy_escape(query)
    engine = create_engine(db_uri, pool_size=10, max_overflow=20)
    with engine.connect() as conn, conn.begin():
        conn.execute(text(clean_query))
    engine.dispose()

def query_db(query):
    engine = create_engine(db_uri)
    response = psql.read_sql_query(query, con=engine)
    engine.dispose()
    return response




def sqlalchemy_escape(sql_string):
    fixed_string = sql_string.replace('%', '%%').replace("'", "''")
    return fixed_string