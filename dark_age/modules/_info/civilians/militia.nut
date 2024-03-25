//Lvl 5 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.Militia <- {
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

::B.Info[::Const.EntityType.Militia] <- {
    Level = 5,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.Militia].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 4, 0, 2],
		["Ranged Defense", 4, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_militia_glaive",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/militia_spear",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/ancient/ancient_spear",
			"scripts/items/shields/wooden_shield"
		],
	]
};
