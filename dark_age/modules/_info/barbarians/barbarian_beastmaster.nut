//Level 8 Raider template
//barbarian template, 7 perks

::Const.Tactical.Actor.BarbarianBeastmaster <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 60,
	Stamina = 110,
	MeleeSkill = 60,
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

::B.Info[::Const.EntityType.BarbarianBeastmaster] <- {
    Level = 8,
    Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["scripts/skills/perks/perk_adrenalin"],
        ["W", 3],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"],
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Initiative", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/thorned_whip",
		]
	],
	Builds = {},
	BuildsChance = 0
};