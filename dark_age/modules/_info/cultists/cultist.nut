//Level 9 Raider template
//raider template, 7 perks
::Const.Tactical.Actor.Cultist <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
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

::B.Info[::Const.EntityType.Cultist] <- {
    Level = 9,
    Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"],
        ["scripts/skills/perks/perk_legend_specialist_cult_hood"],
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_strange_strikes"], //7
        ["D", 6],
        ["scripts/skills/perks/perk_legend_specialist_cult_armor"],
        ["scripts/skills/perks/perk_duelist"], //7
    ],
	LevelUps = [
		["Resolve", 8, 3, 3],
		["Melee Skill", 8, 0, 3],
		["Melee Defense", 8, 0, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/ancient/khopesh",
		],
	],
	Builds = {},
	BuildsChance = 25
};

//////////////////////////////////////////////////////////////////

::B.Info[::Const.EntityType.Cultist].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"],
        ["scripts/skills/perks/perk_legend_specialist_cult_hood"],
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4],
        ["scripts/skills/perks/perk_strange_strikes"], //7
        ["D", 6],
        ["scripts/skills/perks/perk_legend_specialist_cult_armor"],
        ["scripts/skills/perks/perk_legend_net_casting"],

    ],
	LevelUps = [
		["Resolve", 8, 3, 3],
		["Melee Skill", 8, 0, 3],
		["Melee Defense", 8, 0, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/ancient/khopesh",
		],
	],
};