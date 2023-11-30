//Lvl 11 Merc template
::Const.Tactical.Actor.Assassin <- {
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

::B.Info[::Const.EntityType.Assassin] <- {
    Level = 11,
	Builds = {},
	BuildsChance = 100
};

//1H sword
::B.Info[::Const.EntityType.Assassin].Builds["fast"] <- {
	Name = "fast",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_recuperation"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
		["scripts/skills/perks/perk_legend_back_to_basics"], //3 - 0
        ["scripts/skills/perks/perk_legend_lacerate"], //3 - 1
        ["scripts/skills/perks/perk_steadfast"], //4
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
        ["scripts/skills/perks/perk_overwhelm"], //10
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

::B.Info[::Const.EntityType.Assassin].Builds["devious"] <- {
	Name = "devious",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_backstabber"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
		["scripts/skills/perks/perk_legend_back_to_basics"], //3 - 0
        ["scripts/skills/perks/perk_legend_lacerate"], //3 - 1
        ["scripts/skills/perks/perk_pocket_dirt"], //4
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
        ["scripts/skills/perks/perk_legend_blend_in"], //10
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

::B.Info[::Const.EntityType.Assassin].Builds["calm"] <- {
	Name = "calm",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_peaceful"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
		["scripts/skills/perks/perk_legend_back_to_basics"], //3 - 0
        ["scripts/skills/perks/perk_legend_recuperation"], //3 - 1
        ["scripts/skills/perks/perk_battle_flow"], //4
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
        ["scripts/skills/perks/perk_legend_perfect_focus"], //10
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