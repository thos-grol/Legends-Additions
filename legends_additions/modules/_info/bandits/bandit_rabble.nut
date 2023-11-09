//Bandit Rabble
//Lvl 4 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.BanditRabble <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 35,
	Stamina = 95,
	MeleeSkill = 56,
	RangedSkill = 40,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.BanditRabble] <- {
    Level = 4,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["T", 3],
    ],
	LevelUps = [
		["Health", 3, 0, 1],
		["Melee Skill", 3, 0, 1],
		["Melee Defense", 3, 0, 1],
	],
    Trait = [],
    Outfit = [
		[
			1,
			"bandit_rabble_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/pitchfork"
		],
		[
			"scripts/items/weapons/legend_wooden_spear"
		],
		[
			"scripts/items/weapons/wooden_stick"
		],
		[
			"scripts/items/weapons/legend_hammer"
		],
		[
			"scripts/items/weapons/butchers_cleaver"
		],
		[
			"scripts/items/weapons/legend_hoe"
		],
		[
			"scripts/items/weapons/wooden_flail"
		]
	]
};