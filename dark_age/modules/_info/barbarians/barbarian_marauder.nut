//Barbarian Marauder
//Level 7, 6 perks

::Const.Tactical.Actor.BarbarianMarauder <- {
	XP = 100,
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

::B.Info[::Const.EntityType.BarbarianMarauder] <- {
    Level = 7,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.BarbarianMarauder].Builds["Duelist"] <- {
	Name = "Duelist",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["scripts/skills/perks/perk_adrenalin"],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"],
		
    ],
	LevelUps = [
		["Initiative", 6, 0, 2],
		["Ranged Defense", 6, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/axehammer",
		],
		[
			"scripts/items/weapons/barbarians/crude_axe",
		],
		[
			"scripts/items/weapons/barbarians/blunt_cleaver",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianMarauder].Builds["Shield"] <- {
	Name = "Shield",
	Pattern = [
		["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
		["scripts/skills/perks/perk_shield_expert"],
        ["scripts/skills/perks/perk_survival_instinct"], //8
        ["D", 6],
		
    ],
	LevelUps = [
		["Health", 6, 0, 2],
		["Ranged Defense", 6, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/axehammer",
			"scripts/items/shields/wooden_shield_old"
		],
		[
			"scripts/items/weapons/barbarians/crude_axe",
			"scripts/items/shields/wooden_shield_old"
		],
		[
			"scripts/items/weapons/barbarians/blunt_cleaver",
			"scripts/items/shields/wooden_shield_old"
		],
	],
};

::B.Info[::Const.EntityType.BarbarianMarauder].Builds["Bludgeon"] <- {
	Name = "Bludgeon",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["scripts/skills/perks/perk_adrenalin"],
        ["scripts/skills/perks/perk_strange_strikes"],
        ["W", 4],
        ["D", 6],
    ],
	LevelUps = [
		["Initiative", 6, 0, 2],
		["Ranged Defense", 6, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/skull_hammer",
		],
		[
			"scripts/items/weapons/barbarians/two_handed_spiked_mace",
		],
	],
};

::B.Info[::Const.EntityType.BarbarianMarauder].Builds["Chopper"] <- {
	Name = "1H Net",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_strange_strikes"],
		
    ],
	LevelUps = [
		["Initiative", 6, 0, 2],
		["Ranged Defense", 6, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/barbarians/crude_axe",
		],
	]
};