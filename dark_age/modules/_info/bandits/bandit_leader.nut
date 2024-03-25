//Bandit Leader
//Level 10, 9 perks
//has weapon mastery and stance

::Const.Tactical.Actor.BanditLeader <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 20,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 120,
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

::B.Info[::Const.EntityType.BanditLeader].Builds["Greataxe"] <- {
	Name = "Greataxe",
	Pattern = [
		["scripts/skills/perks/perk_underdog"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_strange_strikes"], //4 - 1
        ["scripts/skills/perks/perk_mastery_hammerc"], //4 - 2
		["scripts/skills/perks/perk_survival_instinct"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_lone_wolf"], //8
        ["scripts/skills/perks/perk_stance_executioner"], //9
    ],
	LevelUps = [
		["Ranged Defense", 9, 1, 3],
		["Fatigue", 5, 1, 3],
		["Health", 4, 1, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greataxe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_greataxe",
		],
	],
};

::B.Info[::Const.EntityType.BanditLeader].Builds["Longsword"] <- {
	Name = "Longsword Instinct",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_strange_strikes"], //4 - 1
        ["scripts/skills/perks/perk_rattle"], //4 - 2
		["scripts/skills/perks/perk_survival_instinct"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_reach_advantage"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Ranged Defense", 9, 3, 3],
		["Fatigue", 5, 1, 3],
		["Health", 4, 1, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_longsword",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/legend_named_longsword",
		],
	],
};

::B.Info[::Const.EntityType.BanditLeader].Builds["Swordstaff"] <- {
	Name = "Swordstaff",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_spearc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_mastery_swordc"], //4 - 1
        ["scripts/skills/perks/perk_pokepoke"], //4 - 2
		["scripts/skills/perks/perk_survival_instinct"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_reach_advantage"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Ranged Defense", 9, 3, 3],
		["Fatigue", 5, 1, 3],
		["Health", 4, 1, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_swordstaff",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/legend_named_swordstaff",
		]
	],
};

::B.Info[::Const.EntityType.BanditLeader].Builds["Seismic"] <- {
	Name = "Seismic",
	Pattern = [
		["scripts/skills/perks/perk_pathfinder"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_hammerc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_legend_peaceful"], //4 - 1
        ["scripts/skills/perks/perk_rattle"], //4 - 2
		["scripts/skills/perks/perk_strange_strikes"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_battle_flow"], //8
        ["scripts/skills/perks/perk_stance_seismic_slam"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Ranged Skill", 9, 3, 3],
		["Ranged Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/two_handed_hammer",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_two_handed_hammer",
		]
	],
};

::B.Info[::Const.EntityType.BanditLeader].Builds["2H Flail"] <- {
	Name = "2H Flail",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_flailc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_strange_strikes"], //4 - 1
        ["scripts/skills/perks/perk_mastery_hammerc"], //4 - 2
		["scripts/skills/perks/perk_survival_instinct"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_underdog"], //8
        ["scripts/skills/perks/perk_stance_prisoner"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Ranged Defense", 9, 3, 3],
		["Fatigue", 5, 1, 3],
		["Health", 4, 1, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/two_handed_flail",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_two_handed_flail",
		]
	],
};