//Raider Template
::Const.Tactical.Actor.DesertStalker <- {
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
		["Fatigue", 9, 3, 3],
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
		["Fatigue", 9, 3, 3],
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
