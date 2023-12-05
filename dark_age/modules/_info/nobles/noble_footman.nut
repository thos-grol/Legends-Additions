::Const.Tactical.Actor.Footman <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 57,
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

::B.Info[::Const.EntityType.Footman] <- {
    Level = 8,
    Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 7, 1, 3],
		["Melee Skill", 7, 1, 3],
		["Melee Defense", 7, 1, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/military_pick",
		],
		[
			"scripts/items/weapons/arming_sword",
		],
		[
			"scripts/items/weapons/falchion",
		],
	],
	Builds = {},
	BuildsChance = 0
};

//////////////////////////////////////////////////////////////////