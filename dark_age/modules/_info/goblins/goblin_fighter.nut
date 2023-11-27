
::Const.Tactical.Actor.GoblinFighter <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 65,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.GoblinFighter] <- {
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
    Trait = [],
    Outfit = [
		[
			1,
			"bandit_thug_outfit_00"
		]
	],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/goblin_falchion",
		],
		[
			"scripts/items/weapons/greenskins/goblin_spear",
		],
		[
			"scripts/items/weapons/greenskins/goblin_notched_blade",
		],
		[
			"scripts/items/weapons/greenskins/goblin_pike",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_goblin_falchion",
		],
		[
			"scripts/items/weapons/named/named_goblin_pike",
		],
		[
			"scripts/items/weapons/named/named_goblin_spear",
		],
	],
	Builds = {},
	BuildsChance = 15
};

::B.Info[::Const.EntityType.GoblinFighter].Builds["1H Net"] <- {
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
			"scripts/items/weapons/greenskins/goblin_falchion",
		],
		[
			"scripts/items/weapons/greenskins/goblin_spear",
		],
		[
			"scripts/items/weapons/greenskins/goblin_notched_blade",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_goblin_falchion",
		],
		[
			"scripts/items/weapons/named/named_goblin_spear",
		],
	],
};

