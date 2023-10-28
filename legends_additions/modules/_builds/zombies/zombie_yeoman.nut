//Zombie
::Const.Tactical.Actor.ZombieYeoman <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 5,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 150,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};

::B.Info[::Const.EntityType.ZombieYeoman] <- {
    Level = 8,
    Pattern = [
        ["T", 1],
		["T", 1],
        ["D", 2],
        ["T", 3],
		["T", 3],
        ["T", 5],
        ["T", 5],
    ],
	LevelUps = [],
    Trait = [],
	Loadout = [],
};
