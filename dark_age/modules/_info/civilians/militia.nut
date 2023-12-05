//Lvl 6 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.Militia <- {
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

::B.Info[::Const.EntityType.Militia] <- {
    Level = 6,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.Militia].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
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
