::Const.Tactical.Actor.CultistChosen <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
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

::B.Info[::Const.EntityType.CultistChosen] <- {
    Level = 11,
    Pattern = [
        ["scripts/skills/perks/perk_underdog"], //1
        ["scripts/skills/perks/perk_legend_specialist_cult_hood"],
        ["scripts/skills/perks/perk_strange_strikes"], //3
        ["scripts/skills/perks/perk_mastery_cleaverc"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_steadfast"], //4 - 1
        ["scripts/skills/perks/perk_legend_recuperation"], //4 - 2
		["scripts/skills/perks/perk_fitness"], //5
		["scripts/skills/perks/perk_legend_specialist_cult_armor"],
        ["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_fresh_and_furious"], //9
        ["scripts/skills/perks/perk_stance_gourmet"], //10
    ],
	LevelUps = [
		["Resolve", 10, 3, 3],
		["Melee Skill", 10, 3, 3],
		["Melee Defense", 10, 3, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/named/named_legend_great_khopesh",
		],
	],
	Builds = {},
	BuildsChance = 0
};

//////////////////////////////////////////////////////////////////