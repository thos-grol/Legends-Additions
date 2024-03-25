//Bandit Thug
//Lvl 5 Peasant template - Avg Daytaler stats

::Const.Tactical.Actor.BanditThug <- {
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

::B.Info[::Const.EntityType.BanditThug] <- {
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
			"bandit_thug_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/woodcutters_axe",
		],
		[
			"scripts/items/weapons/goedendag",
		],
		[
			"scripts/items/weapons/pitchfork",
		],
		[
			"scripts/items/weapons/hatchet",
		],
		[
			"scripts/items/weapons/bludgeon",
		],
		[
			"scripts/items/weapons/pickaxe",
		],
		[
			"scripts/items/weapons/reinforced_wooden_flail",
		],
		[
			"scripts/items/weapons/legend_militia_glaive",
		],
		[
			"scripts/items/weapons/legend_ranged_wooden_flail",
		]
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/woodcutters_axe",
		],
		[
			"scripts/items/weapons/goedendag",
		],
		[
			"scripts/items/weapons/pitchfork",
		],
		[
			"scripts/items/weapons/hatchet",
		],
		[
			"scripts/items/weapons/bludgeon",
		],
		[
			"scripts/items/weapons/pickaxe",
		],
		[
			"scripts/items/weapons/reinforced_wooden_flail",
		],
		[
			"scripts/items/weapons/legend_militia_glaive",
		],
		[
			"scripts/items/weapons/legend_ranged_wooden_flail",
		]
	]
};

// ::B.Info[::Const.EntityType.BanditThug].Builds["1H Net"] <- {
// 	Name = "1H Net",
// 	Pattern = [
//         ["T", 1],
//         ["D", 2],
//         ["scripts/skills/perks/perk_legend_net_repair"],
//         ["W", 4],
//     ],
// 	LevelUps = [
// 		["Health", 4, 0, 1],
// 		["Fatigue", 4, 0, 1],
// 		["Ranged Skill", 4, 0, 1],
// 	],
// 	Loadout = [
// 		[
// 			"scripts/items/weapons/hatchet",
// 		],
// 		[
// 			"scripts/items/weapons/bludgeon",
// 		],
// 		[
// 			"scripts/items/weapons/reinforced_wooden_flail",
// 		],
// 		[
// 			"scripts/items/weapons/legend_militia_glaive",
// 		]
// 	],
// 	NamedLoadout = [
// 		[
// 			"scripts/items/weapons/hatchet",
// 		],
// 		[
// 			"scripts/items/weapons/bludgeon",
// 		],
// 		[
// 			"scripts/items/weapons/reinforced_wooden_flail",
// 		],
// 		[
// 			"scripts/items/weapons/legend_militia_glaive",
// 		]
// 	],
// };

