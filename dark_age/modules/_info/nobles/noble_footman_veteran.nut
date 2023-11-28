//merc template, 8 perks
//has weapon mastery and stance
::Const.Tactical.Actor.LegendNobleGuard <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.LegendNobleGuard] <- {
    Level = 9,
    Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["W", 3],
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
        ["T", 5], //8
    ],
	LevelUps = [
		["Health", 8, 2, 3],
		["Melee Skill", 8, 2, 3],
		["Melee Defense", 8, 2, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/military_pick"
        ],
        [
        	"scripts/items/weapons/arming_sword"
        ],
        [
        	"scripts/items/weapons/fighting_axe"
        ],
        [
        	"scripts/items/weapons/morning_star"
        ]
	],
	Builds = {},
	BuildsChance = 0
};

///////