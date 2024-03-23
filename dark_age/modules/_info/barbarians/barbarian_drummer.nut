//Drummer
//Level 5, 4 perks
::Const.Tactical.Actor.BarbarianDrummer <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 10,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.BarbarianDrummer] <- {
    Level = 5,
    Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2],
        ["scripts/skills/perks/perk_hold_out"], //3
        ["scripts/skills/perks/perk_legend_drums_of_war"], //4
    ],
	LevelUps = [
		["Initiative", 4, 0, 2],
		["Ranged Defense", 4, 0, 2],
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