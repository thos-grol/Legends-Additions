import os
import re
from pathlib import Path
PATH_CONFIG = r'C:\Files\Projects\bbros\env_legends\config'
PATH_ENEMIES = r'C:\Files\Projects\bbros\env_legends\entity\tactical\enemies'
PATH_HUMANS = r'C:\Files\Projects\bbros\env_legends\entity\tactical\humans'
PATH_OUT = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\troops\monster'
PATH_OUT2 = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\troops\human'
DEFINITIONS = {}

#PROGRAM START

#Parse and load troop stats
for fname in os.listdir(PATH_CONFIG):
    if not fname.startswith('faction_') or 'faction_traits' in fname: continue
    with open(os.path.join(PATH_CONFIG, fname)) as file:
        FLAG = False
        ID = None
        DEFINITION = []
        for line in file.readlines():
            if not FLAG and not 'Const.Tactical.Actor.' in line: continue
            if 'Const.Tactical.Actor.' in line: #start the group
                FLAG = True
                ID = re.findall(r'gt.Const.Tactical.Actor.(.+) <- {', line)[0]
                DEFINITION.append(line.replace("gt.", "::").replace("<-", "="))
            elif FLAG and '};' in line: #end the group, and push definition
                FLAG = False
                DEFINITION.append(line)
                DEFINITIONS[ID] = DEFINITION.copy()
                DEFINITION.clear()
            else:
                DEFINITION.append(line)  

BANNED_FNS = ['onRender', 'create', 'generateName', 'onAppearanceChanged', 'setCharming', 'onUpdateInjuryLayer', 'onFactionChanged', 'playIdleSound', 'getSize', 'getXPValue', 'onAfterDeath', 'grow', 'playAttackSound', 'playSound']
BANNED_FILES = []

def parse(PATH, out):
    for fname in os.listdir(PATH):
        if not fname.endswith('.nut'): continue
        if fname in BANNED_FILES: continue
        FLAG = False
        ID = None
        LINES = []
    
        with open(os.path.join(PATH, fname)) as f_in:
            with open(os.path.join(out, fname), 'w+') as f_out:
                newname = fname.replace('.nut', '')
                if PATH == PATH_ENEMIES:
                    LINES.append(f'::mods_hookExactClass(\"entity/tactical/enemies/{newname}\", function(o) ' + '{\n')
                else:
                    LINES.append(f'::mods_hookExactClass(\"entity/tactical/humans/{newname}\", function(o) ' + '{\n')

                for line in f_in.readlines():
                    if not FLAG and not 'function ' in line: continue
                    if 'Const.Tactical.Actor.' in line:
                        try:
                            ID = re.findall(r'Const.Tactical.Actor.(.+)\);', line)[0]
                        except:
                            ID = None
                    if 'function ' in line and 'scheduleEvent(' not in line and '.sort(function' not in line:
                        FLAG = True
                        try:
                            query = re.findall(r'function (.+)\(\)', line)[0]
                            if query in BANNED_FNS:
                                FLAG = False
                                continue
                            LINES.append(f'\to.{query} = function()\n')
                        except:
                            query = re.findall(r'function (.+)\((.+)\)', line)[0]
                            if query[0] in BANNED_FNS:
                                FLAG = False
                                continue
                            LINES.append(f'\to.{query[0]} = function({query[1]})\n')
                    else:
                        LINES.append(line)

                if '});\n' not in LINES:
                    LINES.append('});\n')

                if ID is not None and ID in DEFINITIONS:
                    LINES = DEFINITIONS[ID] + LINES

                for LINE in LINES:
                    f_out.write(LINE)

parse(PATH_ENEMIES, PATH_OUT)
parse(PATH_HUMANS, PATH_OUT2)
