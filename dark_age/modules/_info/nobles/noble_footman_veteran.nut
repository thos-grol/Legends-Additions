::Const.Tactical.Actor.LegendNobleGuard <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 20,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.LegendNobleGuard] <- {
    Level = 7,
    Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["T", 1],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["W", 3],
        ["D", 6],
    ],
	LevelUps = [
		["Health", 6, 2, 3],
		["Fatigue", 6, 2, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/military_pick"
        ],
        [
        	"scripts/items/weapons/arming_sword"
        ],
        [
        	"scripts/items/weapons/fighting_axe"
        ],
        [
        	"scripts/items/weapons/morning_star"
        ]
	],
	Builds = {},
	BuildsChance = 0
};

///////