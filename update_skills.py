import os
import re
from pathlib import Path
root = r'C:\Files\Projects\bbros\env_legends\scripts\skills'
root2 = r'C:\Files\Projects\bbros\Legends-Dark-Age\scripts\skills'
output = r'C:\Files\Projects\bbros\Legends-Dark-Age\scripts\config'

#generate file hooks

map = {}

with open(os.path.join(output, f'z_map.nut'), "w+") as f_out:

    f_out.write('::Z.Map <- {\n')

    for path, subdirs, files in os.walk(root):
        for fname in files:
            if not fname.endswith('.nut'): continue
            if "\effects" in path: continue
            if "\\backgrounds" in path: continue
            if "\injury" in path: continue
            if "\injury_permanent" in path: continue
            if "\\rune_sigils" in path: continue
            if "\\terrain" in path: continue
            with open(os.path.join(path, fname), encoding='utf-8') as f_in:
                id = None
                for line in f_in.readlines():
                    if 'this.m.ID = ' in line:
                        a = line.strip().replace('this.m.ID = ', '').replace(';', '')
                        id = a
                        break

                script = os.path.join(path, fname)
                script = script.replace('\\', '/')
                script = script.replace('C:/Files/Projects/bbros/env_legends/', '')
                script = script.replace('.nut', '')
                script = '"' + script + '"'

                if not id is None: map[id] = script

    for path, subdirs, files in os.walk(root2):
        for fname in files:
            if not fname.endswith('.nut'): continue
            if "\effects" in path: continue
            if "\\backgrounds" in path: continue
            if "\injury" in path: continue
            if "\injury_permanent" in path: continue
            if "\\rune_sigils" in path: continue
            if "\\terrain" in path: continue
            with open(os.path.join(path, fname), encoding='utf-8') as f_in:
                id = None
                for line in f_in.readlines():
                    if 'this.m.ID = ' in line:
                        a = line.strip().replace('this.m.ID = ', '').replace(';', '')
                        id = a
                        break

                script = os.path.join(path, fname)
                script = script.replace('\\', '/')
                script = script.replace('C:/Files/Projects/bbros/Legends-Dark-Age/', '')
                script = script.replace('.nut', '')
                script = '"' + script + '"'
                if not id is None: map[id] = script

                

    for key in map:
        f_out.write(f'\t{key} : {map[key]},\n')
    f_out.write('};')

                    
# for fname in os.listdir(root):
   
        # a = None
        # b = None
        # for line in f_in.readlines():
        #     if 'this.m.Type = ' in line:
        #         a = line.strip().replace('this.m.Type = ', '').replace(';', '')
        #     if 'this.m.Payment.Pool = ' in line:
        #         for n in line.split():
        #             if n.isnumeric():
        #                 b = int(int(n) / 5)
        #         if b is None: b = 50
        #         ids.append((a, b))
        #         break

# ids.sort(key=lambda tup: tup[1])

# for i in range(len(ids)):
#     print(f'{ids[i][0]} : {ids[i][1]},')