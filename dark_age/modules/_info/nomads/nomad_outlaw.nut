//Nomad Outlaw
//Level 8 Raider template
//raider template, 7 perks
::Const.Tactical.Actor.NomadOutlaw <- {
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

::B.Info[::Const.EntityType.NomadOutlaw] <- {
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
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/oriental/two_handed_saif",
		],
		[
			"scripts/items/weapons/two_handed_wooden_hammer",
		],
	],
	Builds = {},
	BuildsChance = 40
};

//////////////////////////////////////////////////////////////////

::B.Info[::Const.EntityType.NomadOutlaw].Builds["Polemace"] <- {
	Name = "Polemace",
	Pattern = [
        ["scripts/skills/perks/perk_quickstep"],
        ["scripts/skills/perks/perk_head_hunter"],
        ["scripts/skills/perks/perk_legend_recuperation"],
        ["scripts/skills/perks/perk_mastery_polearm"],
        ["scripts/skills/perks/perk_mastery_mace"],
        ["scripts/skills/perks/perk_rattle"],
        ["scripts/skills/perks/perk_fearsome"],
    ],
	LevelUps = [
		["Resolve", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/polemace",
		]
	]
};

::B.Info[::Const.EntityType.NomadOutlaw].Builds["1H Duelist"] <- {
	Name = "1H Duelist",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_agile"],
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/scimitar"
		],
		[
			"scripts/items/weapons/flail",
			"scripts/items/shields/oriental/metal_round_shield"
		],
	]
};

::B.Info[::Const.EntityType.NomadOutlaw].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/nomad_mace",
			"scripts/items/shields/oriental/metal_round_shield"
		],
		[
			"scripts/items/weapons/boar_spear",
			"scripts/items/shields/oriental/metal_round_shield"
		],
	]
};