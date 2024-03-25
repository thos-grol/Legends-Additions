::Const.Tactical.Actor.OrcBerserker <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 200,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 50,
	RangedSkill = 30,
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

::B.Info[::Const.EntityType.OrcBerserker] <- {
    Level = 8,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["T", 5],
    ],
	LevelUps = [
		["Initiative", 7, 0, 2],
		["Ranged Skill", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/greenskins/orc_flail_2h"
        ],
        [
        	"scripts/items/weapons/greenskins/orc_axe_2h"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_limb_lopper"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_man_mangler"
        ],
		[
        	"scripts/items/weapons/greenskins/legend_skullbreaker"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_bough"
        ]
	],
	NamedLoadout = [
		[
        	"scripts/items/weapons/greenskins/legend_bough"
        ]    
	],
	Builds = {},
	BuildsChance = 0
};