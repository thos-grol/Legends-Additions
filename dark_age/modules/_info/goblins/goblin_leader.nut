::Const.Tactical.Actor.GoblinLeader <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 65,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.GoblinLeader] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.GoblinLeader].Builds["Warbow Balanced"] <- {
	Name = "Warbow Balanced",
	Pattern = [
        ["scripts/skills/perks/perk_lead_by_example"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_wind_reader"], //3
        ["scripts/skills/perks/perk_mastery_rangedc"], //4
        ["scripts/skills/perks/perk_legend_recuperation"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_legend_peaceful"], //7
        ["scripts/skills/perks/perk_trial_by_fire"], //7
        ["scripts/skills/perks/perk_stance_marksman"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Ranged Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/goblin_crossbow",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/greenskins/goblin_crossbow",
		],
	],
};