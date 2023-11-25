//Lvl 6 Peasant template - Avg Daytaler stats

::Const.Tactical.Actor.CaravanHand <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 35,
	Stamina = 95,
	MeleeSkill = 56,
	RangedSkill = 40,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.CaravanHand] <- {
    Level = 6,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Melee Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
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
	BuildsChance = 15
};

::B.Info[::Const.EntityType.CaravanHand].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["T", 1],
        ["D", 2],
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Melee Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
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

