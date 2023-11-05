//Bandit Thug
//Lvl 6 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.OrcYoung <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 200,
	Bravery = 65,
	Stamina = 150,
	MeleeSkill = 55,
	RangedSkill = 50,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 110,
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
    Level = 6,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Initiative", 5, 0, 2],
		["Melee Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
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