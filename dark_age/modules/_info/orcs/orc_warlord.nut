::Const.Tactical.Actor.OrcWarlord <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 200,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 60,
	RangedSkill = 30,
	MeleeDefense = -10,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.0
};

::B.Info[::Const.EntityType.OrcWarlord] <- {
    Level = 11,
	Builds = {},
	BuildsChance = 100
};

///////

::B.Info[::Const.EntityType.OrcWarlord].Builds["Axe"] <- {
	Name = "Axe",
	Pattern = [
        ["scripts/skills/perks/perk_head_hunter"], //1
        ["D", 2],
        ["scripts/skills/perks/perk_hold_out"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_mastery_hammerc"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_berserk"], //8
        ["scripts/skills/perks/perk_stance_seismic_slam"], //9
        ["scripts/skills/perks/perk_vengeance"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/orc_axe_2h",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_orc_axe_2h",
		],
	],
};
::B.Info[::Const.EntityType.OrcWarlord].Builds["Axe2"] <- ::B.Info[::Const.EntityType.OrcWarlord].Builds["Axe"];

::B.Info[::Const.EntityType.OrcWarlord].Builds["Cleaver Debuff"] <- {
	Name = "Cleaver Debuff",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_cleaverc"], //4
        ["scripts/skills/perks/perk_legend_lacerate"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_rattle"], //7
        ["scripts/skills/perks/perk_duelist"], //8
        ["scripts/skills/perks/perk_stance_gourmet"], //9
        ["scripts/skills/perks/perk_fresh_and_furious"], //9
    ],
	LevelUps = [
		["Fatigue", 9, 3, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/orc_cleaver",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_orc_cleaver",
		],
	],
};

::B.Info[::Const.EntityType.OrcWarlord].Builds["Chain"] <- {
	Name = "Chain",
	Pattern = [
        ["scripts/skills/perks/perk_lone_wolf"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_strange_strikes"], //3
        ["scripts/skills/perks/perk_mastery_flailc"], //4
        ["scripts/skills/perks/perk_adrenalin"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_underdog"], //7
        ["scripts/skills/perks/perk_survival_instinct"], //8
        ["scripts/skills/perks/perk_stance_prisoner"], //9
        ["scripts/skills/perks/perk_legend_mind_over_body"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/orc_flail_2h",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_orc_flail_2h",
		],
	],
};