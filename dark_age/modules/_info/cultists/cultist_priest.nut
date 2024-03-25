::Const.Tactical.Actor.CultistPriest <- {
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

::B.Info[::Const.EntityType.CultistPriest] <- {
    Level = 10,
    Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"],
        ["scripts/skills/perks/perk_legend_specialist_cult_hood"],
        ["scripts/skills/perks/perk_legend_wind_reader"],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_legend_peaceful"], //4 - 1
        ["scripts/skills/perks/perk_legend_specialist_cult_armor"],
        ["scripts/skills/perks/perk_fearsome"], //7
        ["scripts/skills/perks/perk_stance_prisoner"], //8
    ],
	LevelUps = [
		["Resolve", 10, 3, 3],
		["Health", 10, 3, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/orc_flail_2h",
		],
	],
	Builds = {},
	BuildsChance = 0
};

//////////////////////////////////////////////////////////////////