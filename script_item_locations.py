import os
import re
from pathlib import Path
root = r'C:\Files\Projects\bbros\env_legends\entity\world\settlements'
root2 = r'C:\Files\Projects\bbros\env_legends\entity\world\settlements\buildings'
root3 = r'C:\Files\Projects\bbros\env_legends\entity\world\attached_location'

out = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\economy\settlements'
out2 = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\economy\settlements\buildings'
out3 = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\economy\settlements\attached_location'

#generate file hooks

# settlements
bannedfns = ['isSouthern', 'getSpriteName', 'onSerialize', 'onDeserialize', 'buildNewLocation', 'getAttachedLocationsMax', 'getUIBackgroundLeft', 'getDescription', 'getUIDescription', 'getHousesMax']
bannedfiles = ['legends_fort.nut', 'legends_village.nut']
for fname in os.listdir(root):
    if not fname.endswith('.nut'): continue
    if not 'legends' in fname and not fname == 'city_state.nut': continue
    if fname in bannedfiles: continue
    flag_copy = False

    with open(os.path.join(root, fname)) as f_in:
        with open(os.path.join(out, fname), 'w+') as f_out:
            f_out.write(f'::mods_hookExactClass(\"entity/world/settlements/{fname}\", function(o) ' + '{\n')
            
            for line in f_in.readlines():
                if not flag_copy and not 'function ' in line: continue
                if 'function ' in line:
                    flag_copy = True
                    try:
                        query = re.findall(r'function (.+)\(\)', line)[0]
                        if query in bannedfns:
                            flag_copy = False
                            continue
                        f_out.write(f'\to.{query} = function()\n')
                    except:
                        query = re.findall(r'function (.+)\((.+)\)', line)[0]
                        if query[0] in bannedfns:
                            flag_copy = False
                            continue
                        f_out.write(f'\to.{query[0]} = function({query[1]})\n')
                else:
                    f_out.write(line)

for fname in os.listdir(out):
    if not fname.endswith('.nut'): continue
    endFlag = False
    with open(os.path.join(out, fname), 'r') as f_out:
        for line in f_out.readlines():
            if '});\n' == line:
                endFlag = True
    if not endFlag:
        with open(os.path.join(out, fname), 'a') as f_out:
            f_out.write('});\n')

# buildings
# bannedfns = ['getStash', 'create', 'onClicked', 'getRandomDescription', 'onSettlementEntered', 'onSerialize', 'onDeserialize', 'getUIImage']
# bannedfiles = [
#     'building.nut', 
#     'barber_building.nut',
#     'port_oriental_building.nut',
#     'stables_building.nut',
#     'taxidermist_oriental_building.nut',
#     'training_hall_building.nut',
#     'crowd_oriental_building.nut',
#     'crowd_building.nut',
# ]
# for fname in os.listdir(root2):
#     if not fname.endswith('.nut'): continue
#     if fname in bannedfiles: continue
#     flag_copy = False
   
#     with open(os.path.join(root2, fname)) as f_in:
#         with open(os.path.join(out2, fname), 'w+') as f_out:
#             f_out.write(f'::mods_hookExactClass(\"entity/world/settlements/buildings/{fname}\", function(o) ' + '{\n')
            
#             for line in f_in.readlines():
#                 if not flag_copy and not 'function ' in line: continue
#                 if 'function ' in line:
#                     flag_copy = True
#                     try:
#                         query = re.findall(r'function (.+)\(\)', line)[0]
#                         if query in bannedfns:
#                             flag_copy = False
#                             continue
#                         f_out.write(f'\to.{query} = function()\n')
#                     except:
#                         query = re.findall(r'function (.+)\((.+)\)', line)[0]
#                         if query[0] in bannedfns:
#                             flag_copy = False
#                             continue
#                         f_out.write(f'\to.{query[0]} = function({query[1]})\n')
#                 else:
#                     f_out.write(line)

# for fname in os.listdir(out2):
#     endFlag = False
#     with open(os.path.join(out2, fname)) as f_out:
#         for line in f_out.readlines():
#             if '});\n' == line:
#                 endFlag = True
#     if not endFlag:
#         with open(os.path.join(out2, fname), 'a') as f_out:
#             f_out.write('});\n')
                


# # # attached_location
# bannedfns = ['create', 'getSounds', 'onInit', 'onFinish', 'onUpdate', 'spawnFire', 'onBuild']
# bannedfiles = [
#     'dye_maker_oriental_location.nut',
#     'dye_maker_oriental_location.nut',
# ]
# for fname in os.listdir(root3):
#     if not fname.endswith('.nut'): continue
#     if fname in bannedfiles: continue
#     flag_copy = False
   
#     with open(os.path.join(root3, fname)) as f_in:
#         with open(os.path.join(out3, fname), 'w+') as f_out:
#             f_out.write(f'::mods_hookExactClass(\"entity/world/attached_location/{fname}\", function(o) ' + '{\n')
            
#             for line in f_in.readlines():
#                 if not flag_copy and not 'function ' in line: continue
#                 if 'function ' in line:
#                     flag_copy = True
#                     try:
#                         query = re.findall(r'function (.+)\(\)', line)[0]
#                         if query in bannedfns:
#                             flag_copy = False
#                             continue
#                         f_out.write(f'\to.{query} = function()\n')
#                     except:
#                         query = re.findall(r'function (.+)\((.+)\)', line)[0]
#                         if query[0] in bannedfns:
#                             flag_copy = False
#                             continue
#                         f_out.write(f'\to.{query[0]} = function({query[1]})\n')
#                 else:
#                     f_out.write(line)

# for fname in os.listdir(out3):
#     endFlag = False
#     with open(os.path.join(out3, fname)) as f_out:
#         for line in f_out.readlines():
#             if '});\n' == line:
#                 endFlag = True
#     if not endFlag:
#         with open(os.path.join(out3, fname), 'a') as f_out:
#             f_out.write('});\n')