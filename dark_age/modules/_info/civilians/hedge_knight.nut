//Lvl 10 Raider template
::Const.Tactical.Actor.HedgeKnight <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 60,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.HedgeKnight] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.HedgeKnight].Builds["Seismic"] <- {
	Name = "Seismic",
	Pattern = [
		["scripts/skills/perks/perk_legend_recuperation"], //1
        ["scripts/skills/perks/perk_battle_forged"], //2
        ["scripts/skills/perks/perk_pattern_recognition"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //0
        ["scripts/skills/perks/perk_mastery_hammerc"], //5
        ["scripts/skills/perks/perk_battle_flow"], //6
		["scripts/skills/perks/perk_hybridization"], //7
		["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_steadfast"], //9
        ["scripts/skills/perks/perk_stance_seismic_slam"], //10
        ["scripts/skills/perks/perk_legend_perfect_focus"], //11
    ],
	LevelUps = [
		["Melee Skill", 10, 3, 3],
		["Melee Defense", 10, 3, 3],
		["Ranged Defense", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greatsword",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_greatsword",
		],
	],
};

::B.Info[::Const.EntityType.HedgeKnight].Builds["Fist God"] <- {
	Name = "Fist God",
	Pattern = [
		["scripts/skills/perks/perk_colossus"], //1
        ["scripts/skills/perks/perk_battle_forged"], //2
        ["scripts/skills/perks/perk_legend_ambidextrous"], //3
        ["scripts/skills/perks/perk_mastery_fistc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //0
        ["scripts/skills/perks/perk_sundering_strikes"], //5
        ["scripts/skills/perks/perk_strange_strikes"], //6
		["scripts/skills/perks/perk_hybridization"], //7
		["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_mastery_hammer"], //9
        ["scripts/skills/perks/perk_stance_asura"], //10
        ["scripts/skills/perks/perk_legend_muscularity"], //11
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Melee Skill", 10, 3, 3],
		["Melee Defense", 10, 3, 3],
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

::B.Info[::Const.EntityType.HedgeKnight].Builds["Double Zwei"] <- {
	Name = "Double Zwei",
	Pattern = [
		["scripts/skills/perks/perk_colossus"], //1
        ["scripts/skills/perks/perk_battle_forged"], //2
        ["scripts/skills/perks/perk_legend_recuperation"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //0
        ["scripts/skills/perks/perk_sundering_strikes"], //5
        ["scripts/skills/perks/perk_strange_strikes"], //6
		["scripts/skills/perks/perk_hybridization"], //7
		["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_steadfast"], //9
        ["scripts/skills/perks/perk_stance_the_strongest"], //10
        ["scripts/skills/perks/perk_fresh_and_furious"], //11
    ],
	LevelUps = [
		["Melee Skill", 10, 3, 3],
		["Melee Defense", 10, 3, 3],
		["Ranged Defense", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greatsword",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_greatsword",
		],
	],
};

::B.Info[::Const.EntityType.HedgeKnight].Builds["Wrath"] <- {
	Name = "Wrath",
	Pattern = [
		["scripts/skills/perks/perk_colossus"], //1
        ["scripts/skills/perks/perk_battle_forged"], //2
        ["scripts/skills/perks/perk_legend_recuperation"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //0
        ["scripts/skills/perks/perk_adrenalin"], //5
        ["scripts/skills/perks/perk_strange_strikes"], //6
		["scripts/skills/perks/perk_berserk"], //7
		["scripts/skills/perks/perk_death_dealer"], //8
        ["scripts/skills/perks/perk_steadfast"], //9
        ["scripts/skills/perks/perk_stance_wrath"], //10
        ["scripts/skills/perks/perk_vengeance"], //11
    ],
	LevelUps = [
		["Melee Skill", 10, 3, 3],
		["Melee Defense", 10, 3, 3],
		["Ranged Defense", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greatsword",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_greatsword",
		],
	],
};