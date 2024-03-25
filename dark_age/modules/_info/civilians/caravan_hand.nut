//Lvl 5 Peasant template

::Const.Tactical.Actor.CaravanHand <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 50,
	Stamina = 100,
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

::B.Info[::Const.EntityType.CaravanHand] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Health", 4, 0, 1],
		["Fatigue", 4, 0, 1],
	],
    Outfit = [
		[
			1,
			"caravan_hand_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/hatchet",
		],
		[
			"scripts/items/weapons/bludgeon",
		],
		[
			"scripts/items/weapons/militia_spear",
		],
		[
			"scripts/items/weapons/scramasax",
		],
		[
			"scripts/items/weapons/legend_militia_glaive",
		]
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/hatchet",
		],
		[
			"scripts/items/weapons/bludgeon",
		],
		[
			"scripts/items/weapons/militia_spear",
		],
		[
			"scripts/items/weapons/scramasax",
		],
		[
			"scripts/items/weapons/legend_militia_glaive",
		]
	],
	Builds = {},
	BuildsChance = 10
};

::B.Info[::Const.EntityType.CaravanHand].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["T", 1],
        ["D", 2],
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4],
    ],
	LevelUps = [
		["Health", 4, 0, 1],
		["Fatigue", 4, 0, 1],
	],
	Loadout = [
		[
			"scripts/items/weapons/hatchet",
		],
		[
			"scripts/items/weapons/bludgeon",
		],
		[
			"scripts/items/weapons/militia_spear",
		],
		[
			"scripts/items/weapons/scramasax",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/hatchet",
		],
		[
			"scripts/items/weapons/bludgeon",
		],
		[
			"scripts/items/weapons/militia_spear",
		],
		[
			"scripts/items/weapons/scramasax",
		],
	],
};

