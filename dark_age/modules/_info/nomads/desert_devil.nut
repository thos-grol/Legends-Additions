//Lvl 10 Raider template
::Const.Tactical.Actor.DesertDevil <- {
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

::B.Info[::Const.EntityType.DesertDevil] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

//1H sword
::B.Info[::Const.EntityType.DesertDevil].Builds["Shamshir"] <- {
	Name = "Shamshir",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_recuperation"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_steadfast"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_legend_lacerate"], //7
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
			"scripts/items/weapons/shamshir",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_shamshir",
		],
	],
};

::B.Info[::Const.EntityType.DesertDevil].Builds["Swordlance"] <- {
	Name = "Swordlance",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_polearmc"], //4
        ["scripts/skills/perks/perk_mastery_axec"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_quickstep"], //7
        ["scripts/skills/perks/perk_reach_advantage"], //8
        ["scripts/skills/perks/perk_stance_executioner"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/swordlance",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_swordlance",
		],
	],
};

