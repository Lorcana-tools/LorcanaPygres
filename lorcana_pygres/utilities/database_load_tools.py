import httpx

from utilities import query_db, execute_db, sqlalchemy_escape, find_db_ids

BASE_URL = 'https://api.lorcana-api.com'


endpoints = {'bulk_sets': '/bulk/sets', 'bulk_cards': '/bulk/cards', 'single_set': '/sets', 'single_card': '/cards'}

VERBOSE_PRINT = True


class SetNames():
    def __init__(self):
        self.all_sets = {}
        self.get_sets_from_db()
    def get_sets_from_db(self):
        query = query_db(f"SELECT id, set_name FROM set_names WHERE is_active = True")
        if len(query) != 0:
            i = 0
            while i < len(query):
                set_id, set_name = int(query['id'][i]), query['set_name'][i]
                self.all_sets[set_name] = set_id
                i += 1





async def httpx_get(url):
    async with httpx.AsyncClient() as client:
        r = await client.get(url=url, timeout=10)
    return r




async def get_all_set_names():
    url = BASE_URL + endpoints['bulk_sets']
    response = await httpx_get(url)
    if response.status_code != 200:
        return None
    try:
        all_data = response.json()
    except:
        return None
    return all_data


async def get_all_cards():
    url = BASE_URL + endpoints['bulk_cards']
    response = await httpx_get(url)
    if response.status_code != 200:
        return None
    try:
        all_data = response.json()
    except:
        return None
    return all_data


async def load_all_set_names_db():
    added, is_success = [], False
    all_sets = await get_all_set_names()
    if all_sets is None:
        return is_success, added
    for set in all_sets:
        set_number = set['Set_Num']
        set_name = set['Name'].replace("'", "''")
        release_date = set['Release_Date']
        card_qty = set['Cards']
        lorcana_api_id = set['Set_ID']
        if len(query_db(f"SELECT id FROM set_names WHERE set_name = '{set_name}'")) == 0:
            sql_execute = f"INSERT INTO set_names(set_number, set_name, release_date, card_qty, lorcana_api_id) VALUES({set_number}, '{set_name}', '{release_date}', {card_qty}, '{lorcana_api_id}')"
            execute_db(sql_execute)
            added.append(set_name)
    is_success = True
    return is_success, added


async def load_all_cards_db():
    all_cards = await get_all_cards()
    if all_cards is None:
        return is_success, added
    for card in all_cards:
        card_name = card['Name']
        card_artists = card['Artist']
        card_set = card['Set_Name']
        card_classes = card.get('Classifications', [])
        card_color = card['Color']
        card_rarity = card['Rarity']
        card_type = card['Type']
        card_variants = card['Card_Variants']
        card_franchise = card['Franchise']
        card_image = card['Image']
        card_cost = card['Cost']
        card_number = card['Card_Num']
        card_inkable = card['Inkable']
        card_api_id = card['Unique_ID']
        card_lore = card.get('Lore', None)
        card_flavor_text = card.get('Flavor_text', None)
        card_strength = card.get('Strength', None)
        card_willpower = card.get('Willpower', None)
        card_body_text = card.get('Body_Text', None)
        artist_ids = get_artists(card_artists)
        class_ids = get_classes(card_classes)
        ink_id = find_db_ids.get_ink_id(card_color)
        rarity_id = find_db_ids.get_rarity_id(card_rarity)
        set_id = find_db_ids.get_card_set_id(card_set)
        type_id = find_db_ids.get_card_type_id(card_type)
        enchanted_exists = exchanted_variant_exists(card_variants)
        franchise_id = find_db_ids.get_card_franchise_id(card_franchise)
        card_row, needs_update = insert_card_db(card_name, card_number, card_inkable, set_id, type_id, rarity_id, ink_id, franchise_id, card_api_id, card_cost, enchanted_exists, card_image)
        if needs_update:
            fill_in_details(card_row, card_lore, card_flavor_text, card_strength, card_willpower, card_body_text, artist_ids, class_ids)
        if VERBOSE_PRINT:
            print(f'Card added - {card_name}')



def fill_in_details(card_row, card_lore, card_flavor_text, card_strength, card_willpower, card_body_text, artist_ids, class_ids):
    if card_body_text:
        card_body_text = card_body_text.replace("'", "''")
        execute_db(f"UPDATE cards SET body_text = '{card_body_text}' WHERE id = {card_row}")
    if card_flavor_text:
        card_flavor_text = card_flavor_text.replace("'", "''")
        execute_db(f"UPDATE cards SET flavor_text = '{card_flavor_text}' WHERE id = {card_row}")
    if card_lore:
        execute_db(f"UPDATE cards SET lore_value = {card_lore} WHERE id = {card_row}")
    if card_strength:
        execute_db(f"UPDATE cards SET strength = {card_strength} WHERE id = {card_row}")
    if card_willpower:
        execute_db(f"UPDATE cards SET willpower = {card_willpower} WHERE id = {card_row}")
    add_artists(card_row, artist_ids)
    add_classes(card_row, class_ids)
    execute_db(f"UPDATE cards set needs_update = False WHERE id = {card_row}")


def add_artists(card_row, artist_ids):
    for artist in artist_ids:
        query = query_db(f"SELECT id FROM card_artist_map WHERE card = {card_row} AND artist = {artist}")
        if len(query) == 0:
            execute_db(f"INSERT INTO card_artist_map(card, artist) VALUES({card_row}, {artist})")
        else:
            print(f'Artist map already exists for card {card_row}')

def add_classes(card_row, class_ids):
    for class_id in class_ids:
        query = query_db(f"SELECT id FROM card_classification_map WHERE card = {card_row} AND classification = {class_id}")
        if len(query) == 0:
            execute_db(f"INSERT INTO card_classification_map(card, classification) VALUES({card_row}, {class_id})")
        else:
            print(f'Classification map already exists for card {card_row}')

def insert_card_db(card_name, card_number, card_inkable, set_id, type_id, rarity_id, ink_id, franchise_id, card_api_id, card_cost, enchanted_exists, card_image):
    card_image = card_image.replace("'", "''")
    card_name = card_name.replace("'", "''")
    card_row = query_db(f"SELECT id, needs_update FROM cards WHERE card_name = '{card_name}' AND card_set = {set_id}")
    if len(card_row) == 0:
        execute_db(f"INSERT INTO cards(card_name, card_number, inkable, card_set, card_rarity, card_ink, card_franchise, lorcana_api_id, card_cost, enchanted_variants, image_url, card_type) VALUES('{card_name}', {card_number}, {card_inkable}, {set_id}, {rarity_id}, {ink_id}, {franchise_id}, '{card_api_id}', {card_cost}, {enchanted_exists}, '{card_image}', {type_id})")
        card_row = query_db(f"SELECT id, needs_update FROM cards WHERE card_name = '{card_name}' AND card_set = {set_id}")
    row_id = card_row['id'][0]
    needs_update = bool(card_row['needs_update'][0])
    return row_id, needs_update

def exchanted_variant_exists(card_variants):
    enchanted_exists = False
    if 'enchanted' in card_variants or 'Enchanted' in card_variants:
        enchanted_exists = True
    return enchanted_exists



def get_classes(card_classes):
    if not card_classes:
        return []
    class_ids, all_classes = [], card_classes.split(',')
    for card_class in all_classes:
        class_ids.append(find_db_ids.get_card_classification_id(card_class))
    return class_ids


def get_artists(card_artists):
    artist_ids, all_artists = [], []
    artists = card_artists.split(',')
    for artist in artists:
        more_artists = artist.split('/')
        for m_artist in more_artists:
            all_artists.append(m_artist)
    for artist in all_artists:
        artist_id = find_db_ids.get_artist_id(artist.strip())
        artist_ids.append(artist_id)
    return artist_ids