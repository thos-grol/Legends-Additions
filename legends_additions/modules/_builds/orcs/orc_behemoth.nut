::Const.Tactical.Actor.LegendOrcBehemoth <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 800,
	Bravery = 65,
	Stamina = 150,
	MeleeSkill = 55,
	RangedSkill = 50,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 110,
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
    Level = 20,
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
		["Initiative", 8, 1, 3],
		["Melee Skill", 8, 1, 3],
		["Melee Defense", 8, 1, 3],
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