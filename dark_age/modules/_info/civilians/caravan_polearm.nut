//Lvl 6 Peasant template - Avg Daytaler stats

::Const.Tactical.Actor.LegendCaravanPolearm <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
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

::B.Info[::Const.EntityType.LegendCaravanPolearm] <- {
    Level = 6,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Melee Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
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
