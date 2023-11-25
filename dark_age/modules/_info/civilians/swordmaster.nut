//Lvl 10 Merc template
::Const.Tactical.Actor.Swordmaster <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.Swordmaster] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

//1H sword
::B.Info[::Const.EntityType.Swordmaster].Builds["Sword"] <- {
	Name = "Sword",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_recuperation"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_steadfast"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_pattern_recognition"], //7
        ["scripts/skills/perks/perk_duelist"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/noble_sword",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_sword",
		],
	],
};

::B.Info[::Const.EntityType.Swordmaster].Builds["Estoc"] <- {
	Name = "Estoc",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_quickstep"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_steadfast"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_pattern_recognition"], //7
        ["scripts/skills/perks/perk_reach_advantage"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_estoc",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/legend_named_estoc",
		],
	],
};

