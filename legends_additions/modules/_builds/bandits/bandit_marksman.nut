//Bandit Rabble
//Lvl 9 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.BanditMarksman <- {
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

::B.Info[::Const.EntityType.BanditMarksman] <- {
    Level = 9,
	Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["T", 3],
		["Z", "scripts/skills/perks/perk_hybridization"],
    ],
	LevelUps = [
		["Health", 8, 0, 2],
		["Ranged Skill", 8, 0, 2],
		["Melee Defense", 8, 0, 2],
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