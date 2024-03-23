//Bandit Rabble
//Lvl 3 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.BanditRabble <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 50,
	Stamina = 100,
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
::B.Info[::Const.EntityType.BanditRabblePoacher] <- {
    Level = 3,
    Pattern = [
        ["T", 1],
        ["D", 2],
    ],
	LevelUps = [
		["Health", 2, 0, 1],
		["Fatigue", 2, 0, 1],
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