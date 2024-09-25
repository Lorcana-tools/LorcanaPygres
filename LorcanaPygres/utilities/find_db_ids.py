from .database_connection import query_db, execute_db


def get_artist_id(artist_name):
    artist_name = artist_name.replace("'", "''")
    query = query_db(f"SELECT id FROM artists WHERE artist_name = '{artist_name}'")
    if len(query) == 0:
        execute_db(f"INSERT INTO artists(artist_name) VALUES('{artist_name}')")
        query = query_db(f"SELECT id FROM artists WHERE artist_name = '{artist_name}'")
    artist_id = int(query['id'][0])
    return artist_id


def get_card_classification_id(card_classification):
    card_classification = card_classification.strip()
    query = query_db(f"SELECT id FROM card_classifications WHERE classification = '{card_classification}'")
    class_id = int(query['id'][0])
    return class_id

def get_ink_id(ink_color):
    query = query_db(f"SELECT id FROM card_inks WHERE ink = '{ink_color}'")
    ink_id = int(query['id'][0])
    return ink_id

def get_rarity_id(rarity):
    query = query_db(f"SELECT id FROM card_rarity WHERE rarity = '{rarity}'")
    rarity_id = int(query['id'][0])
    return rarity_id

def get_card_set_id(card_set):
    card_set = card_set.replace("'", "''")
    query = query_db(f"SELECT id FROM card_sets WHERE set_name = '{card_set}'")
    set_id = int(query['id'][0])
    return set_id


def get_card_type_id(card_type):
    query = query_db(f"SELECT id FROM card_types WHERE card_type = '{card_type}'")
    type_id = int(query['id'][0])
    return type_id

def get_card_franchise_id(franchise):
    franchise = franchise.replace("'", "''").strip()
    query = query_db(f"SELECT id FROM disney_franchise WHERE franchise_name = '{franchise}'")
    franchise_id = int(query['id'][0])
    return franchise_id