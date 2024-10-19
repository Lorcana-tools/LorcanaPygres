import httpx
from utils import query_db, execute_db

from KnownValues import KnownValues
from ravensburger_token_auth import get_current_token


RAVENSBURGER_API = 'https://api.lorcana.ravensburger.com/v2'
IMAGES_URL = 'https://api.lorcana.ravensburger.com/images'
ALL_TAGS = ['name', 'subtitle', 'strength', 'willpower', 'quest_value', 'rarity', 'ink_cost', 'author', 'deck_building_id', 'culture_invariant_id', 'sort_number', 'additional_info', 'ink_convertible', 'abilities', 'subtypes', 'flavor_text', 'rules_text', 'card_identifier', 'image_urls', 'foil_mask_url', 'card_sets', 'magic_ink_colors', 'foil_type', 'special_rarity_id', 'deck_building_limit', 'varnish_type', 'varnish_mask_url', 'move_cost']



known_values = KnownValues()


async def get_lorcana_catalog(language='en'):
    current_token = await get_current_token()
    headers = {'accept': '*/*',
               'content-type': 'application/x-www-form-urlencoded',
               'authorization': f'Bearer {current_token}',
               'x-unity-version': '2022.3.21f1',
               'user-agent': 'LorcanaTCG/2024.3.0.6851203 CFNetwork/1568.100.1.2.1 Darwin/24.0.0',
               'accept-language': 'en-US,en;q=0.9',
               'accept-encoding': 'gzip, deflate, utf-8'
               }
    url = f'{RAVENSBURGER_API}/catalog/{language}'
    async with httpx.AsyncClient() as client:
        response = await client.get(url=url, headers=headers, timeout=10)
    try:
        lorcana_catalog = response.json()
    except:
        print('Failed to get catalog')
        return None
    return lorcana_catalog

async def get_image(url):
    current_token = await get_current_token()
    headers = {'accept': '*/*',
               'cache-control': 'public',
               'authorization': f'Bearer {current_token}',
               'x-unity-version': '2022.3.21f1',
               'user-agent': 'LorcanaTCG/2024.3.0.6851203 CFNetwork/1568.100.1.2.1 Darwin/24.0.0',
               'accept-language': 'en-US,en;q=0.9',
               'accept-encoding': 'gzip, deflate, br'
               }
    async with httpx.AsyncClient() as client:
        response = await client.get(url=url, headers=headers, timeout=10)
    file = response.content
    return file


def clean_text(string_value):
    clean_string = string_value.replace('%', '%%').replace("'", "''")
    return clean_string


def get_image_size_id(image_size):
    image_size_id = known_values.get_image_size_id(image_size)
    if not image_size_id:
        execute_db(f"INSERT INTO card_image_sizes(image_size) VALUES({image_size})")
        known_values.trigger_refresh()
        image_size_id = known_values.get_image_size_id(image_size)
    return image_size_id


def add_get_set_type(set_type):
    query = query_db(f"SELECT id set_type_row FROM card_set_types WHERE set_type = '{set_type}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO card_set_types(set_type) VALUES('{set_type}')")
        query = query_db(f"SELECT id set_type_row FROM card_set_types WHERE set_type = '{set_type}'")
    set_type_row = int(query['set_type_row'][0])
    return set_type_row

def add_get_ink_color(ink):
    query = query_db(f"SELECT id set_type_row FROM card_set_types WHERE set_type = '{set_type}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO card_set_types(set_type) VALUES('{set_type}')")
        query = query_db(f"SELECT id set_type_row FROM card_set_types WHERE set_type = '{set_type}'")
    set_type_row = int(query['set_type_row'][0])
    return set_type_row

def get_all_sub_tags(list_of_items):
    all_tags = []
    for item in list_of_items:
        item_tags = [*item]
        for tag in item_tags:
            if tag not in all_tags:
                all_tags.append(tag)
    return all_tags

def get_all_card_tags(catalog):
    all_tags = []
    all_sub_items = [*catalog]
    for sub_item in all_sub_items:
        subitem_tags = get_all_sub_tags(catalog[sub_item])
        for tag_item in subitem_tags:
            if tag_item not in all_tags:
                all_tags.append(tag_item)
    for tag in all_tags:
        if tag not in ALL_TAGS:
            print(f'New Tag Alert! - {tag}')
    return all_tags

def update_sets_db(catalog):
    all_sets = catalog['card_sets']
    for set in all_sets:
        lorcana_id = set['id']
        set_name = clean_text(set['name'])
        sort_number = set['sort_number']
        thumbnail = set['thumbnail_image_url']
        set_type = set['type']
        if len(query_db(f"SELECT id FROM card_sets WHERE set_name = '{set_name}'")) != 0:
            continue
        set_type_row = add_get_set_type(set_type)
        execute_db(f"INSERT INTO card_sets(ravensburg_id, set_name, sort_number, thumbnail_image_url, set_type) VALUES({lorcana_id}, '{set_name}', {sort_number}, '{thumbnail}', {set_type_row})")



def add_get_card_type(card_type):
    query = query_db(f"SELECT id type_id FROM card_types WHERE card_type = '{card_type}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO card_types(card_type) VALUES('{card_type}')")
        query = query_db(f"SELECT id type_id FROM card_types WHERE card_type = '{card_type}'")
    type_id = int(query['type_id'][0])
    return type_id


def add_get_card_subtype(card_subtype):
    if known_values.get_card_subtype_id(card_subtype):
        return known_values.get_card_subtype_id(card_subtype)
    query = query_db(f"SELECT id type_id FROM card_subtypes WHERE card_subtype = '{card_subtype}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO card_subtypes(card_subtype) VALUES('{card_subtype}')")
        query = query_db(f"SELECT id type_id FROM card_subtypes WHERE card_subtype = '{card_subtype}'")
    type_id = int(query['type_id'][0])
    known_values.trigger_refresh()
    return type_id


def get_sub_type_ids(subtypes):
    subtype_ids = []
    for subtype in subtypes:
        subtype_id = add_get_card_subtype(subtype)
        if subtype_id not in subtype_ids:
            subtype_ids.append(subtype_id)
    return subtype_ids

def add_subtype_map(card_id, subtypes):
    subtype_ids = get_sub_type_ids(subtypes)
    for subtype_id in subtype_ids:
        query = query_db(f"SELECT id FROM card_subtype_map WHERE card_subtype = {subtype_id} AND card = {card_id}")
        if len(query) == 0:
            execute_db(f"INSERT INTO card_subtype_map(card_subtype, card) VALUES({subtype_id}, {card_id})")

def add_subtitle(subtitle, card_id):
    if not subtitle:
        return
    if len(query_db(f"SELECT id FROM card_subtitles WHERE card_id = {card_id}")) == 0:
        execute_db(f"INSERT INTO card_subtitles(card_id, subtitle) VALUES({card_id}, '{clean_text(subtitle)}')")

def add_get_ink(ink_color):
    if len(ink_color) == 0:
        ink_color = 'NONE'
    else:
        ink_color = ink_color[0]
    if known_values.get_ink_id(ink_color):
        return known_values.get_ink_id(ink_color)
    query = query_db(f"SELECT id ink_id FROM card_ink WHERE ink_color = '{ink_color}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO card_ink(ink_color) VALUES('{ink_color}')")
        query = query_db(f"SELECT id ink_id FROM card_ink WHERE ink_color = '{ink_color}'")
    ink_id = int(query['ink_id'][0])
    known_values.trigger_refresh()
    return ink_id

def get_add_rarity(rarity):
    if known_values.get_rarity_id(rarity):
        return known_values.get_rarity_id(rarity)
    query = query_db(f"SELECT id rarity_row FROM card_rarities WHERE rarity = '{rarity}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO card_rarities(rarity) VALUES('{rarity}')")
        query = query_db(f"SELECT id rarity_row FROM card_rarities WHERE rarity = '{rarity}'")
    rarity_row = int(query['rarity_row'][0])
    known_values.trigger_refresh()
    return rarity_row


def update_cards(catalog):
    known_cards = get_known_cards()
    i = 0
    all_cards = catalog['cards']
    #all_tags = get_all_card_tags(all_cards)
    card_types = [*all_cards]
    for card_type in card_types:
        card_type_id = known_values.get_card_type_id(card_type)
        if not card_type_id:
            card_type_id = add_get_card_type(card_type)
            known_values.trigger_refresh()
        type_cards = all_cards[card_type]
        for card in type_cards:
            add_update_card(card, known_cards, card_type_id)


def add_card_artist_map(artist_id, card_id):
    if len(query_db(f"SELECT id FROM card_artist_map WHERE artist_id = {artist_id} AND card_id = {card_id}")) != 0:
        return
    execute_db(f"INSERT INTO card_artist_map(artist_id, card_id) VALUES({artist_id}, {card_id})")




def add_update_artists(artists, card_id):
    artists = artists.split('/')
    for artist in artists:
        arist_clean = clean_text(artist.strip())
        artist_id = known_values.get_artist_id(arist_clean)
        if not artist_id:
            query = query_db(f"SELECT id artist_id FROM card_artists WHERE artist_name = '{arist_clean}'")
            if len(query) == 0:
                execute_db(f"INSERT INTO card_artists(artist_name) VALUES('{arist_clean}')")
                query = query_db(f"SELECT id artist_id FROM card_artists WHERE artist_name = '{arist_clean}'")
            artist_id = int(query['artist_id'][0])
            known_values.trigger_refresh()
        add_card_artist_map(artist_id, card_id)


def get_known_cards():
    known_cards = []
    query = query_db(f"SELECT card_identifier FROM cards")
    if len(query) == 0:
        return known_cards
    i = 0
    while i < len(query):
        identifier = query['card_identifier'][i]
        known_cards.append(identifier)
        i += 1
    return known_cards


def add_image_urls(image_urls, card_id):
    for image_url_spec in image_urls:
        image_size = image_url_spec['height']
        image_size_id = get_image_size_id(image_size)
        image_url = image_url_spec['url']
        query = query_db(f"SELECT id FROM card_image_urls WHERE image_url = '{image_url}' AND image_size = {image_size_id} AND card_id = {card_id}")
        if len(query) == 0:
            execute_db(f"INSERT INTO card_image_urls(image_url, image_size, card_id) VALUES('{image_url}', {image_size_id}, {card_id})")


def add_card_set_map(card_sets, card_id):
    for card_set in card_sets:
        if len(query_db(f"SELECT id FROM card_set_map WHERE card_set = {card_set} AND card_id = {card_id}")) == 0:
            execute_db(f"INSERT INTO card_set_map(card_set, card_id) VALUES({card_set}, {card_id})")


def add_update_abilities(abilities, card_id):
    for ability in abilities:
        ability_id = known_values.get_card_ability_id(ability)
        if not ability_id:
            query = query_db(f"SELECT id ability_id FROM card_abilities WHERE ability = '{ability}'")
            if len(query) == 0:
                execute_db(f"INSERT INTO card_abilities(ability) VALUES('{ability}')")
                query = query_db(f"SELECT id ability_id FROM card_abilities WHERE ability = '{ability}'")
            ability_id = int(query['ability_id'][0])
            known_values.trigger_refresh()
        add_card_ability_map(ability_id, card_id)

def add_card_ability_map(ability_id, card_id):
    if not card_id:
        return
    if len(query_db(f"SELECT id FROM card_ability_map WHERE ability_id = {ability_id} AND card_id = {card_id}")) ==0:
        execute_db(f"INSERT INTO card_ability_map(ability_id, card_id) VALUES({ability_id}, {card_id})")


def add_strength(strength, card_id):
    if not strength:
        return
    if len(query_db(f"SELECT id FROM card_strength WHERE card_id = {card_id}")) ==0:
        execute_db(f"INSERT INTO card_strength(strength, card_id) VALUES({strength}, {card_id})")


def add_willpower(willpower, card_id):
    if not willpower:
        return
    if len(query_db(f"SELECT id FROM card_willpower WHERE card_id = {card_id}")) ==0:
        execute_db(f"INSERT INTO card_willpower(willpower, card_id) VALUES({willpower}, {card_id})")

def add_quest_value(quest_value, card_id):
    if not quest_value:
        return
    if len(query_db(f"SELECT id FROM card_quest_value WHERE card_id = {card_id}")) ==0:
        execute_db(f"INSERT INTO card_quest_value(quest_value, card_id) VALUES({quest_value}, {card_id})")

def add_move_cost(move_cost, card_id):
    if not move_cost:
        return
    if len(query_db(f"SELECT id FROM card_move_cost WHERE card_id = {card_id}")) ==0:
        execute_db(f"INSERT INTO card_move_cost(move_cost, card_id) VALUES({move_cost}, {card_id})")


def add_additional_details(additional_info, card_id):
    if len(additional_info) == 0:
        return
    for item in additional_info:
        for info_type in [*item]:
            add_info = clean_text(item[info_type])
            if len(query_db(f"SELECT id FROM card_additional_info WHERE additional_info = '{add_info}' AND info_type = '{info_type}' AND card_id = {card_id}")) == 0:
                execute_db(f"INSERT INTO card_additional_info(additional_info, info_type, card_id) VALUES('{add_info}', '{info_type}', {card_id})")


def add_foil_mask_url(foil_mask_url, card_id):
    if foil_mask_url == '':
        return
    if len(query_db(f"SELECT id FROM foil_mask_urls WHERE card_id = {card_id}")) == 0:
        execute_db(f"INSERT INTO foil_mask_urls(foil_mask_url, card_id) VALUES('{foil_mask_url}', {card_id})")


def add_flavor_text(flavor_text, card_id):
    if flavor_text == '':
        return
    if len(query_db(f"SELECT id FROM card_flavor_text WHERE card_id = {card_id}")) == 0:
        execute_db(f"INSERT INTO card_flavor_text(flavor_text, card_id) VALUES('{flavor_text}', {card_id})")


def add_rules_text(rules_text, card_id):
    if rules_text == '':
        return
    if len(query_db(f"SELECT id FROM card_rules_text WHERE card_id = {card_id}")) == 0:
        execute_db(f"INSERT INTO card_rules_text(card_rules, card_id) VALUES('{rules_text}', {card_id})")

def add_foil_type_map(foil_type, card_id):
    if not foil_type or foil_type.lower() == 'none':
        return
    foil_type_id = known_values.get_foil_type_id(foil_type)
    if foil_type_id is None:
        execute_db(f"INSERT INTO foil_types(foil_type) VALUES('{foil_type}')")
        known_values.trigger_refresh()
        foil_type_id = known_values.get_foil_type_id(foil_type)
    if len(query_db(f"SELECT id FROM foil_type_map WHERE card_id = {card_id}")) == 0:
        execute_db(f"INSERT INTO foil_type_map(foil_type, card_id) VALUES({foil_type_id}, {card_id})")

def add_special_rarity(special_rarity_id, card_id):
    if not special_rarity_id:
        return
    if len(query_db(f"SELECT id FROM special_rarity WHERE card_id = {card_id}")) == 0:
        execute_db(f"INSERT INTO special_rarity(special_rarity_id, card_id) VALUES({special_rarity_id}, {card_id})")


def add_deck_building_limit(deck_building_limit, card_id):
    if not deck_building_limit:
        return
    if len(query_db(f"SELECT id FROM deck_building_limits WHERE card_id = {card_id}")) == 0:
        execute_db(f"INSERT INTO deck_building_limits(deck_building_limit, card_id) VALUES({deck_building_limit}, {card_id})")


def add_varnish_type_map(varnish_type, varnish_mask_url, card_id):
    if not varnish_type:
        return
    if len(query_db(f"SELECT id FROM varnish_type_map WHERE card_id = {card_id}")) != 0:
        return
    varnish_type_id = known_values.get_varnish_type_id(varnish_type)
    if not varnish_type_id:
        execute_db(f"INSERT INTO varnish_types(varnish_type) VALUES('{varnish_type}')")
        known_values.trigger_refresh()
        varnish_type_id = known_values.get_varnish_type_id(varnish_type)
    execute_db(f"INSERT INTO varnish_type_map(varnish_type, card_id) VALUES({varnish_type_id}, {card_id})")
    execute_db(f"INSERT INTO varnish_mask_urls(card_id, varnish_mask_url) VALUES({card_id}, '{varnish_mask_url}')")


def add_card(name, rarity_id, ink_id, ink_cost, deck_building_id, culture_invariant_id, sort_number, ink_convertible, card_identifier, card_type_id):
    query = query_db(f"SELECT id card_id, details_loaded FROM cards WHERE card_identifier = '{card_identifier}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO cards(name, rarity, ink_id, ink_cost, deck_building_id, culture_invariant_id, sort_number, ink_convertible, card_identifier, card_type) VALUES('{name}', {rarity_id}, {ink_id}, {ink_cost}, '{deck_building_id}', {culture_invariant_id}, {sort_number}, {ink_convertible}, '{card_identifier}', {card_type_id})")
        query = query_db(f"SELECT id card_id, details_loaded FROM cards WHERE card_identifier = '{card_identifier}'")
    card_id, completed = int(query['card_id'][0]), bool(query['details_loaded'][0])
    return card_id, completed

def mark_details_updated(card_id):
    execute_db(f"UPDATE cards SET details_loaded = True WHERE id = {card_id}")


def add_update_card(card, known_cards, card_type_id):
    card_identifier = card['card_identifier']
    if card_identifier in known_cards:
        return
    name = clean_text(card['name'])
    rarity = card['rarity']
    ink_cost = card['ink_cost']
    author = clean_text(card['author'])
    deck_building_id = card['deck_building_id']
    culture_invariant_id = card['culture_invariant_id']
    sort_number = card['sort_number']
    ink_convertible = card['ink_convertible']
    abilities = card['abilities']
    subtypes = card['subtypes']
    card_sets = card['card_sets']
    magic_ink_colors = card['magic_ink_colors']
    subtitle = card.get('subtitle', None)
    additional_info = card['additional_info']  # List
    foil_mask_url = card.get('foil_mask_url', '')
    flavor_text = clean_text(card.get('flavor_text', ''))
    rules_text = clean_text(card.get('rules_text', ''))
    image_urls = card['image_urls']  # List
    strength = card.get('strength', None)
    willpower = card.get('willpower', None)
    quest_value = card.get('quest_value', None)
    foil_type = card.get('foil_type', None)
    special_rarity_id = card.get('special_rarity_id', None)
    deck_building_limit = card.get('deck_building_limit', None)
    varnish_type = card.get('varnish_type', None)
    varnish_mask_url = card.get('varnish_mask_url', None)
    move_cost = card.get('move_cost', None)
    ink_id = add_get_ink(magic_ink_colors)
    rarity_id = get_add_rarity(rarity)
    card_id, completed = add_card(name, rarity_id, ink_id, ink_cost, deck_building_id, culture_invariant_id, sort_number, ink_convertible, card_identifier, card_type_id)
    if completed:
        return
    add_update_abilities(abilities, card_id)
    add_subtype_map(card_id, subtypes)
    add_subtitle(subtitle, card_id)
    add_update_artists(author, card_id)
    add_card_set_map(card_sets, card_id)
    add_additional_details(additional_info, card_id)
    add_foil_mask_url(foil_mask_url, card_id)
    add_flavor_text(flavor_text, card_id)
    add_rules_text(rules_text, card_id)
    add_image_urls(image_urls, card_id)
    add_strength(strength, card_id)
    add_willpower(willpower, card_id)
    add_quest_value(quest_value, card_id)
    add_foil_type_map(foil_type, card_id)
    add_special_rarity(special_rarity_id, card_id)
    add_deck_building_limit(deck_building_limit, card_id)
    add_varnish_type_map(varnish_type, varnish_mask_url, card_id)
    add_move_cost(move_cost, card_id)
    mark_details_updated(card_id)


# ToDO = All functions below need work



def extract_search_filters(catalog):
    all_search_filters = catalog['search_filters']


def extract_special_rarities(catalog):
    all_special_rarities = catalog['special_rarities']


def extract_hero_graphics_phone_image_url(catalog):
    all_phone_urls = catalog['hero_graphic_phone_image_url']

def extract_hero_graphic_tablet_image_url(catalog):
    all_tablet_urls = catalog['hero_graphic_tablet_image_url']

def extract_news(catalog):
    all_news = catalog['news']


def save_file(write_location, file):
    with open(write_location, 'wb') as file_writer:
        file_writer.write(file)


async def run_full_db_sync():
    catalog = await get_lorcana_catalog()
    update_sets_db(catalog)
    update_cards(catalog)


# Before running sync, you must have an initial token in your control table.
# You can find this by using MITMProxy against your ravensburg handheld app

if __name__ == '__main__':
    import asyncio
    asyncio.run(run_full_db_sync())

