import os
import re
from pathlib import Path

root = r'C:\Files\Projects\bbros\env_legends\skills\backgrounds'
out = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\scripts\config'
Backgrounds = {}

MANUAL_HIRING_COSTS = {
    'slave_background.nut' : 190,
    'female_slave_background.nut' : 190,
    'legend_puppet_background.nut' : 0,
}

PRESENTATION_ORDER = [
    ['LOW CLASS', 'SKILLED WORKER', 'WARRIOR', 'MIDDLE CLASS', 'UPPER CLASS', 'NOBLE', 'ORIGIN', 'IGNORE'],
    # LOW CLASS
    [
        'background.beggar',
        'background.female_beggar',
        'background.brawler',
        'background.cripple',
        'background.cultist',
        'background.daytaler',
        'background.female_daytaler',
        'background.eunuch',
        'background.farmhand',
        'background.female_farmhand',
        'background.female_servant',
        'background.slave',
        'background.thief',
        'background.female_thief',
        'background.fisherman',
        'background.flagellant',
        'background.pacified_flagellant',
        'background.gambler',
        'background.gravedigger',
        'background.graverobber',
        'background.juggler',
        'background.killer_on_the_run',
        'background.legend_cannibal',
        'background.legend_muladi',
        'background.lumberjack',
        'background.messenger',
        'background.miller',
        'background.female_miller',
        'background.miner',
        'background.pimp',
        'background.poacher',
        'background.vagabond',
        'background.wildman',
        'background.wildwoman',
    ],
    # SKILLED WORKER
    [
        'background.apprentice',
        'background.belly_dancer',
        'background.butcher',
        'background.female_butcher',
        'background.bowyer',
        'background.female_bowyer',
        'background.caravan_hand',
        'background.minstrel',
        'background.female_minstrel',
        'background.tailor',
        'background.female_tailor',
        'background.houndmaster',
        'background.hunter',
        'background.legend_blacksmith',
        'background.legend_herbalist',
        'background.legend_ironmonger',
        'background.legend_leech_peddler',
        'background.legend_nun',
        'background.monk',
        'background.monk_turned_flagellant',
        'background.legend_qiyan',
        'background.legend_trader',
        'background.mason',
        'background.peddler',
        'background.ratcatcher',
        'background.refugee',
        'background.servant',
        'background.shepherd',
        
    ],
    # WARRIOR
    [
        'background.assassin',
        'background.assassin_southern',
        'background.legend_assassin',
        'background.barbarian',
        'background.beast_slayer',
        'background.companion',
        'background.deserter',
        'background.gladiator',
        'background.hedge_knight',
        'background.legend_berserker',
        'background.legend_bounty_hunter',
        'background.legend_conscript',
        'background.legend_crusader',
        'background.legend_dervish',
        'background.legend_shieldmaiden',
        'background.legend_taxidermist',
        'background.manhunter',
        'background.militia',
        'background.nomad',
        'background.paladin',
        'background.raider',
        'background.retired_soldier',
        'background.sellsword',
        'background.squire',
        'background.swordmaster',
        'background.witchhunter',

        #Event Bros
        'background.legend_surgeon',
        'background.legend_ranger',
        'background.crusader',
        'background.kings_guard',
        'background.orc_slayer',
    ],
    # MIDDLE CLASS
    [
        'background.bastard',
        'background.disowned_noble',
        'background.female_disowned_noble',
        'background.historian',
        'background.legend_inventor',
    ],
    # UPPER CLASS
    [
        'background.anatomist',
        'background.legend_alchemist',
        'background.legend_master_archer',
        'background.legend_vala',
    ],
    # NOBLE
    [
        'background.adventurous_noble',
        'background.female_adventurous_noble',
        'background.regent_in_absentia',
    ],
    # ORIGIN
    [
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
        
    ],
    # IGNORE
    [
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
    ]
]

def isValidFile(root, fname):
    return fname.endswith('.nut')

def sortTuple(tup):
    # reverse = None (Sorts in Ascending order)
    # key is set to sort using second element of
    # sublist lambda has been used
    return(sorted(tup, key = lambda x: x[1])) 

def parsePrice(root, fname):
    if fname == 'character_background.nut': return
    with open(os.path.join(root, fname), encoding='utf-8') as file:
        HiringCost = None
        DailyCost = None
        id = None
        Equipment = []
        temp = []

        flag_equip = False
        for line in file.readlines():
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
            
            #TODO Parse legends equipment generation
            if flag_equip:
                if 'this.Math.rand' in line:
                    #start new category
                    if len(temp) > 0:
                        Equipment.append(temp[:])
                        temp.clear()
                if '::new("scripts' in line:
                    if ('ammo' in line): continue
                    query = re.findall(r'"(.+?)"', line)[0]
                    script_path = f'\"{query}\"'
                    if not ('equip', script_path) in temp:
                        temp.append(('equip', script_path))

            if 'function onAddEquipment()' in line:
                flag_equip = True
            if flag_equip and line == '\t}\n':
                flag_equip = False
                if len(temp) > 0:
                        Equipment.append(temp[:])
                        temp.clear()
        
        if HiringCost is None:
            return
        Backgrounds[id] = {
            "HiringCost" : HiringCost,
            "DailyCost" : DailyCost,
            "Equipment" : Equipment
        }

for fname in os.listdir(root):
   if not isValidFile(root, fname): continue
   parsePrice(root, fname)
   
      # do your stuff

# Generate background wages - small bug where 2 backgrounds have None hiring cost
# simply just replace in output file

with open(os.path.join(out, f'Ω_economy_background_wages.nut'), "w+") as f_out:    
    f_out.write('::Z.Backgrounds.Wages <- {\n')
    for key in Backgrounds:
        if key == None: continue
        print(key)
        f_out.write(f'\t{key}' + ' : {\n')
        f_out.write(f'\t\t"HiringCost" : {Backgrounds[key]["HiringCost"]},\n')
        f_out.write(f'\t\t"DailyCost" : {Backgrounds[key]["DailyCost"]}\n')
        f_out.write('\t},\n')

    f_out.write('};')


# Get backgrounds order from file
#TODO: Sort and categorize backgrounds
lst_backgrounds = []
with open(os.path.join(out, f'Ω_economy_background_wages.nut')) as f_out:
    for line in f_out.readlines():
        if '"background.' in line:
            query = re.findall(r'"(.+?)"', line)[0]
            id = f'\"{query}\"'
            lst_backgrounds.append(id)

#TODO: Adapt legends equipment generation
with open(os.path.join(out, f'Ω_economy_background_equipment.nut'), "w+") as f_out:
    f_out.write('::Z.Backgrounds.Equipment <- {};\n')
    for i, key in enumerate(lst_backgrounds):
        if Backgrounds[key]["Equipment"] == []: continue
        f_out.write(f'::Z.Backgrounds.Equipment[{key}]' + ' <- [\n')
        for i, n in enumerate(Backgrounds[key]["Equipment"]):
            f_out.write(f'\t[\n')
            for item in n:
                f_out.write(f'\t\t{item[1]},\n')
            f_out.write(f'\t],\n')

        if i == len(lst_backgrounds):
            f_out.write('];')
        else:
            f_out.write('];\n\n')