import pandas as pd

from utils.db_queries import get_all_cards_in_db, get_known_deck_cards_sorted, lookup_card_details_by_row, make_cards_consistent


def parse_users_deck(user_cards, use_foils=False):
    # Ignores Promo and D23 Cards - Who would want to play with those anyways, amiright!?!
    parsed_cards, card_count = [], 0
    if len(user_cards) == 0:
        return parsed_cards, card_count
    i = 0
    while i < len(user_cards):
        try:
            card_name, card_set, card_number, count, foil = make_cards_consistent(user_cards['Name'][i]), int(user_cards['Set'][i]), int(user_cards['Card Number'][i]), int(user_cards['Normal'][i]), int(user_cards['Foil'][i])
        except:
            i += 1
            continue
        if use_foils:
            count += foil
        card_count += count
        if count == 0:
            i += 1
            continue
        parsed_cards.append([card_name, card_set, card_number, count])
        i += 1
    return parsed_cards, card_count



def get_card_db_rows(csv_file, needs_read, use_foils=False):
    cards_id_and_ink = []
    user_cards = csv_file
    if needs_read:
        user_cards = pd.read_csv(csv_file)
    parsed_cards, card_count = parse_users_deck(user_cards, use_foils)
    cards_in_db = get_all_cards_in_db()
    for card in parsed_cards:
        card_info = cards_in_db.get(card[0], None)
        if card_info is None:
            print(f'Card Missing - {card[0]}')
            continue
        card_row, card_ink, count = card_info[0], card_info[1], card[3]
        cards_id_and_ink.append([card_row, card_ink, count])
    return cards_id_and_ink


def identify_user_card_popularity(user_cards_parsed):
    users_cards_sorted = []
    card_popularity = get_known_deck_cards_sorted()
    for card in card_popularity:
        for user_card in user_cards_parsed:
            if user_card[0] == card[0]:
                users_cards_sorted.append(user_card)
                break
    return users_cards_sorted

def create_csv_of_users_cards_popularity(csv_file, needs_read, use_foils=False):
    card_details = []
    user_cards_parsed = get_card_db_rows(csv_file, needs_read, use_foils)
    users_cards_sorted = identify_user_card_popularity(user_cards_parsed)
    for card in users_cards_sorted:
        card_row, qty = card[0], card[2]
        card_name, ink_color, card_set, card_number, ink_cost, inkable = lookup_card_details_by_row(card_row)
        card_details.append([card_name, card_set, card_number, ink_color, qty, ink_cost, inkable])
    return card_details

def build_csv(concise_card_sort):
    users_cards_dataframe = pd.DataFrame()
    for card in concise_card_sort:
        card_name, card_set, card_number, ink_color, qty, ink_cost, inkable = card[0], card[1], card[2], card[3], card[4], card[5], card[6]
        temp_frame = pd.DataFrame([[card_name, card_set, card_number, ink_color, ink_cost, inkable, qty]], index=None, columns=['Card Name', 'Set Number', 'Card Number', 'Ink Color', 'Ink Cost', 'Inkable', 'Quantity Available'])
        users_cards_dataframe = pd.concat([users_cards_dataframe, temp_frame])
    users_cards_dataframe.reset_index(drop=True, inplace=True)
    return users_cards_dataframe

def create_sorted_csv(input_csv, output_csv, use_foils=False):
    concise_card_sort = create_csv_of_users_cards_popularity(input_csv, True, use_foils)
    users_cards_dataframe = build_csv(concise_card_sort)
    users_cards_dataframe.to_csv(output_csv, index=False)


def deck_builder(input_csv, use_foils):
    concise_card_sort = create_csv_of_users_cards_popularity(input_csv, False, use_foils)
    users_cards_dataframe = build_csv(concise_card_sort)
    return users_cards_dataframe



# input_csv = 'sample_collection.csv'
# output_csv = 'sample_sorted.csv'
# create_sorted_csv(input_csv, output_csv, use_foils=False)

