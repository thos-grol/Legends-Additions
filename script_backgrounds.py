import os
import re
from pathlib import Path

#FEATURE_2: function adjustHiringCostBasedOnEquipment()
#FEATURE_2: function getTryoutCost
root = r'C:\Files\Projects\bbros\env_legends\skills\backgrounds'
out = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\scripts\config'
out2 = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\economy\backgrounds'
Backgrounds = {}

MANUAL_HIRING_COSTS = {
    'slave_background.nut' : 190,
    'female_slave_background.nut' : 190,
    'legend_puppet_background.nut' : 0,
}

BACKGROUNDS = {
    'WASTES' : [
        'background.beggar',
        'background.female_beggar',
        'background.cripple',
        'background.gambler',
        'background.pimp',
    ],
    'LABOR' : [
        'background.daytaler',
        'background.female_daytaler',
        'background.farmhand',
        'background.female_farmhand',
        'background.gravedigger',
        'background.miner',
        'background.vagabond',
        'background.eunuch',
        'background.servant',
        'background.female_servant',
        'background.fisherman',
        'background.lumberjack',
        'background.slave',
        'background.ratcatcher',
        'background.refugee',
        'background.messenger',
    ],
    'LAWLESS' : [
        'background.thief',
        'background.female_thief',
        'background.graverobber',
        'background.killer_on_the_run',
        'background.cultist',
    ],
    'RELIGIOUS' : [
        'background.flagellant',
        'background.pacified_flagellant',
        'background.legend_nun',
        'background.monk',
        'background.monk_turned_flagellant',
        'background.legend_dervish',
    ],
    'PERFORMER' : [
        'background.juggler',
        'background.belly_dancer',
        'background.minstrel',
        'background.female_minstrel',
        'background.legend_qiyan',
    ],
    'TRADER' : [
        'background.legend_leech_peddler',
        'background.peddler',
        'background.legend_trader',
    ],
    'SKILLED LABOR' : [
        'background.apprentice',
        'background.butcher',
        'background.female_butcher',
        'background.miller',
        'background.female_miller',
        'background.mason',
    ],
    'CRAFTSMEN' : [
        'background.bowyer',
        'background.female_bowyer',
        'background.tailor',
        'background.female_tailor',
        'background.legend_ironmonger',
        'background.legend_blacksmith',
        'background.legend_herbalist',
        'background.legend_taxidermist',
    ],
    'NATURE' : [
        'background.legend_muladi',
        'background.shepherd',
        'background.poacher',
        'background.houndmaster',
        'background.hunter',
        'background.wildman',
        'background.wildwoman',
        
    ],
    'MIDDLE CLASS' : [
        'background.bastard',
        'background.disowned_noble',
        'background.female_disowned_noble',
        'background.historian',
        'background.legend_inventor',
    ],
    'NOBLE' : [
        'background.adventurous_noble',
        'background.female_adventurous_noble',
        'background.regent_in_absentia',
    ],
    'FODDER' : [
        'background.caravan_hand',
        'background.deserter',
        'background.legend_conscript',
        'background.militia',
        'background.manhunter',
        'background.companion',
    ],
    'SOLDIER' : [
        'background.brawler',
        'background.squire',
        'background.barbarian',
        'background.nomad',
        'background.raider',
        'background.retired_soldier',
        'background.sellsword',
    ],
    'ELITE' : [
        'background.assassin',
        'background.assassin_southern',
        'background.legend_assassin',
        'background.legend_berserker',
    ],
    'CHAMPION' : [
        'background.legend_shieldmaiden',
        
        'background.beast_slayer', #FEATURE_2: combine into monster hunter, disable witchunter background
        'background.witchhunter',
        'background.legend_master_archer',

        'background.paladin',
        'background.hedge_knight',
        'background.legend_crusader',
        'background.gladiator',
        'background.swordmaster',
    ],
    'SPECIAL' : [
        'background.anatomist',
        'background.legend_alchemist',
        'background.legend_vala',
    ],
    'EVENT' : [
        'background.legend_surgeon',
        'background.legend_ranger',
        'background.crusader',
        'background.kings_guard',
        'background.orc_slayer',
    ],
    'ORIGIN' : [
        #Cultists
        'background.legend_husk',
        'background.legend_lurker',
        'background.legend_magister',

        #Militia
        'background.legend_man_at_arms',
        'background.legend_nightwatch',

        #Cabal
        'background.legend_puppet',

        #Noble
        'background.legend_noble_2h',
        'background.legend_noble',
        'background.legend_noble_event',
        'background.legend_noble_ranged',
        'background.legend_noble_shield',

        #Crusader
        'background.legend_pilgrim',

        #Assassin
        'background.legend_bounty_hunter',
    ],
    'IGNORE' : [
        'background.converted_cultist',
        'background.legend_ancient_summoner',
        'background.legend_commander_assassin',
        'background.legend_astrologist',
        'background.legend_commander_beggar',
        'background.legend_commander_beggar_op',
        'background.legend_commander_berserker',
        'background.legend_companion_melee',
        'background.legend_companion_ranged',
        'background.legend_conjurer',
        'background.legend_commander_crusader',
        'background.legend_death_summoner',
        'background.legend_diviner',
        'background.legend_donkey',
        'background.legend_druid',
        'background.legend_commander_druid',
        'background.legend_enchanter',
        'background.legend_entrancer',
        'background.legend_commander_beggar_female',
        'background.legend_female_commander_inventor',
        'background.legend_guildmaster',
        'background.legend_healer',
        'background.legend_horse',
        'background.legend_horserider',
        'background.legend_horse_courser',
        'background.legend_horse_destrier',
        'background.legend_horse_rouncey',
        'background.legend_illusionist',
        'background.legend_commander_inventor',
        'background.legend_lonewolf',
        'background.legend_necromancer',
        'background.legend_necrosavant',
        'background.legend_necro',
        'background.legend_commander_necro',
        'background.legend_commander_noble',
        'background.legend_peddler_commander',
        'background.legend_philosopher',
        'background.legend_premonitionist',
        'background.legend_preserver',
        'background.legend_puppet_master',
        'background.legend_commander_vala',
        'background.legend_warlock',
        'background.legend_warlock_summoner',
        'background.legend_witch',
        'background.legend_commander_witch',
        'background.legend_youngblood',
        'background.legend_commander_trader',
        'background.legend_transmuter',
        'background.legend_commander_ranger',
        'background.legend_runesmith',
        'background.legend_spiritualist',
        'background.mage',
        'background.mage_legend_commander_mage',
        'background.ptr_swordmaster_commander',
        'background.ptr_young_swordmaster_commander',
        'background.legend_cannibal',
    ]

}

def isValidFile(root, fname):
    return fname.endswith('.nut')

def sortTuple(tup):
    # reverse = None (Sorts in Ascending order)
    # key is set to sort using second element of
    # sublist lambda has been used
    return(sorted(tup, key = lambda x: x[1]))

def getPath(id):
    i = 0
    for CATEGORY in BACKGROUNDS:
        if id in BACKGROUNDS[CATEGORY]:
            path = os.path.join(out2, f'{i:02}_{CATEGORY}')
            if not os.path.exists(path):
                os.makedirs(path)
            if CATEGORY != ' IGNORE':
                return path
        i += 1
    return None
    
ALLOWED_FNS = ['onAddEquipment']
def parse(root, fname):
    if fname == 'character_background.nut': return
    with open(os.path.join(root, fname), encoding='utf-8') as file:
        HiringCost = None
        DailyCost = None
        id = None
       

        #first pass to read data
        lines = file.readlines()
        for line in lines:
            if 'this.m.ID' in line:
                    query = re.findall(r'"(.+?)"', line)[0]
                    id = f'\"{query}\"'
            if 'this.m.HiringCost ' in line:
                if fname in MANUAL_HIRING_COSTS:
                    HiringCost = MANUAL_HIRING_COSTS[fname]
                else:
                    HiringCost = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())
            if 'this.m.DailyCost ' in line:
                DailyCost = int(re.findall(r'=(.+)', line)[0].replace(';', '').strip())

        if id is None or HiringCost is None: return
        Backgrounds[id] = {
            "HiringCost" : HiringCost,
            "DailyCost" : DailyCost
        }
        #fn save
        flag_copy = False
        text = []
        for line in lines:
            if not flag_copy and not 'function ' in line: continue
            if id.replace('"', '') in BACKGROUNDS['IGNORE']: continue
            if 'function ' in line:
                flag_copy = True
                try:
                    query = re.findall(r'function (.+)\(\)', line)[0]
                    if not query in ALLOWED_FNS:
                        flag_copy = False
                        continue
                    text.append(f'\to.{query} = function()\n')
                except:
                    query = re.findall(r'function (.+)\((.+)\)', line)[0]
                    if not query[0] in ALLOWED_FNS:
                        flag_copy = False
                        continue
                    text.append(f'\to.{query[0]} = function({query[1]})\n')
            else:
                text.append(line)

        path = getPath(id.replace('"', ''))
        if path is None: return
        with open(os.path.join(path, fname), 'w+') as f_out:
            f_out.write(f'::mods_hookExactClass(\"skills/backgrounds/{fname}\", function(o) ' + '{\n')
            f_out.write(f'\tlocal create = o.create;\n')
            f_out.write(f'\to.create = function()\n')
            f_out.write('\t{\n')
            f_out.write(f'\t\tcreate();\n')
            f_out.write(f'\t\tthis.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;\n')
            f_out.write(f'\t\tthis.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;\n')
            f_out.write('\t}\n')
            f_out.write('\n')

            for line in text:
                f_out.write(line)
        endFlag = False
        with open(os.path.join(path, fname)) as f_out:
            for line in f_out.readlines():
                if '});\n' == line:
                    endFlag = True
        if not endFlag:
            with open(os.path.join(path, fname), 'a') as f_out:
                f_out.write('});\n')

#PROGRAM START
for fname in os.listdir(root):
   if not isValidFile(root, fname): continue
   parse(root, fname)

# Generate background wages - small bug where 2 backgrounds have None hiring cost
# simply just replace in output file

with open(os.path.join(out, f'Ω_economy_background_wages.nut'), "w+") as f_out:    
    f_out.write('::Z.Backgrounds.Wages <- {\n')
    for CATEGORY in BACKGROUNDS:
        if CATEGORY == 'IGNORE': continue
        f_out.write(f'\n\t//{CATEGORY}\n')
        for id in BACKGROUNDS[CATEGORY]:
            name = f'"{id}"'
            f_out.write(f'\t{name}' + ' : {\n')
            f_out.write(f'\t\t"HiringCost" : {Backgrounds[name]["HiringCost"]},\n')
            f_out.write(f'\t\t"DailyCost" : {Backgrounds[name]["DailyCost"]}\n')
            f_out.write('\t},\n')
    f_out.write('};')