//Level 5, 4 perks
::Const.Tactical.Actor.Cultist <- {
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

::B.Info[::Const.EntityType.Cultist] <- {
    Level = 8,
    Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"],
        ["scripts/skills/perks/perk_legend_specialist_cult_hood"],
        ["W", 3],
        ["W", 4],
    ],
	LevelUps = [
		["Resolve", 4, 3, 3],
		["Health", 4, 0, 3],
	],
	Outfit = [
		[
			1,
			"bandit_thug_outfit_00"
		]
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/ancient/khopesh",
		],
		[
			"scripts/items/weapons/legend_chain",
		],
		[
			"scripts/items/weapons/greenskins/orc_flail_2h",
		],
	],
};

//////////////////////////////////////////////////////////////////