//Lvl 6 Peasant template - Avg Daytaler stats
::Const.Tactical.Actor.NomadSlinger <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
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

::B.Info[::Const.EntityType.NomadSlinger] <- {
    Level = 6,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_hybridization"],
    ],
	LevelUps = [
		["Health", 5, 0, 2],
		["Ranged Skill", 5, 0, 2],
		["Melee Defense", 5, 0, 2],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/oriental/nomad_sling",
		]
	],
	Builds = {},
	BuildsChance = 0
};