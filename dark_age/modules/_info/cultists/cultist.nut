//Level 9 Raider template
//raider template, 7 perks
::Const.Tactical.Actor.Cultist <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 96,
	MeleeSkill = 45,
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

::B.Info[::Const.EntityType.Cultist] <- {
    Level = 8,
    Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"],
        ["scripts/skills/perks/perk_legend_specialist_cult_hood"],
        ["W", 3],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_legend_specialist_cult_armor"],
        ["scripts/skills/perks/perk_duelist"], //7
    ],
	LevelUps = [
		["Resolve", 7, 3, 3],
		["Melee Skill", 7, 0, 3],
		["Melee Defense", 7, 0, 3],
	],
	Outfit = [
		[
			1,
			"bandit_thug_outfit_00"
		]
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/ancient/khopesh",
		],
		[
			"scripts/items/weapons/legend_chain",
		],
		[
			"scripts/items/weapons/greenskins/orc_flail_2h",
		],
	],
	Builds = {},
	BuildsChance = 20
};

//////////////////////////////////////////////////////////////////

::B.Info[::Const.EntityType.Cultist].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"],
        ["scripts/skills/perks/perk_legend_specialist_cult_hood"],
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_legend_specialist_cult_armor"],
        ["scripts/skills/perks/perk_legend_net_casting"],

    ],
	LevelUps = [
		["Resolve", 7, 3, 3],
		["Melee Skill", 7, 0, 3],
		["Melee Defense", 7, 0, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/ancient/khopesh",
		],
	],
};