//Level 8 Raider template
//barbarian template, 7 perks
::Const.Tactical.Actor.BarbarianDrummer <- {
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

::B.Info[::Const.EntityType.BarbarianDrummer] <- {
    Level = 8,
    Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["scripts/skills/perks/perk_hold_out"],
        ["scripts/skills/perks/perk_colossus"],
        ["scripts/skills/perks/perk_nine_lives"],
        ["D", 6],
        ["scripts/skills/perks/perk_legend_drums_of_war"],
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Initiative", 7, 0, 2],
		["Health", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/barbarians/drum_item",
		]
	],
	Builds = {},
	BuildsChance = 0
};