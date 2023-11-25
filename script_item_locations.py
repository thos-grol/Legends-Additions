import os
import re
from pathlib import Path
root3 = r'C:\Files\Projects\env_legends\scripts\entity\world\settlements\situations'

out3 = r'C:\Files\Projects\bbros\Legends-Dark-Age\dark_age\modules\economy\settlements\situations'

#generate file hooks

# # # situations
bannedfns = ['create', 'getAddedString', 'getRemovedString', 'onResolved', 'onAdded',]
bannedfiles = [
    'situation.nut',
]
for fname in os.listdir(root3):
    if not fname.endswith('.nut'): continue
    if fname in bannedfiles: continue
    flag_copy = False

    with open(os.path.join(root3, fname)) as f_in:
        with open(os.path.join(out3, fname), 'w+') as f_out:
            newname = fname.replace('.nut', '')
            f_out.write(f'::mods_hookExactClass(\"entity/world/attached_location/{newname}\", function(o) ' + '{\n')

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

for fname in os.listdir(out3):
    endFlag = False
    with open(os.path.join(out3, fname)) as f_out:
        for line in f_out.readlines():
            if '});\n' == line:
                endFlag = True
    if not endFlag:
        with open(os.path.join(out3, fname), 'a') as f_out:
            f_out.write('});\n')