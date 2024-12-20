import base64
import json
import os

from Crypto.Protocol.KDF import PBKDF2
from Crypto.Cipher import AES
from Crypto.Random import get_random_bytes
from Crypto.Hash import SHA256
from Crypto.Util.Padding import pad
from Crypto.Util.Padding import unpad
from dotenv import load_dotenv

load_dotenv()

COMMON_ENCRYPTION_KEY = os.getenv('db_secret')

def base64Encoding(input):
    dataBase64 = base64.b64encode(input)
    dataBase64P = dataBase64.decode("UTF-8")
    return dataBase64P

def base64Decoding(input):
    return base64.decodebytes(input.encode("ascii"))

def generateSalt32Byte():
    return get_random_bytes(32)

def aesCbcPbkdf2EncryptToBase64(COMMON_ENCRYPTION_KEY, plaintext):
    passwordBytes = COMMON_ENCRYPTION_KEY.encode("ascii")
    salt = generateSalt32Byte()
    PBKDF2_ITERATIONS = 15000
    encryptionKey = PBKDF2(passwordBytes, salt, 32, count=PBKDF2_ITERATIONS, hmac_hash_module=SHA256)
    cipher = AES.new(encryptionKey, AES.MODE_CBC)
    ciphertext = cipher.encrypt(pad(plaintext.encode("ascii"), AES.block_size))
    ivBase64 = base64Encoding(cipher.iv)
    saltBase64 = base64Encoding(salt)
    ciphertextBase64 = base64Encoding(ciphertext)
    return saltBase64 + ":" + ivBase64 + ":" + ciphertextBase64

def aesCbcPbkdf2DecryptFromBase64(ciphertextBase64, use_old=False):
    passwordBytes = COMMON_ENCRYPTION_KEY.encode("ascii")
    data = ciphertextBase64.split(":")
    salt = base64Decoding(data[0])
    iv = base64Decoding(data[1])
    ciphertext = base64Decoding(data[2])
    PBKDF2_ITERATIONS = 15000
    decryptionKey = PBKDF2(passwordBytes, salt, 32, count=PBKDF2_ITERATIONS, hmac_hash_module=SHA256)
    cipher = AES.new(decryptionKey, AES.MODE_CBC, iv)
    decryptedtext = unpad(cipher.decrypt(ciphertext), AES.block_size)
    decryptedtextP = decryptedtext.decode("UTF-8")
    return decryptedtextP

def encrypt_key(skey_json):
    encoded_skey = aesCbcPbkdf2EncryptToBase64(COMMON_ENCRYPTION_KEY, json.dumps(skey_json))
    return encoded_skey

def decrypt_key(encoded_skey):
    decoded_key = json.loads(aesCbcPbkdf2DecryptFromBase64(encoded_skey))
    return decoded_key

def change_password(encoded_skey):
    decoded = json.loads(aesCbcPbkdf2DecryptFromBase64(encoded_skey, True))
    recoded = encrypt_skey(decoded)
    return recoded