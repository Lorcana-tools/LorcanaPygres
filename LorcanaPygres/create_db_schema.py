import os
import platform

from utils import query_db, execute_db

DEBUG = False

current_directory = os.getcwd()
if platform.system()=="Windows":
    dividers = '\\'
else:
    dividers = '/'


def get_latest_db_schema():
    latest_version, file_begin = '0.0.0', 'version'
    directory = current_directory + dividers + 'db_schema' + dividers
    for filename in os.listdir(directory):
        if DEBUG:
            print(latest_version)
        if filename[-4:] == '.sql' and filename[:len(file_begin)] == file_begin:
            name_parts = filename.split('_')
            if name_parts[0] == 'version' and name_parts[2] == 'schema.sql':
                file_version = name_parts[1]
                i, is_higher = 0, False
                file_digits = [int(part) for part in file_version.split('.')]
                latest_digits = [int(part) for part in latest_version.split('.')]
                for digit in file_digits:
                    if digit > latest_digits[i]:
                        is_higher = True
                    i += 1
                if is_higher:
                    latest_version = file_version
    return latest_version


def get_update_files(db_version, desired_version):
    update_files, file_begin, needed_patches = [], 'update', []
    directory = current_directory + dividers + 'db_schema' + dividers
    for filename in os.listdir(directory):
        if filename[:len(file_begin)] == file_begin:
            update_files.append(filename)
    min_version = desired_version
    for file in update_files:
        file_details = file.split('_')
        from_version, to_version = file_details[1], file_details[3][:-4]
        if to_version == min_version:
            needed_patches.append(file)
            min_version = from_version
            if from_version == min_version:
                break
    needed_patches.reverse()
    return needed_patches


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



def check_db_schema_version():
    on_latest = False
    query = query_db(f"SELECT string_value db_version FROM control_table WHERE name = 'db_schema_version'")
    if len(query) != 0:
        latest_db_version = get_latest_db_schema()
        this_db_version = query['db_version'][0]
        if latest_db_version == this_db_version:
            on_latest = True
    return on_latest


def get_db_schema_version():
    query = query_db(f"SELECT string_value db_version FROM control_table WHERE name = 'db_schema_version'")
    existing_version = query['db_version'][0]
    return existing_version


def run_db_upgrade():
    latest_db_version = get_latest_db_schema()
    existing_version = get_db_schema_version()
    needed_patches = get_update_files(existing_version, latest_db_version)
    for patch in needed_patches:
        file_details = patch.split('_')
        from_version, to_version = file_details[1], file_details[3][:-4]
        print(f'Patching Database from version {from_version} to {to_version}!')
        schema_file = current_directory + dividers + 'db_schema' + dividers + patch
        schema_sql = read_file(schema_file)
        execute_db(schema_sql, force_refresh=True)
    execute_db(f"UPDATE control_table SET string_value = '{latest_db_version}' WHERE name = 'db_schema_version'")
    return



def check_add_schema():
    if check_db_schema():
        if not check_db_schema_version():
            run_db_upgrade()
            return
    latest_db_version = get_latest_db_schema()
    schema_file = current_directory + dividers + 'db_schema' + dividers + f'version_{latest_db_version}_schema.sql'
    schema_sql = read_file(schema_file)
    execute_db(schema_sql, force_refresh=True)
    execute_db(f"INSERT INTO control_table(name, string_value) VALUES('db_schema_version', '{latest_db_version}')")
    return

if __name__ == '__main__':
    check_add_schema()
