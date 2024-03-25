::Const.Tactical.Actor.CultistKnight <- {
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

::B.Info[::Const.EntityType.CultistKnight] <- {
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
		["Health", 10, 3, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/ancient/legend_great_khopesh",
		],
	],
	Builds = {},
	BuildsChance = 0
};

//////////////////////////////////////////////////////////////////