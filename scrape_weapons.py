import os
import re
from pathlib import Path

PATH_ = r'C:\Files\Projects\bbros\Legends-Dark-Age\scripts\entity\tactical\enemies\legend_bandit_veteran.nut'

items = []
with open(PATH_) as f_in:
    for line in f_in.readlines():
        if 'scripts/items/' in line and not 'this.Math.rand' in line:
            temp = line
            temp = temp.strip()
            temp = temp.replace('this.m.Items.equip(this.new(' , '')
            temp = temp.replace('));' , '')
            items.append(temp)

print('Loadout = [')
for item in items:
    print(f'\t[\n	{item}\n\t],')
print('],')
