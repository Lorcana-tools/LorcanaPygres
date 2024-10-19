import Fortuna

def open_pack():
    if Fortuna.random_int(1, 100) == 100:
        return True
    return False

def open_packs(quantity):
    total_enchanted_found = 0
    for i in range(quantity):
        if open_pack():
            total_enchanted_found += 1
    return total_enchanted_found

def open_box(quantity):
    total_enchanted_found, multiple_enchanted = 0, 0
    for i in range(quantity):
        found_in_box = open_packs(24)
        total_enchanted_found += found_in_box
        if found_in_box > 10:
            print(f'Wow - {found_in_box} Enchanted in box number {i + 1}')
            multiple_enchanted += 1
    return total_enchanted_found, multiple_enchanted

def find_box_with_enchanted(quantity_to_find):
    i = 1
    while True:
        total_enchanted_found, multiple_enchanted = open_box(1)
        if total_enchanted_found >= quantity_to_find:
            print(f'{quantity_to_find} found in box number {i}')
            break
        i += 1

find_box_with_enchanted(1)
# 1 found in box number 6
find_box_with_enchanted(2)
# 2 found in box number 66
find_box_with_enchanted(3)
# 3 found in box number 303
find_box_with_enchanted(4)
# 4 found in box number 21859
find_box_with_enchanted(5)
# 5 found in box number 576416
find_box_with_enchanted(6)
# 6 found in box number 214018 <- This had to be a fluke, so I ran it again
find_box_with_enchanted(6)
# 6 found in box number 7373341 <- That seems more like it
find_box_with_enchanted(7)
# 7 found in box number 166586125