//Lvl 11 Barbarian template
::Const.Tactical.Actor.BarbarianChosen <- {
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

::B.Info[::Const.EntityType.BarbarianChosen] <- {
    Level = 11,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.BarbarianChosen].Builds["Cleaver HP"] <- {
	Name = "Cleaver",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_cleaverc"], //4
        ["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_legend_lacerate"], //8
        ["scripts/skills/perks/perk_stance_gourmet"], //9
		["scripts/skills/perks/perk_legend_muscularity"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Skill", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/rusty_warblade",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_rusty_warblade",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianChosen].Builds["Cleaver Fresh"] <- {
	Name = "Cleaver Fresh",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_cleaverc"], //4
        ["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_legend_lacerate"], //8
        ["scripts/skills/perks/perk_stance_gourmet"], //9
		["scripts/skills/perks/perk_fresh_and_furious"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Skill", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/rusty_warblade",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_rusty_warblade",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianChosen].Builds["Sealing Cleaver"] <- {
	Name = "Sealing Cleaver",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_hammerc"], //4
        ["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_legend_lacerate"], //8
        ["scripts/skills/perks/perk_stance_seismic_slam"], //9
		["scripts/skills/perks/perk_indomitable"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Skill", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/rusty_warblade",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_rusty_warblade",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianChosen].Builds["Axe Vegeance"] <- {
	Name = "Axe Vegeance",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_strange_strikes"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_berserk"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_dismemberment"], //8
        ["scripts/skills/perks/perk_vengeance"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Skill", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/heavy_rusty_axe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_heavy_rusty_axe",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianChosen].Builds["Axe Vegeance"] <- {
	Name = "Axe Vegeance Roundswinger",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_strange_strikes"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_berserk"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_death_dealer"], //7
        ["scripts/skills/perks/perk_dismemberment"], //8
        ["scripts/skills/perks/perk_vengeance"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Skill", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/heavy_rusty_axe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_heavy_rusty_axe",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianChosen].Builds["Fresh Axe"] <- {
	Name = "Fresh Axe",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_strange_strikes"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_steadfast"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_dismemberment"], //8
        ["scripts/skills/perks/perk_fresh_and_furious"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Skill", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/heavy_rusty_axe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_heavy_rusty_axe",
		],
	],
};