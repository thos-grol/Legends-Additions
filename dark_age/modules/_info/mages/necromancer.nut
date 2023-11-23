::B.Info[::Const.EntityType.Necromancer] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::Const.Tactical.Actor.Necromancer <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 35,
	Stamina = 95,
	MeleeSkill = 56,
	RangedSkill = 40,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

// ::B.Info[::Const.EntityType.Necromancer].Builds["vanilla_decay"] <- {
// 	Name = "Flesh ",
// 	Drop = "tome_flesh",
// 	Pattern = [
//         ["scripts/skills/perks/perk_student"], //1
//         ["D", 2], //2
//         ["scripts/skills/perks/perk_pattern_recognition"], //3
//         ["scripts/skills/perks/perk_spell_mark_of_decay"], //4
//         ["scripts/skills/perks/perk_spell_reanimate"], //5
//         ["D", 6], //6
//         ["scripts/skills/perks/perk_research_rotten_offering"], //7
//         ["scripts/skills/perks/perk_research_miasma_body"], //8
//         ["T", 5], //9
// 		["T", 5], //10 bc student
// 		["scripts/skills/perks/perk_meditation_omen_of_decay"], //11 bc meditation is free
//     ],
// 	LevelUps = [
// 		["Health", 9, 0, 3],
// 		["Initiative", 9, 0, 3],
// 		["Melee Defense", 9, 0, 3],
// 	],
// 	Loadout = [
// 		[],
// 	],
// 	NamedLoadout = [
// 		[],
// 	],
// };

// ::B.Info[::Const.EntityType.Necromancer].Builds["vanilla_flesh"] <- {
// 	Name = "Flesh ",
// 	Drop = "tome_flesh",
// 	Pattern = [
//         ["scripts/skills/perks/perk_student"], //1
//         ["D", 2], //2
//         ["scripts/skills/perks/perk_pattern_recognition"], //3
//         ["scripts/skills/perks/perk_spell_flesh_servant"], //4
//         ["T", 3], //5
//         ["D", 6], //6
//         ["scripts/skills/perks/perk_spell_reanimate"], //7
//         ["scripts/skills/perks/perk_research_flesh_overclocking"], //8
//         ["T", 5], //9
// 		["T", 5], //10 bc student
// 		["scripts/skills/perks/perk_meditation_pact_of_flesh"], //11 bc meditation is free
//     ],
// 	LevelUps = [
// 		["Health", 9, 0, 3],
// 		["Initiative", 9, 0, 3],
// 		["Melee Defense", 9, 0, 3],
// 	],
// 	Loadout = [
// 		[],
// 	],
// 	NamedLoadout = [
// 		[],
// 	],
// };

// ::B.Info[::Const.EntityType.Necromancer].Builds["hybrid_flesh"] <- {
// 	Name = "Flesh Warrior",
// 	Drop = "tome_flesh",
// 	Pattern = [
//         ["scripts/skills/perks/perk_meditation_pact_of_flesh"], //meditation is free
// 		["scripts/skills/perks/perk_legend_recuperation"], //1
//         ["D", 2], //2
//         ["scripts/skills/perks/perk_steadfast"], //3
//         ["scripts/skills/perks/perk_mastery_swordc"], //4
//         ["scripts/skills/perks/perk_research_flesh_overclocking"], //5
//         ["D", 6], //6
//         ["scripts/skills/perks/perk_stance_the_strongest"], //7
//         ["scripts/skills/perks/perk_nine_lives"], //8 +2 perks
//         ["scripts/skills/perks/perk_legend_back_to_basics"], //9
// 		["scripts/skills/perks/perk_spell_flesh_servant"], //9 (Back to basics)
// 		["scripts/skills/perks/perk_spell_reanimate"], //9 (Back to basics)
//     ],
// 	LevelUps = [
// 		["Melee Attack", 9, 2, 3],
// 		["Initiative", 9, 2, 3],
// 		["Melee Defense", 9, 2, 3],
// 	],
// 	Loadout = [
// 		[
// 			"scripts/items/weapons/legend_longsword",
// 		],
// 	],
// 	NamedLoadout = [
// 		[
// 			"scripts/items/weapons/named/legend_named_longsword",
// 		],
// 	],
// };


//TODO: NECROMANCER TEST corpse explosion
::B.Info[::Const.EntityType.Necromancer].Builds["vanilla_explosion"] <- {
	Name = "Flesh ",
	Drop = "tome_flesh",
	Pattern = [
        ["scripts/skills/perks/perk_student"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_pattern_recognition"], //3
        ["scripts/skills/perks/perk_spell_flesh_servant"], //4
        ["T", 3], //5
        ["D", 6], //6
        ["scripts/skills/perks/perk_spell_reanimate"], //7
        ["scripts/skills/perks/perk_research_flesh_overclocking"], //8
        ["T", 5], //9
		["T", 5], //10 bc student
		["scripts/skills/perks/perk_meditation_pact_of_flesh"], //11 bc meditation is free
    ],
	LevelUps = [
		["Health", 9, 0, 3],
		["Initiative", 9, 0, 3],
		["Melee Defense", 9, 0, 3],
	],
	Loadout = [
		[],
	],
	NamedLoadout = [
		[],
	],
};


