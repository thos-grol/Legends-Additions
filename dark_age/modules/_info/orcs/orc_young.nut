::Const.Tactical.Actor.OrcYoung <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 200,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 50,
	RangedSkill = 30,
	MeleeDefense = -10,
	RangedDefense = 0,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.0
};

::B.Info[::Const.EntityType.OrcYoung] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Ranged Skill", 5, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/orc_axe",
		],
		[
			"scripts/items/weapons/greenskins/orc_cleaver",
		],
		[
			"scripts/items/weapons/greenskins/legend_skin_flayer",
		],
		[
			"scripts/items/weapons/greenskins/orc_wooden_club",
		],
		[
			"scripts/items/weapons/greenskins/orc_metal_club",
		],
		[
			"scripts/items/weapons/greenskins/orc_flail_2h",
		],
	],
	Builds = {},
	BuildsChance = 0
};