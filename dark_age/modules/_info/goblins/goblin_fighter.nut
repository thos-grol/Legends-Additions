
::Const.Tactical.Actor.GoblinFighter <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.GoblinFighter] <- {
    Level = 5,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Initiative", 4, 0, 2],
		["Ranged Defense", 4, 0, 2],
	],
    Trait = [],
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
    ],
	LevelUps = [
		["Initiative", 5, 0, 2],
		["Ranged Defense", 5, 0, 2],
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

