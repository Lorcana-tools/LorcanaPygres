import base64
import httpx
import json
import sys



from datetime import datetime
from pandas import Timestamp
from utils import execute_db, query_db, encrypt_key, decrypt_key

TOKEN_AUTH_URL = 'https://sso.ravensburger.de/token'


def add_initial_token():
    initial_token = input('Enter your Ravensburg Initial Token.  You can find this using MITMProxy with your mobile phone app: ')
    if initial_token == '':
        print('Token not provided.  Exiting!')
        sys.exit()
    encrypted_key = encrypt_key(initial_token)
    encrypted_key = encrypted_key.replace('%', '%%').replace(':', '\\:')
    execute_db(f"INSERT INTO control_table(name, string_value) VALUES('ravensburg_initial_token', '{encrypted_key}')")
    execute_db(f"INSERT INTO control_table(name, string_value) VALUES('ravensburg_current_token', 'Huth S0lo Rules the Metaverse')")
    execute_db(f"INSERT INTO control_table(name, date_value, string_value) VALUES('ravensburg_token_expire', '1999-01-01 00:00:00', 'Huth S0lo Rules the Metaverse')")


async def get_current_token():
    try:
        initial_token = query_db(f"SELECT string_value ravensburg_initial_token FROM control_table WHERE name = 'ravensburg_initial_token'")
    except:
        print('Run database schema import first')
        sys.exit()
    if len(initial_token) == 0:
        add_initial_token()
    ravensburg_initial_token = query_db(f"SELECT string_value ravensburg_initial_token FROM control_table WHERE name = 'ravensburg_initial_token'")
    ravensburg_current_token = query_db(f"SELECT id token_row, string_value ravensburg_current_token FROM control_table WHERE name = 'ravensburg_current_token'")
    ravensburg_token_expire = query_db(f"SELECT id token_row, date_value ravensburg_token_expire FROM control_table WHERE name = 'ravensburg_token_expire'")
    token_row = int(ravensburg_current_token['token_row'][0])
    expire_row = int(ravensburg_token_expire['token_row'][0])
    ravensburg_initial_token = decrypt_key(ravensburg_initial_token['ravensburg_initial_token'][0])
    try:
        ravensburg_current_token = decrypt_key(ravensburg_current_token['ravensburg_current_token'][0])
    except:
        ravensburg_current_token = None
    ravensburg_token_expire = ravensburg_token_expire['ravensburg_token_expire'][0].to_pydatetime()
    current_time = Timestamp.now(tz='utc').to_pydatetime()
    if ravensburg_token_expire > current_time and ravensburg_current_token:
        return ravensburg_current_token
    updated_access_token = await initiate_logon(ravensburg_initial_token)
    if not updated_access_token:
        return None
    decoded_token = decode_jwt(updated_access_token)
    expire_time = datetime.fromtimestamp(decoded_token[1]['exp']).strftime("%Y-%m-%d %H:%M:%S")
    update_token_in_db(token_row, updated_access_token, expire_time, expire_row)
    return updated_access_token


def update_token_in_db(token_row, updated_access_token, expire_time, expire_row):
    encrypted_key = encrypt_key(updated_access_token)
    encrypted_key = encrypted_key.replace('%', '%%').replace(':', '\\:')
    execute_db(f"UPDATE control_table SET string_value = '{encrypted_key}' WHERE id = {token_row}")
    execute_db(f"UPDATE control_table SET date_value = '{expire_time}' WHERE id = {expire_row}")


async def initiate_logon(ravensburg_initial_token):
    headers = {'accept': '*/*',
               'content-type': 'application/x-www-form-urlencoded',
               'authorization': f'Basic {ravensburg_initial_token}',
               'x-unity-version': '2022.3.21f1',
               'user-agent': 'LorcanaTCG/2024.3.0.6851203 CFNetwork/1568.100.1.2.1 Darwin/24.0.0',
               'accept-language': 'en-US,en;q=0.9',
               'accept-encoding': 'gzip, deflate, utf-8'
               }
    form_data = {'grant_type': 'client_credentials'}
    async with httpx.AsyncClient() as client:
        response = await client.post(url=TOKEN_AUTH_URL, headers=headers, data=form_data, timeout=10)
    try:
        token_json = response.json()
        updated_access_token = token_json['access_token']
    except:
        print('Failed to get token - Decode Json Problem')
    return updated_access_token


def base64url_decode(input):
    # Fix padding issue if base64url is missing padding
    input += '=' * (4 - len(input) % 4)
    return base64.urlsafe_b64decode(input)


def decode_jwt(token):
    # Split the JWT into its parts
    header, payload, signature = token.split('.')
    # Decode the header and payload from base64url
    decoded_header = base64url_decode(header).decode('utf-8')
    decoded_payload = base64url_decode(payload).decode('utf-8')
    # Convert the decoded strings into JSON objects
    header_json = json.loads(decoded_header)
    payload_json = json.loads(decoded_payload)
    return header_json, payload_json
