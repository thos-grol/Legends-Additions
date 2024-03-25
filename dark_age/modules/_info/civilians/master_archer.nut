//Raider Template
::Const.Tactical.Actor.MasterArcher <- {
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

::B.Info[::Const.EntityType.MasterArcher] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.MasterArcher].Builds["Warbow Balanced"] <- {
	Name = "Warbow Balanced",
	Pattern = [
		["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_wind_reader"], //3
        ["scripts/skills/perks/perk_mastery_rangedc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //0
        ["scripts/skills/perks/perk_legend_recuperation"], //5
        ["scripts/skills/perks/perk_legend_peaceful"], //6
		["scripts/skills/perks/perk_legend_wind_reader"], //7
		["D", 6],
        ["scripts/skills/perks/perk_sundering_strikes"], //9
        ["scripts/skills/perks/perk_stance_marksman"], //10
        ["scripts/skills/perks/perk_legend_muscularity"], //11
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Skill", 10, 3, 3],
		["Initiative", 10, 3, 3],
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