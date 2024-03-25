//Lvl 7 Raider template

::Const.Tactical.Actor.CaravanGuard <- {
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

::B.Info[::Const.EntityType.CaravanGuard] <- {
    Level = 7,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
    ],
	LevelUps = [
		["Health", 6, 0, 1],
		["Fatigue", 6, 0, 1],
	],
    Outfit = [
		[
			1,
			"caravan_guard_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe",
		],
		[
			"scripts/items/weapons/boar_spear",
		],
		[
			"scripts/items/weapons/falchion",
		],
		[
			"scripts/items/weapons/legend_glaive",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/hand_axe",
		],
		[
			"scripts/items/weapons/boar_spear",
		],
		[
			"scripts/items/weapons/falchion",
		],
		[
			"scripts/items/weapons/legend_glaive",
		],
	],
	Builds = {},
	BuildsChance = 15
};

::B.Info[::Const.EntityType.CaravanGuard].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 6, 0, 2],
		["Ranged Defense", 6, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/boar_spear",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/hand_axe",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/falchion",
			"scripts/items/shields/wooden_shield"
		],
		[
			"scripts/items/weapons/legend_glaive",
			"scripts/items/shields/wooden_shield"
		],
	]
};

::B.Info[::Const.EntityType.CaravanGuard].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["T", 1],
        ["D", 2],
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_legend_net_casting"],
    ],
	LevelUps = [
		["Health", 6, 0, 1],
		["Fatigue", 6, 0, 1],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe",
		],
		[
			"scripts/items/weapons/boar_spear",
		],
		[
			"scripts/items/weapons/falchion",
		],
		[
			"scripts/items/weapons/legend_glaive",
		],
	]
};