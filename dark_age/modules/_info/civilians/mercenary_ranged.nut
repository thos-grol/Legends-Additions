//Lvl 8 Merc template - Avg Daytaler stats
::Const.Tactical.Actor.MercenaryRanged <- {
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

::B.Info[::Const.EntityType.MercenaryRanged] <- {
    Level = 8,
	Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
		["scripts/skills/perks/perk_legend_wind_reader"],
    ],
	LevelUps = [
		["Health", 8, 0, 2],
		["Ranged Skill", 8, 0, 2],
		["Melee Defense", 8, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/hunting_bow",
		],
		[
			"scripts/items/weapons/war_bow",
		],
		[
			"scripts/items/weapons/crossbow",
		],
	]
};