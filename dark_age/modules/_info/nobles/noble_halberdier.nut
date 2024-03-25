::Const.Tactical.Actor.LegendHalberdier <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 120,
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

::B.Info[::Const.EntityType.LegendHalberdier] <- {
    Level = 7,
    Pattern = [
		["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
		["scripts/skills/perks/perk_strange_strikes"], //4 - 1
        ["W", 4], //4
        ["T", 3], //5
        ["D", 6], //6
        ["T", 5], //7
        ["T", 5], //8
    ],
	LevelUps = [
		["Health", 8, 2, 3],
		["Melee Defense", 8, 2, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/legend_halberd"
        ],
	],
	Builds = {},
	BuildsChance = 0
};

///////