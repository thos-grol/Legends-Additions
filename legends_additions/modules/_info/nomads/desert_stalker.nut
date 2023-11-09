//Raider Template
::Const.Tactical.Actor.DesertStalker <- {
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

::B.Info[::Const.EntityType.DesertStalker] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.DesertStalker].Builds["Warbow Balanced"] <- {
	Name = "Warbow Balanced",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_wind_reader"], //3
        ["scripts/skills/perks/perk_mastery_rangedc"], //4
        ["scripts/skills/perks/perk_legend_recuperation"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_legend_peaceful"], //7
        ["scripts/skills/perks/perk_battle_flow"], //8
        ["scripts/skills/perks/perk_stance_marksman"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Ranged Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/war_bow",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_warbow",
		],
	],
};

::B.Info[::Const.EntityType.DesertStalker].Builds["Warbow Headshot"] <- {
	Name = "Warbow Full HP",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_wind_reader"], //3
        ["scripts/skills/perks/perk_mastery_rangedc"], //4
        ["scripts/skills/perks/perk_hold_out"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_head_hunter"], //7
        ["scripts/skills/perks/perk_fearsome"], //8
        ["scripts/skills/perks/perk_stance_marksman"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Ranged Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/war_bow",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_warbow",
		],
	],
};
