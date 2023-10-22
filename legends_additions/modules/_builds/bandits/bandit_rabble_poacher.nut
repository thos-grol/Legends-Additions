//Bandit Rabble
//Lvl 4 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.BanditRabblePoacher <- {
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

::B.Info[::Const.EntityType.BanditRabblePoacher] <- {
    Level = 4,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
    ],
	LevelUps = [
		["Health", 3, 0],
		["Ranged Skill", 3, 0],
		["Melee Defense", 3, 0],
	],
    Trait = [],
    Outfit = [
		[
			1,
			"bandit_rabble_poacher_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/short_bow",
		],
		[
			"scripts/items/weapons/legend_sling",
		],
		[
			"scripts/items/weapons/legend_sling",
		]
	]
};