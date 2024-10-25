import csv

from utils import query_db, execute_db


def get_known_deck_cards_sorted():
    most_common = []
    query = query_db(f"SELECT DISTINCT card_id AS distinct_cards, count(card_id) count FROM deck_cards card_id GROUP by card_id.card_id order by count DESC")
    if len(query) == 0:
        return most_common
    i = 0
    while i < len(query):
        card, count = int(query['distinct_cards'][i]), int(query['count'][i])
        most_common.append([card, count])
        i += 1
    return most_common


def get_card_with_names_inks():
    top_cards = []
    most_common = get_known_deck_cards_sorted()
    for card in most_common:
        card_id, qty = card[0], card[1]
        query = query_db(f"SELECT cards.name, card_subtitles.subtitle, card_ink.ink_color FROM cards LEFT JOIN card_subtitles on card_subtitles.card_id = cards.id JOIN card_ink on card_ink.id = cards.ink_id WHERE cards.id = {card_id}")
        card_name, subtitle, ink_color = query['name'][0].strip(), query['subtitle'][0], query['ink_color'][0]
        if subtitle:
            card_name = card_name + ' - ' + subtitle.strip()
        top_cards.append([card_name, ink_color, qty])
    return top_cards

def save_list_to_csv(filename, list):
    with open(file_name, 'w', newline='') as file:
        writer = csv.writer(file)
        writer.writerows(list)


# top_cards = get_card_with_names_inks()


def get_all_cards_in_db():
    all_cards = {}
    query = query_db(f"SELECT cards.id card_id, cards.name, card_subtitles.subtitle, cards.ink_id FROM cards LEFT JOIN card_subtitles on card_subtitles.card_id = cards.id")
    if len(query) == 0:
        return all_cards
    i = 0
    while i < len(query):
        card_id, card_name, card_subtitle, ink_id = int(query['card_id'][i]), query['name'][i].strip(), query['subtitle'][i], int(query['ink_id'][i])
        if card_subtitle is not None:
            card_name = card_name + ' - ' + card_subtitle.strip()
        clean_name = card_name.lower().replace("'", '').replace("’", '')
        all_cards[clean_name] = [card_id, ink_id]
        i += 1
    return all_cards

def add_get_deck_row(hashed_string, card_inks):
    ink_one = card_inks[0]
    deck_query = query_db(f"SELECT id deck_row FROM decks WHERE card_composite_hash = '{hashed_string}'")
    if len(deck_query) == 0:
        execute_db(f"INSERT INTO decks(deck_ink1, card_composite_hash) VALUES({ink_one}, '{hashed_string}')")
        deck_query = query_db(f"SELECT id deck_row FROM decks WHERE card_composite_hash = '{hashed_string}'")
        if len(card_inks) > 1:
            ink_two = card_inks[1]
            update_row = int(deck_query['deck_row'][0])
            execute_db(f"UPDATE decks SET deck_ink2 = {ink_two} WHERE id = {update_row}")
    deck_row = int(deck_query['deck_row'][0])
    return deck_row


def add_deck_and_cards_to_db(cards_to_add, hashed_string, card_inks):
    deck_row = add_get_deck_row(hashed_string, card_inks)
    cards_counted = [*cards_to_add]
    for card in cards_counted:
        card_count = cards_to_add[card]
        card_row_query = query_db(f"SELECT id FROM deck_cards WHERE deck_id = {deck_row} AND card_id = {card}")
        if len(card_row_query) != 0:
            continue
        execute_db(f"INSERT INTO deck_cards(deck_id, card_id, quantity) VALUES({deck_row}, {card}, {card_count})")
    execute_db(f"UPDATE decks SET deck_complete = True WHERE id = {deck_row}")
    return

def get_completed_decks():
    completed_decks = []
    query = query_db(f"SELECT card_composite_hash FROM decks WHERE deck_complete = True")
    if len(query) == 0:
        return completed_decks
    i = 0
    while i < len(query):
        completed_deck = query['card_composite_hash'][i]
        completed_decks.append(completed_deck)
        i += 1
    return completed_decks

def break_up_card_identifier(card_identifier):
    card_number = card_identifier.split('/')[0]
    if card_number.isnumeric():
        card_number = int(card_number)
    card_set = card_identifier.split()[-1]
    if card_set.isnumeric():
        card_set = int(card_set)
    return card_set, card_number



def make_cards_consistent(card_name):
    clean_name = card_name.lower().replace("'", '').replace("’", '')
    return clean_name



def lookup_card_details_by_row(card_row):
    query = query_db(f"SELECT cards.name, card_subtitles.subtitle, card_ink.ink_color, cards.card_identifier, cards.ink_convertible, cards.ink_cost FROM cards LEFT JOIN card_subtitles on card_subtitles.card_id = cards.id JOIN card_ink on card_ink.id = cards.ink_id WHERE cards.id = {card_row}")
    card_name, card_subtitle, ink_color, card_identifier, ink_cost, inkable = query['name'][0].strip(), query['subtitle'][0], query['ink_color'][0], query['card_identifier'][0], int(query['ink_cost'][0]), bool(query['ink_convertible'][0])
    if card_subtitle is not None:
        card_name = card_name + ' - ' + card_subtitle.strip()
    card_set, card_number = break_up_card_identifier(card_identifier)
    return card_name, ink_color, card_set, card_number, ink_cost, inkable
