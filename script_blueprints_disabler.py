import os
import re
from pathlib import Path

PATH_BLUEPRINTS = r'C:\Files\Projects\bbros\env_legends\crafting\blueprints'
PATH_OUT = r'C:\Files\Projects\bbros\mod_legends_additions\Legends-Additions\legends_additions\hooks\economy\economy_blueprints.nut'

#PROGRAM START

#Parse and load troop stats
with open(PATH_OUT, "w+") as f_out:
    for path, subdirs, files in os.walk(PATH_BLUEPRINTS):
        for fname in files:
            str_name = fname.replace('.nut', '')
            str_path = path.replace('\\', '/').replace('C:/Files/Projects/bbros/env_legends/', '')
            str_processed_path = f'{str_path}/{str_name}'
            str_final = f'::mods_hookExactClass("{str_processed_path}", ' + 'function(o) { o.isValid <- function(){ return false; }});\n'
            f_out.write(str_final)