//Zombie

gt.Const.Tactical.Actor.ZombieKnight <- {
	XP = 1000,
	ActionPoints = 9,
	Hitpoints = 250,
	Bravery = 110,
	Stamina = 100,
	MeleeSkill = 100,
	RangedSkill = 0,
	MeleeDefense = 40,
	RangedDefense = 0,
	Initiative = 60,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};


::B.Info[::Const.EntityType.ZombieKnight] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.ZombieKnight].Builds["Default"] <- {
	Name = "Default",
	Pattern = [
        ["T", 1],
		["T", 1],
        ["D", 2],
        ["T", 3],
        ["T", 3],
        ["D", 6],
		["T", 5],
		["T", 5],
    ],
	LevelUps = [],
	Loadout = [],
	NamedLoadout = [],
};