::Const.Tactical.Actor.Gunner <- {
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

::B.Info[::Const.EntityType.Gunner] <- {
    Level = 9,
    Pattern = [
        ["scripts/skills/perks/perk_head_hunter"], //1
        ["D", 2], //2
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_legend_peaceful"], //4 - 1
        ["scripts/skills/perks/perk_fearsome"], //4 - 2
        ["D", 6],
		["scripts/skills/perks/perk_mastery_hammer"], //5
    ],
	LevelUps = [
		["Health", 8, 3, 3],
		["Ranged Defense", 8, 2, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/oriental/handgonne"
        ],
	],
	Builds = {},
	BuildsChance = 0
};