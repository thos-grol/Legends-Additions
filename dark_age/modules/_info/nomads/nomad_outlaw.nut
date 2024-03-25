//Nomad Outlaw
//Level 7 Raider template
//raider template, 6 perks
::Const.Tactical.Actor.NomadOutlaw <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 50,
	Stamina = 100,
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

::B.Info[::Const.EntityType.NomadOutlaw] <- {
    Level = 7,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
    ],
	LevelUps = [
		["Health", 6, 0, 2],
		["Fatigue", 6, 0, 2],
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
    ],
	LevelUps = [
		["Health", 6, 0, 2],
		["Fatigue", 6, 0, 2],
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
        ["W", 4],
        ["scripts/skills/perks/perk_adrenalin"],
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"],
    ],
	LevelUps = [
		["Health", 6, 0, 2],
		["Initiative", 6, 0, 2],
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
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 6, 0, 2],
		["Fatigue", 6, 0, 2],
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