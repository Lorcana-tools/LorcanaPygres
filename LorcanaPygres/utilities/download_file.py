import httpx
import os

from time import sleep
from utilities import query_db, execute_db

if os.name == 'nt':
    folder_separator = '\\'
else:
    folder_separator ='/'

IMAGE_FOLDER = os.getcwd() + folder_separator + 'assets' + folder_separator + 'card_images' + folder_separator
INCLUDE_FOILS = True


def download_file(url, write_location=None):
    response = httpx.get(url=url, timeout=30)
    file = response.content
    if write_location:
        save_file(write_location, file)
        return
    else:
        return file


def save_file(write_location, file):
    with open(write_location, 'wb') as file_writer:
        file_writer.write(file)


def download_all_images():
    all_files = query_db(f"SELECT id card_row, image_url FROM cards WHERE image_downloaded = False")
    if len(all_files) == 0:
        return
    i = 0
    while i < len(all_files):
        sleep(1)
        card_row, image_url = int(all_files['card_row'][i]), all_files['image_url'][i]
        image_name = image_url.split('/')[-1]
        try:
            file = download_file(image_url)
        except:
            sleep(5)
            continue
        write_location = IMAGE_FOLDER + image_name
        save_file(write_location, file)
        if INCLUDE_FOILS:
            sleep(1)
            image_url = image_url[:-4] + '-foil' + image_url[-4:]
            image_name = image_url.split('/')[-1]
            try:
                file = download_file(image_url)
            except:
                sleep(5)
                continue
            write_location = IMAGE_FOLDER + image_name
            save_file(write_location, file)
        execute_db(f"UPDATE cards SET image_downloaded = True WHERE id = {card_row}")
        if i % 10 == 0:
            print(f'{len(all_files) - i} files remaining')
        i += 1
