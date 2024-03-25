//Zombie
::Const.Tactical.Actor.Zombie <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 30,
	MeleeDefense = -10,
	RangedDefense = 0,
	Initiative = 160,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};

::Const.Tactical.Actor.ZombiePlayer <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 30,
	MeleeDefense = -10,
	RangedDefense = 0,
	Initiative = 160,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};

::B.Info[::Const.EntityType.Zombie] <- {
    Level = 5,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.Zombie].Builds["Default"] <- {
	Name = "Default",
	Pattern = [
        ["T", 1],
		["T", 1],
        ["D", 2],
        ["T", 3],
    ],
	LevelUps = [],
	Loadout = [],
};