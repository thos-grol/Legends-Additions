//Bandit Rabble
//Lvl 4 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.BanditRabble <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 100,
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
		["Health", 3, 0, 1],
		["Ranged Skill", 3, 0, 1],
		["Melee Defense", 3, 0, 1],
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