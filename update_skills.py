import os
import re
from pathlib import Path
root = r'C:\Files\Projects\bbros\env_legends\scripts\skills'
root2 = r'C:\Files\Projects\bbros\Legends-Dark-Age\scripts\skills'
output = r'C:\Files\Projects\bbros\Legends-Dark-Age\scripts\config'

#generate file hooks

def filter_path(path):
    if "\effects" in path: return True
    if "\\backgrounds" in path: return True
    if "\injury" in path: return True
    if "\injury_permanent" in path: return True
    if "\\rune_sigils" in path: return True
    if "\\terrain" in path: return True
    if "\items" in path: return True
    if "\special" in path: return True
    return False

def filter_id(id):
    if id is None: return None
    if 'hand_to_hand' in id: return None
    if 'wake_ally' in id: return None
    if 'crack_the_whip' in id: return None
    if 'special.' in id: return None
    return id

map = {}

with open(os.path.join(output, f'z_map.nut'), "w+") as f_out:

    f_out.write('::Z.Map <- {\n')

    for path, subdirs, files in os.walk(root):
        for fname in files:
            if not fname.endswith('.nut'): continue
            if filter_path(path): continue
           
            with open(os.path.join(path, fname), encoding='utf-8') as f_in:
                id = None
                for line in f_in.readlines():
                    if 'this.m.ID = ' in line:
                        a = line.strip().replace('this.m.ID = ', '').replace(';', '')
                        id = filter_id(a)
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
            if filter_path(path): continue
            with open(os.path.join(path, fname), encoding='utf-8') as f_in:
                id = None
                for line in f_in.readlines():
                    if 'this.m.ID = ' in line:
                        a = line.strip().replace('this.m.ID = ', '').replace(';', '')
                        id = filter_id(a)
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

                    

    