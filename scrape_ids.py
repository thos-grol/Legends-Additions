import os
import re
from pathlib import Path
root = r'C:\Files\Projects\env_legends\scripts\contracts\contracts'

#generate file hooks

ids = []

for fname in os.listdir(root):
    if not fname.endswith('.nut'): continue
    with open(os.path.join(root, fname)) as f_in:
        a = None
        b = None
        for line in f_in.readlines():
            if 'this.m.Type = ' in line:
                a = line.strip().replace('this.m.Type = ', '').replace(';', '')
            if 'this.m.Payment.Pool = ' in line:
                for n in line.split():
                    if n.isnumeric():
                        b = int(int(n) / 5)
                if b is None: b = 50
                ids.append((a, b))
                break

ids.sort(key=lambda tup: tup[1])

for i in range(len(ids)):
    print(f'{ids[i][0]} : {ids[i][1]},')