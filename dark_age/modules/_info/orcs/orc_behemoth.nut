::Const.Tactical.Actor.LegendOrcBehemoth <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 600,
	Bravery = 100,
	Stamina = 150,
	MeleeSkill = 50,
	RangedSkill = 40,
	MeleeDefense = -10,
	RangedDefense = 0,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.0
};

::B.Info[::Const.EntityType.LegendOrcBehemoth] <- {
    Level = 10,
    Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 3], //5
        ["D", 6], //6
        ["T", 5], //7
        ["T", 5], //8
		["W", 7], //9
    ],
	LevelUps = [
		["Ranged Skill", 8, 1, 3],
		["Health", 8, 1, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/greenskins/legend_limb_lopper"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_bough"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_man_mangler"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_skullbreaker"
        ]
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_orc_axe_2h",
		],
		[
			"scripts/items/weapons/named/named_orc_flail_2h",
		],
	],
	Builds = {},
	BuildsChance = 0
};