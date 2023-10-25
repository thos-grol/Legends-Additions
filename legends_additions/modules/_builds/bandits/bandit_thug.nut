//Bandit Thug
//Lvl 6 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.BanditThug <- {
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

::B.Info[::Const.EntityType.BanditThug] <- {
    Level = 6,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 5, 0],
		["Melee Skill", 5, 0],
		["Melee Defense", 5, 0],
	],
    Trait = [],
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
};