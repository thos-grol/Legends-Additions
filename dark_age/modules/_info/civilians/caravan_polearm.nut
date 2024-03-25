//Lvl 4 Peasant template - Avg Daytaler stats

::Const.Tactical.Actor.LegendCaravanPolearm <- {
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

::B.Info[::Const.EntityType.LegendCaravanPolearm] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Health", 4, 0, 1],
		["Fatigue", 4, 0, 1],
	],
    Outfit = [
		[
			1,
			"legend_caravan_polearm_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/warfork",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/warfork",
		],
	],
	Builds = {},
	BuildsChance = 0
};
