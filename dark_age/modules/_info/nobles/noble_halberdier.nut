//merc template, 8 perks
//has weapon mastery and stance
::Const.Tactical.Actor.LegendHalberdier <- {
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

::B.Info[::Const.EntityType.LegendHalberdier] <- {
    Level = 9,
    Pattern = [
		["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
		["scripts/skills/perks/perk_strange_strikes"], //4 - 1
        ["W", 4], //4
        ["T", 3], //5
        ["D", 6], //6
        ["T", 5], //7
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
        	"scripts/items/weapons/legend_halberd"
        ],
	],
	Builds = {},
	BuildsChance = 0
};

///////