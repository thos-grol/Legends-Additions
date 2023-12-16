::Const.Tactical.Actor.Billman <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 57,
	Stamina = 96,
	MeleeSkill = 65,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.Billman] <- {
    Level = 8,
    Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
		["scripts/skills/perks/perk_strange_strikes"], //4 - 1
        ["W", 4], //4
        ["T", 3], //5
        ["D", 6], //6
        ["T", 5], //7
    ],
	LevelUps = [
		["Health", 7, 1, 3],
		["Melee Skill", 7, 1, 3],
		["Ranged Defense", 7, 1, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/billhook",
		],
		[
			"scripts/items/weapons/pike",
		],
		[
			"scripts/items/weapons/legend_military_voulge",
		],
		[
			"scripts/items/weapons/polehammer",
		],
	],
	Builds = {},
	BuildsChance = 0
};

//////////////////////////////////////////////////////////////////