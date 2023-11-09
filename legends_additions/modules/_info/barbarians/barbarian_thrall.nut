//Level 6 Barbarian template
//raider template, 5 perks

::Const.Tactical.Actor.BarbarianThrall <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 60,
	Stamina = 110,
	MeleeSkill = 56,
	RangedSkill = 40,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.BarbarianThrall] <- {
    Level = 6,
    Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["scripts/skills/perks/perk_adrenalin"],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Initiative", 4, 0, 2],
		["Health", 3, 0, 2],
		["Melee Skill", 4, 0, 2],
		["Melee Defense", 4, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/antler_cleaver",
		],
		[
			"scripts/items/weapons/barbarians/claw_club",
		],
	],
	Builds = {},
	BuildsChance = 15
};

::B.Info[::Const.EntityType.BarbarianThrall].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["scripts/skills/perks/perk_rotation"],
        ["scripts/skills/perks/perk_adrenalin"],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Melee Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/claw_club",
			"scripts/items/shields/oriental/wooden_shield_old"
		],
	]
};

