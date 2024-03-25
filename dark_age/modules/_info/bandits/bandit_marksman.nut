//Bandit Raider
//Level 7, 6 perks
::Const.Tactical.Actor.BanditMarksman <- {
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

::B.Info[::Const.EntityType.BanditMarksman] <- {
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
		["Ranged Skill", 6, 0, 2],
		["Health", 3, 0, 2],
		["Fatigue", 3, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/hunting_bow",
		],
		[
			"scripts/items/weapons/light_crossbow",
		],
		[
			"scripts/items/weapons/crossbow",
		],
	]
};