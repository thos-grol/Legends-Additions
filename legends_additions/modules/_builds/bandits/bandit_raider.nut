//Bandit Raider
//Level 8 Raider template
//raider template, 7 perks
::Const.Tactical.Actor.BanditRaider <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 47,
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
    Level = 6,
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
		["Health", 7, 0],
		["Melee Skill", 7, 0],
		["Melee Defense", 7, 0],
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
			"scripts/items/weapons/boar_spear",
		],
		[
			"scripts/items/weapons/morning_star",
		],
		[
			"scripts/items/weapons/falchion",
		],
		[
			"scripts/items/weapons/flail",
		],
		[
			"scripts/items/weapons/military_pick",
		],
	],
	Builds = {}
};

///////


// ::B.Info[::Const.EntityType.BanditRaider].Builds.