::Const.Tactical.Actor.OrcBerserker <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 200,
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
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
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