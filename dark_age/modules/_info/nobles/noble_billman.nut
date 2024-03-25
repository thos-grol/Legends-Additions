::Const.Tactical.Actor.Billman <- {
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

::B.Info[::Const.EntityType.Billman] <- {
    Level = 5,
    Pattern = [
        ["T", 1], //1
        ["D", 2], //2
		["scripts/skills/perks/perk_strange_strikes"], //4 - 1
        ["W", 4], //4
    ],
	LevelUps = [
		["Health", 4, 1, 3],
		["Fatigue", 4, 1, 3],
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