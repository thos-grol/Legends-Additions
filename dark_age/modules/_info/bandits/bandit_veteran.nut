//Bandit Leader
//Level 9 Raider template
//raider template, 8 perks
//has weapon mastery and stance
::Const.Tactical.Actor.BanditVeteran <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 47,
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

::B.Info[::Const.EntityType.BanditVeteran] <- {
    Level = 9,
    Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 3], //5
        ["D", 6], //6
        ["T", 5], //7
        ["T", 5], //8
    ],
	LevelUps = [
		["Health", 8, 1, 3],
		["Melee Skill", 8, 1, 3],
		["Melee Defense", 8, 1, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/legend_infantry_axe"
        ],
        [
        	"scripts/items/weapons/hooked_blade"
        ],
        [
        	"scripts/items/weapons/pike"
        ],
        [
        	"scripts/items/weapons/longaxe"
        ],
        [
        	"scripts/items/weapons/two_handed_wooden_hammer"
        ],
        [
        	"scripts/items/weapons/two_handed_mace"
        ],
        [
        	"scripts/items/weapons/legend_two_handed_club"
        ]
	],
	Builds = {},
	BuildsChance = 50
};

///////
::B.Info[::Const.EntityType.BanditVeteran].Builds["1H Shield"] <- {
	Name = "1H Shield",
	Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4], //4
        ["scripts/skills/perks/perk_shield_expert"],
        ["D", 6], //6
        ["T", 3], //7
        ["T", 5], //8
    ],
	LevelUps = [
		["Health", 8, 1, 3],
		["Melee Skill", 8, 1, 3],
		["Melee Defense", 8, 1, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe",
			"scripts/items/shields/kite_shield"
		],
		[
			"scripts/items/weapons/morning_star",
			"scripts/items/shields/kite_shield"
		],
	]
};

::B.Info[::Const.EntityType.BanditVeteran].Builds["1H Duelist"] <- {
	Name = "1H Duelist",
	Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 1], //5
        ["D", 6], //6
        ["T", 3], //7
        ["scripts/skills/perks/perk_duelist"], //8
    ],
	LevelUps = [
		["Health", 8, 1, 3],
		["Melee Skill", 8, 2, 3],
		["Melee Defense", 8, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/fighting_axe"
		],
		[
			"scripts/items/weapons/boar_spear"
		],
		[
			"scripts/items/weapons/morning_star"
		],
		[
			"scripts/items/weapons/military_cleaver"
		],
	],
};

::B.Info[::Const.EntityType.BanditVeteran].Builds["1H Net"] <- {
	Name = "1H Net",
	Pattern = [
        ["T", 1], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_legend_net_repair"],
        ["W", 4], //4
        ["scripts/skills/perks/perk_legend_net_casting"],
        ["D", 6], //6
        ["T", 3], //7
        ["T", 5], //8
    ],
	LevelUps = [
		["Health", 8, 1, 3],
		["Melee Skill", 8, 1, 3],
		["Melee Defense", 8, 1, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/hand_axe"
		],
		[
			"scripts/items/weapons/boar_spear"
		],
		[
			"scripts/items/weapons/morning_star"
		],
	],
};

::B.Info[::Const.EntityType.BanditVeteran].Builds["Longsword"] <- {
	Name = "Longsword",
	Pattern = [
        ["scripts/skills/perks/perk_legend_recuperation"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_steadfast"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_hold_out"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_nine_lives"], //7
        ["scripts/skills/perks/perk_reach_advantage"], //8
    ],
	LevelUps = [
		["Health", 8, 3, 3],
		["Melee Skill", 8, 2, 3],
		["Melee Defense", 8, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_longsword",
		],
	]
};