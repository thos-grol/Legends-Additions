::Const.Tactical.Actor.GoblinShaman <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 65,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.GoblinShaman] <- {
    Level = 8,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["scripts/skills/perks/perk_legend_wind_reader"], //3
        ["scripts/skills/perks/perk_footwork"],
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
			"scripts/items/weapons/greenskins/goblin_staff",
		],
	],
	Builds = {},
	BuildsChance = 0
};