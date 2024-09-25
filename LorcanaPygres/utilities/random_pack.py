import Fortuna


from utilities import query_db, execute_db, sqlalchemy_escape, build_menu

THE_ANSWER_TO_EVERYTHING = 42


def random_pack(set_name=None):
    if not set_name:
        set_name = display_set_names()
    set_names = get_set_names()
    if set_name not in set_names:
        print(f'"{set_name}" is not a valid Set Name')
        return None
    all_cards = get_all_cards_from_set(set_name)
    selected_cards = select_cards(all_cards)
    return selected_cards


def get_set_names():
    set_names = []
    all_sets = query_db("SELECT set_name FROM card_sets WHERE is_active = True")
    if len(all_sets) == 0:
        return None
    i = 0
    while i < len(all_sets):
        set_name = all_sets['set_name'][i]
        set_names.append(set_name)
        i += 1
    return set_names


def display_set_names():
    fail_count = 0
    set_names = get_set_names()
    while True:
        if fail_count >= 3:
            print('Failed to make a valid selection')
            return None
        option_select = input(build_menu(set_names))
        if not option_select.isnumeric():
            fail_count += 1
            continue
        num_select = int(option_select)
        if num_select < 1 or num_select > len(set_names):
            fail_count += 1
            continue
        menu_item = set_names[num_select - 1]
        break
    return menu_item



def foil_slot_enchanted():
    # Because I wanted to
    drawn_number = Fortuna.random_int(1, 100)
    if drawn_number == THE_ANSWER_TO_EVERYTHING:
        return True, drawn_number
    drawn_number -= 1
    if drawn_number == 0:
        drawn_number = 99
    return False, drawn_number


def foil_slot_rarity(common, uncommon, rare, super_rare, legendary, enchanted):
    is_enchanted, drawn_number = foil_slot_enchanted()
    if is_enchanted:
        card = Fortuna.random_value(enchanted)
        return [card, 'enchanted']
    elif drawn_number > 97:
        card = Fortuna.random_value(legendary)
        return [card, 'legendary']
    elif drawn_number > 92:
        card = Fortuna.random_value(super_rare)
        return [card, 'super_rare']
    elif drawn_number > 77:
        card = Fortuna.random_value(rare)
        return [card, 'rare']
    elif drawn_number > 50:
        card = Fortuna.random_value(uncommon)
        return [card, 'uncommon']
    else:
        card = Fortuna.random_value(common)
        return [card, 'common']








def rare_srare_legendary():
    selected_type = 'rare'
    # Odds based on 2 cards in a pack
    # 17% chance for Legendary in 2 cards
    # 50% chance for super rare in 2 cards
    # The rest are Rare
    drawn_number = Fortuna.random_int(1, 217)
    if drawn_number > 200:
        selected_type = 'legendary'
    elif drawn_number > 150:
        selected_type = 'super_rare'
    return selected_type



def select_cards(all_cards):
    cards_selected = []
    common, uncommon, rare, super_rare, legendary, enchanted = sort_cards(all_cards)
    for i in range(6):
        card = Fortuna.random_value(common)
        cards_selected.append([card, 'common'])
    for i in range(3):
        card = Fortuna.random_value(uncommon)
        cards_selected.append([card, 'uncommon'])
    for i in range(2):
        rarity = rare_srare_legendary()
        if rarity == 'rare':
            card = Fortuna.random_value(rare)
            cards_selected.append([card, 'rare'])
        elif rarity == 'super_rare':
            card = Fortuna.random_value(super_rare)
            cards_selected.append([card, 'super_rare'])
        elif rarity == 'legendary':
            card = Fortuna.random_value(legendary)
            cards_selected.append([card, 'legendary'])
        else:
            print('problem in graceland')
            return
    cards_selected.append(foil_slot_rarity(common, uncommon, rare, super_rare, legendary, enchanted ))
    return pull_cards(cards_selected)


def pull_cards(cards_selected):
    for card in cards_selected:
        card_row = card[0]
        card_name = query_db(f"SELECT card_name FROM cards WHERE id = {card_row}")
        card[0] = card_name['card_name'][0]
    return cards_selected





def get_all_cards_from_set(set_name):
    set_name = sqlalchemy_escape(set_name)
    all_cards_with_rarity = []
    card_query = query_db(f"SELECT cards.id card_row, card_rarity.rarity card_rarity, cards.enchanted_variants FROM cards JOIN card_sets on card_sets.id = cards.card_set JOIN card_rarity on card_rarity.id = cards.card_rarity WHERE card_sets.set_name = '{set_name}' AND cards.banned_card = False AND card_sets.is_active = True")
    if len(card_query) == 0:
        return  all_cards_with_rarity
    i = 0
    while i < len(card_query):
        card_row, card_rarity, enchantable = int(card_query['card_row'][i]), card_query['card_rarity'][i], bool(card_query['enchanted_variants'][i])
        all_cards_with_rarity.append([card_row,card_rarity, enchantable])
        i += 1
    return all_cards_with_rarity

def sort_cards(all_cards):
    common, uncommon, rare, super_rare, legendary, enchanted = [], [], [], [], [], []
    for card in all_cards:
        card_row, card_rarity, enchantable = card[0], card[1], card[2]
        if card_rarity == 'Common':
            common.append(card_row)
        elif card_rarity == 'Uncommon':
            uncommon.append(card_row)
        elif card_rarity == 'Rare':
            rare.append(card_row)
        elif card_rarity == 'Super Rare':
            super_rare.append(card_row)
        elif card_rarity == 'Legendary':
            legendary.append(card_row)
        if enchantable:
            enchanted.append(card_row)
    return common, uncommon, rare, super_rare, legendary, enchanted

