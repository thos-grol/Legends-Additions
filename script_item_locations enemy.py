import os
import re
from pathlib import Path
root = r'C:\Files\Projects\bbros\env_legends\entity\world\locations'
out = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\economy\locations'

#generate file hooks

# # # attached_location
bannedfns = []
bannedfiles = []
for fname in os.listdir(root):
    if not fname.endswith('.nut'): continue
    if fname in bannedfiles: continue
    flag_copy = False
   
    with open(os.path.join(root, fname)) as f_in:
        with open(os.path.join(out, fname), 'w+') as f_out:
            newname = fname.replace('.nut', '')
            f_out.write(f'::mods_hookExactClass(\"entity/world/locations/{newname}\", function(o) ' + '{\n')
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
    endFlag = False
    with open(os.path.join(out, fname)) as f_out:
        for line in f_out.readlines():
            if '});\n' == line:
                endFlag = True
    if not endFlag:
        with open(os.path.join(out, fname), 'a') as f_out:
            f_out.write('});\n')