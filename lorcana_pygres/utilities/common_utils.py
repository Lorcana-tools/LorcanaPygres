import os

def clear_screen():
    # for windows
    if os.name == 'nt':
        _ = os.system('cls')
    # for mac and linux(here, os.name is 'posix')
    else:
        _ = os.system('clear')

def build_menu(menu_options):
    clear_screen()
    menu_text = 'Please select from the following options:\n\n'
    i = 1
    for item in menu_options:
        menu_text += f'\n{i}): {item}'
        i += 1
    menu_text += f'\n\n'
    return menu_text

def convert_float_to_percent_string(float_value):
    float_string = str(float_value)
    percent_string = ''
    i = 0
    for number in float_string[2:]:
        if len(percent_string) >= 6:
            break
        elif i == 2:
            percent_string += '.'
        elif i == 0 and number == '0':
            i += 1
            continue
        percent_string += number
        i += 1
    percent_string += '%'
    return percent_string
