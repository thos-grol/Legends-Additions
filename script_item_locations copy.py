import os
import re
from pathlib import Path
root3 = r'C:\Files\Projects\bbros\Legends-Dark-Age\scripts\config\Ω_economy_item_prices.nut'

out3 = r'C:\Files\Projects\bbros\Legends-Dark-Age\scripts\config\Ω_economy_item_prices2.nut'

#generate file hooks

# # # situations
with open(root3, encoding='utf-8') as f_in:
    with open(out3, 'w+', encoding='utf-8') as f_out:
        for line in f_in.readlines():
            if 'named_' in line:
                a = line.split(':')
                e = line.split(',')
                # print(e[1])
                b = a[1].split(',')
                c = int(b[0])
                if c == 0: 
                    f_out.write(line)
                    continue
                c_new = int((c / 1.5 + 100) * 2)

                d = a[0] + ': ' + str(c_new) + ',' + e[1]

                print(d)
                f_out.write(d + '\n')
            else: f_out.write(line)