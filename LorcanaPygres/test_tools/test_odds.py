from utilities.random_pack import foil_slot_enchanted, rare_srare_legendary
from utilities import build_menu, convert_float_to_percent_string

def test_foil_odds(test_value=None):
    win_count = 0
    if not test_value:
        menu_options = ['100', '1000', '100_000', '1_000_000', '10_000_000', '100_000_000', '1_000_000_000']
        selection = int(input(build_menu(menu_options))) - 1
        test_value = int(menu_options[selection])
    for i in range(test_value):
        enchanted, drawn_number = foil_slot_enchanted()
        if enchanted
            win_count += 1
    percent_win = convert_float_to_percent_string(win_count / test_value)
    return percent_win



def test_rare_srare_legendary(test_value=None):
    rare, super_rare, legendary = 0, 0, 0
    if not test_value:
        menu_options = ['100', '1000', '100_000', '1_000_000', '10_000_000', '100_000_000', '1_000_000_000']
        selection = int(input(build_menu(menu_options))) - 1
        test_value = int(menu_options[selection])
    for i in range(test_value):
        rarity = rare_srare_legendary()
        if rarity == 'rare':
            rare += 1
        elif rarity == 'super_rare':
            super_rare += 1
        elif rarity == 'legendary':
            legendary += 1
    rare_pct = convert_float_to_percent_string(rare / test_value)
    srare_pct = convert_float_to_percent_string(super_rare / test_value)
    legendary_pct = convert_float_to_percent_string(legendary / test_value)
    return rare_pct, srare_pct, legendary_pct