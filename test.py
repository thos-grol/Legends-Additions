generate = [
    'Bow', 
    'Cleaver', 
    'Crossbow', 
    'Dagger', 
    'Fist', 
    'Flail', 
    'Hammer', 
    'Mace', 
    'Polearm', 
    'Spear', 
    'Sword' 
]

template = '''
{
        ID = "perk.mastery.axec",
        Script = "scripts/skills/perks/perk_mastery_axec",
        Name = "",
        Tooltip = "",
        Icon = "ui/perks/mastery_axe.png",
        IconDisabled = "ui/perks/perk_44_sw.png",
        Const = "SpecAxeC"
    },
'''

for t in generate:
    print(template.replace('axe', t.lower()).replace('Axe', t))