//Bandit Leader
//Level 10 Raider template
//raider template, 9 perks
//has weapon mastery and stance
::Const.Tactical.Actor.BanditLeader <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 47,
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

::B.Info[::Const.EntityType.BanditLeader] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

///////

::B.Info[::Const.EntityType.BanditLeader].Builds["Commander"] <- {
	Name = "Commander",
	Pattern = [
        ["scripts/skills/perks/perk_lead_by_example"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_rotation"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_shield_expert"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_trial_by_fire"], //7
        ["scripts/skills/perks/perk_fortified_mind"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
    ],
	LevelUps = [
		["Resolve", 7, 2, 3],
		["Health", 2, 2, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/arming_sword",
			"scripts/items/shields/kite_shield",
		],
		[
			"scripts/items/weapons/arming_sword",
			"scripts/items/shields/heater_shield",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_sword",
			"scripts/items/shields/named/named_bandit_kite_shield"
		],
		[
			"scripts/items/weapons/named/named_sword",
			"scripts/items/shields/named/named_bandit_heater_shield"
		],
	],
};
::B.Info[::Const.EntityType.BanditLeader].Builds["Commander2"] <- ::B.Info[::Const.EntityType.BanditLeader].Builds["Commander"];

::B.Info[::Const.EntityType.BanditLeader].Builds["Wrath"] <- {
	Name = "Wrath Axe",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_mastery_axec"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_death_dealer"], //7
        ["scripts/skills/perks/perk_nine_lives"], //8
        ["scripts/skills/perks/perk_stance_wrath"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greataxe",
		],
	],
	NamedLoadout = [
		[
			"weapons/named/named_greataxe",
		],
	],
};

::B.Info[::Const.EntityType.BanditLeader].Builds["Longsword Instinct"] <- {
	Name = "Longsword Instinct",
	Pattern = [
        ["scripts/skills/perks/perk_lone_wolf"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_underdog"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_survival_instinct"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_reach_advantage"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_longsword",
		],
	],
	NamedLoadout = [
		[
			"weapons/named/legend_named_longsword",
		],
	],
};

::B.Info[::Const.EntityType.BanditLeader].Builds["Swordstaff"] <- {
	Name = "Swordstaff",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_pokepoke"], //3
        ["scripts/skills/perks/perk_mastery_spearc"], //4
        ["scripts/skills/perks/perk_steadfast"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_mastery_swordc"], //7
        ["scripts/skills/perks/perk_battle_flow"], //8
        ["scripts/skills/perks/perk_stance_breakthrough"], //9
    ],
	LevelUps = [
		["Health", 9, 1, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_swordstaff",
		],
	],
	NamedLoadout = [
		[
			"weapons/named/legend_named_swordstaff",
		]
	],
};

::B.Info[::Const.EntityType.BanditLeader].Builds["Seismic"] <- {
	Name = "Seismic",
	Pattern = [
        ["scripts/skills/perks/perk_pathfinder"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_rattle"], //3
        ["scripts/skills/perks/perk_mastery_hammerc"], //4
        ["scripts/skills/perks/perk_legend_peaceful"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_agile"], //7
        ["scripts/skills/perks/perk_battle_flow"], //8
        ["scripts/skills/perks/perk_stance_seismic_slam"], //9
    ],
	LevelUps = [
		["Health", 9, 1, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/two_handed_hammer",
		],
	],
	NamedLoadout = [
		[
			"weapons/named/named_two_handed_hammer",
		]
	],
};

//TODO: 2h flail build

//TODO: axe duelist - vicious, calm
//TODO: cleaver duelist - bleeding, calm, steadfast
// if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
// {
// 	local weapons = [
// 		"weapons/fighting_axe",
// 		"weapons/military_cleaver"
// 	];