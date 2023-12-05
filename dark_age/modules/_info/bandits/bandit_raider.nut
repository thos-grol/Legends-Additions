//Bandit Raider
//Level 8 Raider template
//raider template, 7 perks
::Const.Tactical.Actor.BanditRaider <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 57,
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

::B.Info[::Const.EntityType.BanditRaider] <- {
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
			"scripts/items/weapons/legend_infantry_axe",
		],
		[
			"scripts/items/weapons/hooked_blade",
		],
		[
			"scripts/items/weapons/pike",
		],
		[
			"scripts/items/weapons/longaxe",
		],
		[
			"scripts/items/weapons/two_handed_wooden_hammer",
		],
		[
			"scripts/items/weapons/two_handed_mace",
		],
		[
			"scripts/items/weapons/legend_two_handed_club",
		],
		[
			"scripts/items/weapons/morning_star",
		],
	],
	Builds = {},
	BuildsChance = 40
};

//////////////////////////////////////////////////////////////////

::B.Info[::Const.EntityType.BanditRaider].Builds["1H Kite Shield"] <- {
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
			"scripts/items/weapons/boar_spear",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/morning_star",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/falchion",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/flail",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/military_pick",
			"scripts/items/shields/kite_shield"
		],
	]
};

::B.Info[::Const.EntityType.BanditRaider].Builds["1H Shield"] <- {
	Name = "1H Shield",
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
			"scripts/items/weapons/boar_spear",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/morning_star",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/falchion",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/flail",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/military_pick",
			"scripts/items/shields/wooden_shield"
		],
	]
};

::B.Info[::Const.EntityType.BanditRaider].Builds["1H Net"] <- {
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
			"scripts/items/weapons/morning_star"
		],
		[
			"scripts/items/weapons/falchion"
		],
		[
			"scripts/items/weapons/flail"
		],
		[
			"scripts/items/weapons/military_pick"
		],
	]
};

::B.Info[::Const.EntityType.BanditRaider].Builds["Chopper"] <- {
	Name = "1H Net",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["W", 4],
        ["scripts/skills/perks/perk_head_hunter"], //7
        ["D", 6],
        ["scripts/skills/perks/perk_strange_strikes"],
    ],
	LevelUps = [
		["Initiative", 7, 3, 3],
		["Melee Skill", 7, 3, 3],
		["Melee Defense", 7, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe"
		],
	]
};