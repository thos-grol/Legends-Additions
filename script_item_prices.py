import os
import re
from pathlib import Path
from fnmatch import fnmatch

#CONSTANTS
DIRECTORY_ITEMS = r'C:\Files\Projects\bbros\env_legends\items'
DIRECTORY_OUTPUT = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\scripts\config'
DATA = {}
FILE_BLACKLIST = {
    'ammo.nut', 
    'armor.nut', 
    'armor_upgrade.nut',

    'legend_armor_tabard.nut', 
    'legend_armor_cloak.nut', 
    'legend_armor_upgrade.nut', 
    'legend_armor.nut',
    'legend_cloth_named.nut',
    'legend_named_armor_upgrade.nut',
    'legend_named_armor.nut',

    'legend_helmet_upgrade.nut',
    'legend_helmet.nut',
    'legend_named_helmet_upgrade.nut',

    'accessory.nut',
    'accessory_dog.nut',
    'money_item.nut',
    'anatomist_potion_item.nut',
    'shield.nut',
    'named_shield.nut',
    'spawn_item.nut',
    'trade_jug_02_item.nut',
    'food_item.nut',
    'legend_usable_food.nut',
    'trading_good_item.nut',
    'weapon.nut',
    'named_weapon.nut',
}

PATH_BLACKLIST = {
    'legend_horse_armor',
    'legend_horse_helmets'
}

SUBPATH_BLACKLIST = {
    'legend_horse_armor',
    'legend_horse_helmets'
}

#HELPER FNS

MANUAL_WEAPON_CATEGORIES = {
    'legend_swordstaff.nut' : 'Polearm',
    'legend_named_swordstaff.nut' : 'Polearm',
    'spetum.nut' : 'Polearm',
    'named_spetum.nut' : 'Polearm',
}

MISLABLED_WEAPONS2H = {
    '"weapon.crossbow"',
    '"weapon.masterwork_bow"',
    '"weapon.goblin_heavy_bow"',
}

MISLABLED_WEAPONS1H = {
    '"weapon.goblin_spiked_balls"',
}

PRINT_ORDER = [
    'supplies',
    'trade',
    'tents',
    'spawns',
    'loot',
    'misc',
    'special',
    'rune_sigils',
    'tools',
    'ammo',
    'accessory',
    'weapons',
    'shields',
    'legend_armor',
    'legend_helmets',
]

ARMOR_ORDER = [
    'ARMOR',
    'CLOTH',
    'CHAIN',
    'PLATE',
    'NAMED',
    'LEGENDARY',
    'CLOAK',
    'ARMOR_UPGRADES',
    'RUNES',
]

HELMET_ORDER = [
    'HOOD',
    'HELM',
    'HELMETS',
    'TOP',
    'VANITY',
    'VANITY_LOWER',
    'RUNES',
]

WEAPON_VALUES = {}
ARMOR_VALUES = {}
SHIELD_VALUES = {}

def parseItem(path, name):
    if not name.endswith('.nut') or name in FILE_BLACKLIST: return

    CATEGORIES = getCategories(path, name)
    
    with open(os.path.join(path, name), encoding='utf-8') as file:
        id = None
        value = None
        weapontype = None
        min = None
        max = None
        ap = None
        af = None
        for line in file.readlines():
            if 'this.m.ID = ' in line:
                    query = re.findall(r'"(.+?)"', line)[0]
                    id = f'\"{query}\"'
            if 'this.m.Value = ' in line:
                value = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
            
            if CATEGORIES[0] == 'weapons':
                if 'this.m.WeaponType = ' in line:
                    if name in MANUAL_WEAPON_CATEGORIES:
                        CATEGORIES[1] = MANUAL_WEAPON_CATEGORIES[name]
                        if CATEGORIES[1] not in DATA[CATEGORIES[0]]:
                            DATA[CATEGORIES[0]][CATEGORIES[1]] = {}
                    else:
                        value = re.findall(r'=(.+)', line)[0].replace(';', '').strip()
                        types = value.split('|')
                        # CATEGORIES[1] = types[0].strip()
                        CATEGORIES[1] = types[0].strip().replace('this.Const.Items.WeaponType.', '')
                        if CATEGORIES[1] not in DATA[CATEGORIES[0]]:
                            DATA[CATEGORIES[0]][CATEGORIES[1]] = {}
                if 'this.m.ItemType = ' in line:
                    value = re.findall(r'=(.+)', line)[0].replace(';', '').strip()
                    types = value.split('|')
                    for type in types:
                        if 'OneHanded' in type:
                            weapontype = '1H'
                            break
                        elif 'TwoHanded' in type:
                            weapontype = '2H'
                            break
                if 'this.m.RegularDamage = ' in line:
                    min = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                if 'this.m.RegularDamageMax = ' in line:
                    max = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                if 'this.m.ArmorDamageMult = ' in line:
                    af = float(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                if 'this.m.DirectDamageMult = ' in line:
                    ap = float(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
            
            if CATEGORIES[0] == 'shields':
                # this.m.MeleeDefense = 20;
                # this.m.RangedDefense = 15;
                # this.m.StaminaModifier = -14;
                # this.m.ConditionMax = 32;
                if min is None and 'this.m.MeleeDefense = ' in line:
                    min = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                if max is None and 'this.m.RangedDefense = ' in line:
                    max = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                if af is None and 'this.m.StaminaModifier = ' in line:
                    af = float(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                if ap is None and 'this.m.ConditionMax = ' in line:
                    ap = float(re.findall(r'=(.+)', line)[0].replace(';', '').strip())

            if CATEGORIES[0] == 'legend_armor' or CATEGORIES[0] == 'legend_helmets':
                if max is None and 'this.m.ConditionMax = ' in line:
                    max = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                if ap is None and 'this.m.StaminaModifier = ' in line:
                        ap = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
                
    if id is None:
        print(name)
    if value is None:
        return
    
    if CATEGORIES[0] == 'weapons':
        if id in MISLABLED_WEAPONS2H:
            weapontype = '2H'
        if id in MISLABLED_WEAPONS1H:
            weapontype = '1H'

        if weapontype is None:
            DATA[CATEGORIES[0]][CATEGORIES[1]][id] = value
        else:
            if weapontype not in DATA[CATEGORIES[0]][CATEGORIES[1]]:
                DATA[CATEGORIES[0]][CATEGORIES[1]][weapontype] = {}
            DATA[CATEGORIES[0]][CATEGORIES[1]][weapontype][id] = value

        if max is not None and min is not None and af is not None and ap is not None:
            WEAPON_VALUES[id] = [min, max, ap, af]
        return
    
    if CATEGORIES[0] == 'shields':
        if max is not None and min is not None and af is not None and ap is not None:
            SHIELD_VALUES[id] = [min, max, ap, af]    
    if CATEGORIES[0] == 'legend_armor' or CATEGORIES[0] == 'legend_helmets':
        if max is not None and ap is not None:
            ARMOR_VALUES[id] = [max, ap]
    
   
        
    DATA[CATEGORIES[0]][CATEGORIES[1]][id] = value
    
def getCategories(path, name):
    #Get file category from path
    tokens = path.replace(r'C:\Files\Projects\bbros\env_legends\items', '')[1:].split('\\')
    CATEGORY = tokens[0]
    SUBCATEGORY = None
    if CATEGORY == 'weapons':
        SUBCATEGORY = 'MAIN'
    else:
        if len(tokens) > 1:
            SUBCATEGORY = tokens[1].upper()
        else: 
            SUBCATEGORY = getSubCategories(CATEGORY, name)
    
    if SUBCATEGORY not in DATA[CATEGORY]:
        DATA[CATEGORY][SUBCATEGORY] = {}
    return [CATEGORY, SUBCATEGORY]

def getSubCategories(CATEGORY, name):
    match CATEGORY:
        case 'accessory':
            if strContains(name, ['wardog', 'warhound', 'warbear', 'wolf', 'falcon', 'cat_']):
                return 'PET'
            elif strContains(name, ['potion', 'flask', 'poison', 'elixir', 'antidote', 'mushroom']):
                return 'POTION'
            elif strContains(name, ['trophy']):
                return 'TROPHY'
            else:
                return 'MAIN'
        case 'supplies':
            if not strContains(name, ['ammo', 'armor', 'medicine']):
                return 'FOOD'
            else:
                return 'MAIN'
    return 'MAIN'

def strContains(str, query):
    for word in query:
        if word in str:
            return True
    return False

def sortByValue(dict):
    return sorted(dict.items(), key = lambda x: x[1])


#PROGRAM START

for MAIN_PATH in os.listdir(DIRECTORY_ITEMS):
    if MAIN_PATH in PATH_BLACKLIST or MAIN_PATH.endswith('.nut'): continue
    if MAIN_PATH == 'armor' or MAIN_PATH == 'helmets' : continue
    DATA[MAIN_PATH] = {}
    SUBPATHQ = []
    
    for path, subdirs, files in os.walk(os.path.join(DIRECTORY_ITEMS, MAIN_PATH)):
        for name in files:
            parseItem(path, name)        

with open(os.path.join(DIRECTORY_OUTPUT, f'Ω_economy_item_prices.nut'), "w+") as f_out:
    f_out.write('::Z.Economy.Items <- {\n')
    for CATEGORY in PRINT_ORDER:
        f_out.write(f'\n//{CATEGORY.upper()}\n')
        
        if CATEGORY == 'weapons':
            #Print MAIN
            SORTED = sortByValue(DATA[CATEGORY]['MAIN'])
            for tuple in SORTED:
                f_out.write(f'\t{tuple[0]} : {tuple[1]},\n')

            #Print SUBCATEGORY but handle 1h/2h
            for SUBCATEGORY in DATA[CATEGORY]:
                if SUBCATEGORY == 'MAIN': continue
                f_out.write('\n')
                f_out.write(f'\t//{SUBCATEGORY.upper()}\n')
                for TYPE in DATA[CATEGORY][SUBCATEGORY]:
                    f_out.write(f'\t//{TYPE.upper()}\n')
                    SORTED = sortByValue(DATA[CATEGORY][SUBCATEGORY][TYPE])
                    for tuple in SORTED:
                        comment = ''
                        if tuple[0] in WEAPON_VALUES:
                            e = WEAPON_VALUES[tuple[0]]
                            comment = f'\t\t//({e[0]:3}, {e[1]:3}) | AP: {e[2]:.2f} | AE: {e[3]:.2f}'
                        mainstr = f'\t{tuple[0]} : {tuple[1]},'
                        f_out.write(f'{mainstr :45}{comment}\n')
            

            continue

        if CATEGORY == 'legend_armor':
            for SUBCATEGORY in ARMOR_ORDER:
                f_out.write('\n')
                f_out.write(f'\t//{SUBCATEGORY.upper()}\n')
                SORTED = sortByValue(DATA[CATEGORY][SUBCATEGORY])
                for tuple in SORTED:
                    comment = ''
                    if tuple[0] in ARMOR_VALUES:
                        e = ARMOR_VALUES[tuple[0]]
                        comment = f'\t\t//DUR: {e[0]:.2f} | STA: {e[1]:.2f}'
                    mainstr = f'\t{tuple[0]} : {tuple[1]},'
                    f_out.write(f'{mainstr :70}{comment}\n')
            continue

        if CATEGORY == 'legend_helmets':
            for SUBCATEGORY in HELMET_ORDER:
                f_out.write('\n')
                f_out.write(f'\t//{SUBCATEGORY.upper()}\n')
                SORTED = sortByValue(DATA[CATEGORY][SUBCATEGORY])
                for tuple in SORTED:
                    comment = ''
                    if tuple[0] in ARMOR_VALUES:
                        e = ARMOR_VALUES[tuple[0]]
                        comment = f'\t\t//DUR: {e[0]:.2f} | STA: {e[1]:.2f}'
                    mainstr = f'\t{tuple[0]} : {tuple[1]},'
                    f_out.write(f'{mainstr :70}{comment}\n')
            continue

        if CATEGORY == 'shields':
            SORTED = sortByValue(DATA[CATEGORY]['MAIN'])
            for tuple in SORTED:
                comment = ''
                if tuple[0] in SHIELD_VALUES:
                    e = SHIELD_VALUES[tuple[0]]
                    comment = f'\t\t//DEF: ({e[0]:3}M, {e[1]:3}R) | DUR: {e[3]:.2f} | STA: {e[2]:.2f}'
                mainstr = f'\t{tuple[0]} : {tuple[1]},'
                f_out.write(f'{mainstr :45}{comment}\n')

            for SUBCATEGORY in DATA[CATEGORY]:
                if SUBCATEGORY == 'MAIN': continue
                if SUBCATEGORY == 'NAMED': continue
                f_out.write('\n')
                f_out.write(f'\t//{SUBCATEGORY.upper()}\n')
                SORTED = sortByValue(DATA[CATEGORY][SUBCATEGORY])
                for tuple in SORTED:
                    comment = ''
                    if tuple[0] in SHIELD_VALUES:
                        e = SHIELD_VALUES[tuple[0]]
                        comment = f'\t\t//DEF: ({e[0]:3}M, {e[1]:3}R) | DUR: {e[3]:.2f} | STA: {e[2]:.2f}'
                    mainstr = f'\t{tuple[0]} : {tuple[1]},'
                    f_out.write(f'{mainstr :45}{comment}\n')
            
            if 'NAMED' in DATA[CATEGORY]:
                f_out.write('\n')
                f_out.write(f'\t//NAMED\n')
                SORTED = sortByValue(DATA[CATEGORY]['NAMED'])
                for tuple in SORTED:
                    comment = ''
                    if tuple[0] in SHIELD_VALUES:
                        e = SHIELD_VALUES[tuple[0]]
                        comment = f'\t\t//DEF: ({e[0]:3}M, {e[1]:3}R) | DUR: {e[3]:.2f} | STA: {e[2]:.2f}'
                    mainstr = f'\t{tuple[0]} : {tuple[1]},'
                    f_out.write(f'{mainstr :45}{comment}\n')
            continue
        
       
        SORTED = sortByValue(DATA[CATEGORY]['MAIN'])
        for tuple in SORTED:
            f_out.write(f'\t{tuple[0]} : {tuple[1]},\n')

        for SUBCATEGORY in DATA[CATEGORY]:
            if SUBCATEGORY == 'MAIN': continue
            if SUBCATEGORY == 'NAMED': continue
            f_out.write('\n')
            f_out.write(f'\t//{SUBCATEGORY.upper()}\n')
            SORTED = sortByValue(DATA[CATEGORY][SUBCATEGORY])
            for tuple in SORTED:
                f_out.write(f'\t{tuple[0]} : {tuple[1]},\n')
        
        if 'NAMED' in DATA[CATEGORY]:
            f_out.write('\n')
            f_out.write(f'\t//NAMED\n')
            SORTED = sortByValue(DATA[CATEGORY]['NAMED'])
            for tuple in SORTED:
                f_out.write(f'\t{tuple[0]} : {tuple[1]},\n')
        

    f_out.write('};')