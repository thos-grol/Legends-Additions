::Const.Tactical.Actor.GoblinWolfrider <- {
	XP = 150,
	ActionPoints = 13,
	Hitpoints = 75,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 75,
	RangedSkill = 50,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 160,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

::B.Info[::Const.EntityType.GoblinWolfrider] <- {
    Level = 8,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["T", 3],
    ],
	LevelUps = [
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
		["Ranged Defense", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/goblin_spear",
		],
		[
			"scripts/items/weapons/greenskins/goblin_falchion",
		]
	],
	Builds = {},
	BuildsChance = 0
};