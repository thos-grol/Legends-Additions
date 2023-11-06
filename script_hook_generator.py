import os

PATH_VANILLA = r'C:\Files\Projects\bbros\env_legends'
PATH_GENERATE = r'C:\Files\Projects\bbros\Legends-Dark-Age\legends_additions\modules\_def\sound.nut'
FUNCTIONS = {}

for path, subdirs, files in os.walk(PATH_VANILLA):
    for name in files:
        if not '.nut' in name: continue
        with open(os.path.join(path, name), encoding='utf-8') as file:
            name = os.path.join(path, name)
            lines = file.readlines()
            for line in lines:
                if ('function' in line and 'Pressed(' in line):
                    if not name in FUNCTIONS: FUNCTIONS[name] = []
                    FUNCTIONS[name].append(line)

with open(PATH_GENERATE, 'w+' ,encoding='utf-8') as file:
    for name in FUNCTIONS:
        temp = name.replace(PATH_VANILLA + r'\scripts', '')
        temp = temp[1:]
        temp = temp.replace('\\', '/')
        temp = temp.replace('.nut', '')
        file.write(f'::mods_hookExactClass("{temp}", function (o)\n')
        file.write('{\n')
        for function in FUNCTIONS[name]:
            function_name = function.strip().replace('function ', '')
            temp = function_name[function_name.find('('):]
            function_name = function_name[:  function_name.find('(')]

            function_name2 = function.strip().replace('function ', '')
            
            file.write(f'\tlocal {function_name} = o.{function_name};\n')
            
            declaration = function.replace('function ', 'o.')
            declaration = declaration.replace('(', ' = function(')
            file.write(declaration + '\t{\n' '\t\t::Z.Lib.play_click();\n'+ f'\t\t{function_name}{temp};\n')
            file.write('\t}\n')

        file.write('});\n')
        