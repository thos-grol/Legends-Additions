//Lvl 10 Raider Template
//Has stance, 9 perks
::Const.Tactical.Actor.NomadLeader <- {
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

::B.Info[::Const.EntityType.NomadLeader] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.NomadLeader].Builds["Commander"] <- {
	Name = "Commander",
	Pattern = [
        ["scripts/skills/perks/perk_lead_by_example"], //1
        ["scripts/skills/perks/perk_fortified_mind"], //3
        ["scripts/skills/perks/perk_rotation"], //3
        ["scripts/skills/perks/perk_mastery_spearc"], //4
        ["scripts/skills/perks/perk_shield_expert"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_trial_by_fire"], //7
        ["scripts/skills/perks/perk_legend_lacerate"], //8
        ["scripts/skills/perks/perk_stance_breakthrough"], //9
    ],
	LevelUps = [
		["Resolve", 7, 2, 3],
		["Health", 2, 2, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/fighting_spear",
			"scripts/items/shields/oriental/metal_round_shield",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_spear",
			"scripts/items/shields/named/named_sipar_shield"
		]
	],
};

::B.Info[::Const.EntityType.NomadLeader].Builds["Spear God"] <- {
	Name = "Spear God",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_lacerate"], //3
        ["scripts/skills/perks/perk_mastery_spearc"], //4
        ["scripts/skills/perks/perk_pokepoke"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_steadfast"], //7
        ["scripts/skills/perks/perk_duelist"], //8
        ["scripts/skills/perks/perk_stance_breakthrough"], //9
    ],
	LevelUps = [
		["Initiative", 9, 2, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/fighting_spear"
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_spear"
		]
	],
};

::B.Info[::Const.EntityType.NomadLeader].Builds["Crypt Cleaver"] <- {
	Name = "Crypt Cleaver",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_lacerate"], //3
        ["scripts/skills/perks/perk_mastery_cleaverc"], //4
        ["scripts/skills/perks/perk_sundering_strikes"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_death_dealer"], //7
        ["scripts/skills/perks/perk_dismemberment"], //8
        ["scripts/skills/perks/perk_stance_gourmet"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/ancient/crypt_cleaver",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_crypt_cleaver",
		],
	],
};