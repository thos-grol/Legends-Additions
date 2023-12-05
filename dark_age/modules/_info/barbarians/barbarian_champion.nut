//Lvl 10 Raider template
::Const.Tactical.Actor.BarbarianChampion <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 60,
	Stamina = 110,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.BarbarianChampion] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.BarbarianChampion].Builds["Hammer"] <- {
	Name = "Hammer",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_hammerc"], //4
        ["scripts/skills/perks/perk_rattle"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_fitness"], //7
        ["scripts/skills/perks/perk_steadfast"], //8
        ["scripts/skills/perks/perk_stance_seismic_slam"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/skull_hammer",
		],
		[
			"scripts/items/weapons/barbarians/two_handed_spiked_mace",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_skullhammer",
		],
		[
			"scripts/items/weapons/named/named_two_handed_spiked_mace",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianChampion].Builds["Cleaver"] <- {
	Name = "Shamshir",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_cleaverc"], //4
        ["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_steadfast"], //7
        ["scripts/skills/perks/perk_dismemberment"], //8
        ["scripts/skills/perks/perk_stance_gourmet"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
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

::B.Info[::Const.EntityType.BarbarianChampion].Builds["Axe"] <- {
	Name = "Shamshir",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_steadfast"], //7
        ["scripts/skills/perks/perk_dismemberment"], //8
        ["scripts/skills/perks/perk_stance_executioner"], //9
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
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
