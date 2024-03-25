//merc template, 9 perks
//has weapon mastery and stance
::Const.Tactical.Actor.LegendManAtArms <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 10,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.LegendManAtArms] <- {
    Level = 10,
    Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["W", 3],
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
        ["T", 5], //8
		["W", 7],
    ],
	LevelUps = [
		["Health", 9, 2, 3],
		["Ranged Defense", 9, 2, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/warhammer"
        ],
        [
        	"scripts/items/weapons/noble_sword"
        ],
        [
        	"scripts/items/weapons/morning_star"
        ],
        [
        	"scripts/items/weapons/flail"
        ],
        [
        	"scripts/items/weapons/military_cleaver"
        ]
	],
	Builds = {},
	BuildsChance = 0
};

///////