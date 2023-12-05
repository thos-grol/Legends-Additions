//Level 11 Raider template
//raider template, 10 perks
//has weapon mastery, stance, and destiny

//Bandit Warlord Builds
::Const.Tactical.Actor.BanditWarlord <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 80,
	Stamina = 96,
	MeleeSkill = 65,
	RangedSkill = 40,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.BanditWarlord] <- {
    Level = 11,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.BanditWarlord].Builds["Commander"] <- {
	Name = "Commander",
	Pattern = [
		["scripts/skills/perks/perk_lead_by_example"], //1
        ["scripts/skills/perks/perk_underdog"], //1, //2
        ["scripts/skills/perks/perk_trial_by_fire"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_legend_recuperation"], //4 - 1
        ["scripts/skills/perks/perk_shield_expert"], //4 - 2
		["scripts/skills/perks/perk_legend_wind_reader"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
        ["scripts/skills/perks/perk_inspiring_presence"], //10
        ["scripts/skills/perks/perk_pattern_recognition"], //11
    ],
	LevelUps = [
		["Health", 11, 3, 3],
		["Melee Defense", 11, 3, 3],
		["Ranged Defense", 11, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/qatal_dagger",
			"scripts/items/shields/kite_shield",
		],
		[
			"scripts/items/weapons/oriental/qatal_dagger",
			"scripts/items/shields/heater_shield",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_qatal_dagger",
			"scripts/items/shields/named/named_bandit_kite_shield"
		],
		[
			"scripts/items/weapons/named/named_qatal_dagger",
			"scripts/items/shields/named/named_bandit_heater_shield"
		],
	],
};

::B.Info[::Const.EntityType.BanditWarlord].Builds["King Chopper"] <- {
	Name = "King Chopper",
	Pattern = [
		["scripts/skills/perks/perk_underdog"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_strange_strikes"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_steadfast"], //4 - 1
        ["scripts/skills/perks/perk_mastery_hammerc"], //4 - 2
		["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_stance_executioner"], //9
		["scripts/skills/perks/perk_vengeance"], //10
		["scripts/skills/perks/perk_pattern_recognition"], //11
    ],
	LevelUps = [
		["Health", 11, 3, 3],
		["Melee Skill", 11, 3, 3],
		["Melee Defense", 11, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/fighting_axe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_axe",
		],
	],
};