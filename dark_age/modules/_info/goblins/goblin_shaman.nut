::Const.Tactical.Actor.GoblinShaman <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.GoblinShaman] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["scripts/skills/perks/perk_legend_wind_reader"], //3
        ["scripts/skills/perks/perk_footwork"],
    ],
	LevelUps = [
		["Initiative", 4, 0, 2],
		["Ranged Defense", 4, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/goblin_staff",
		],
	],
	Builds = {},
	BuildsChance = 0
};