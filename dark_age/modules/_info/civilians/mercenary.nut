//merc template, 7 perks
::Const.Tactical.Actor.Mercenary <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.Mercenary] <- {
    Level = 8,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["T", 3],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/pike",
		],
		[
			"scripts/items/weapons/bardiche",
		]
	],
	Builds = {},
	BuildsChance = 60
};

//////////////////////////////////////////////////////////////////

::B.Info[::Const.EntityType.Mercenary].Builds["1H Kite Shield"] <- {
	Name = "1H Kite Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/fighting_spear",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/hand_axe",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/morning_star",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/flail",
			"scripts/items/shields/heater_shield"
		],
		[
			"scripts/items/weapons/military_pick",
			"scripts/items/shields/heater_shield"
		],
	]
};

::B.Info[::Const.EntityType.Mercenary].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["T", 1],
        ["D", 2],
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["scripts/skills/perks/perk_legend_net_casting"],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe"
		],
		[
			"scripts/items/weapons/fighting_spear"
		],
		[
			"scripts/items/weapons/morning_star"
		],
		[
			"scripts/items/weapons/flail"
		],
		[
			"scripts/items/weapons/military_pick"
		],
	]
};

::B.Info[::Const.EntityType.Mercenary].Builds["1H Duelist"] <- {
	Name = "1H Duelist",
	Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 1], //5
        ["D", 6], //6
        ["scripts/skills/perks/perk_duelist"], //8
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe"
		],
		[
			"scripts/items/weapons/fighting_spear"
		],
		[
			"scripts/items/weapons/morning_star"
		],
		[
			"scripts/items/weapons/flail"
		],
		[
			"scripts/items/weapons/military_pick"
		],
	]
};