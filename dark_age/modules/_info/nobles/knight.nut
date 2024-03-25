//Level 11 template
//raider template, 10 perks
//has weapon mastery and stance
::Const.Tactical.Actor.Knight <- {
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

::B.Info[::Const.EntityType.Knight] <- {
    Level = 11,
	Builds = {},
	BuildsChance = 100
};

///////
::B.Info[::Const.EntityType.Knight].Builds["1h Axe"] <- {
	Name = "1h Axe",
	Pattern = [
        ["scripts/skills/perks/perk_underdog"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_strange_strikes"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_steadfast"], //4 - 1
        ["scripts/skills/perks/perk_shield_expert"], //4 - 2
		["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_fresh_and_furious"], //9
        ["scripts/skills/perks/perk_stance_executioner"], //10
    ],
	LevelUps = [
		["Health", 10, 3, 3],
		["Ranged Defense", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/fighting_axe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_axe",
		],
	],
};