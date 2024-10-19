import os
import platform
import sys

from sqlalchemy import text
from utils import query_db, execute_db

current_directory = os.getcwd()
if platform.system()=="Windows":
    dividers = '\\'
else:
    dividers = '/'




def check_db_schema():
    schema_exists = True
    try:
        query = query_db(f"SELECT id FROM control_table")
    except:
        schema_exists = False
    return schema_exists

def read_file(file):
    with open(file, 'r') as f:
        sql_text = f.read()
    return sql_text


def check_add_schema():
    if check_db_schema():
        print('Schema already exists.  Exiting!')
        sys.exit()
    schema_file = current_directory + dividers + 'db_schema' + dividers + 'version_1.0.1_schema.sql'
    schema_sql = read_file(schema_file)
    execute_db(schema_sql)


if __name__ == '__main__':
    check_add_schema()
