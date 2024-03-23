//Thrall
//Level 5, 4 perks

::Const.Tactical.Actor.BarbarianThrall <- {
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

::B.Info[::Const.EntityType.BarbarianThrall] <- {
    Level = 5,
    Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["scripts/skills/perks/perk_adrenalin"],
		["scripts/skills/perks/perk_survival_instinct"], //8
    ],
	LevelUps = [
		["Initiative", 4, 0, 2],
		["Ranged Defense", 4, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/blunt_cleaver",
		],
		[
			"scripts/items/weapons/barbarians/crude_axe",
		],
	],
	Builds = {},
	BuildsChance = 15
};

::B.Info[::Const.EntityType.BarbarianThrall].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["scripts/skills/perks/perk_rotation"],
        ["scripts/skills/perks/perk_adrenalin"],
        ["T", 5],
    ],
	LevelUps = [
		["Initiative", 4, 0, 2],
		["Ranged Defense", 4, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/crude_axe",
			"scripts/items/shields/wooden_shield_old"
		],
	]
};

