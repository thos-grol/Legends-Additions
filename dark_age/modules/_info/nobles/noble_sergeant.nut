::Const.Tactical.Actor.Sergeant <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 57,
	Stamina = 96,
	MeleeSkill = 65,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.Sergeant] <- {
    Level = 10,
    Pattern = [
        ["scripts/skills/perks/perk_lead_by_example"], //1
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["scripts/skills/perks/perk_trial_by_fire"], //7
        ["D", 6], //6
        ["T", 3], //7
        ["T", 5], //7
        ["W", 7], //7
    ],
	LevelUps = [
		["Health", 9, 1, 3],
		["Melee Skill", 9, 1, 3],
		["Melee Defense", 9, 1, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/legend_military_goedendag",
		],
		[
			"scripts/items/weapons/legend_infantry_axe",
		],
		[
			"scripts/items/weapons/legend_swordstaff",
		]
	],
	Builds = {},
	BuildsChance = 0
};

//////////////////////////////////////////////////////////////////