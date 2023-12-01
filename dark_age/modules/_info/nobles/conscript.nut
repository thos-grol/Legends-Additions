::Const.Tactical.Actor.Conscript <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::B.Info[::Const.EntityType.Conscript] <- {
    Level = 9,
    Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_steadfast"], //4 - 1
        ["scripts/skills/perks/perk_adrenalin"], //4 - 2
        ["D", 6],
		["scripts/skills/perks/perk_duelist"], //5
    ],
	LevelUps = [
		["Initiative", 8, 3, 3],
		["Melee Skill", 8, 2, 3],
		["Melee Defense", 8, 2, 3],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/oriental/firelance"
        ]
	],
	Builds = {},
	BuildsChance = 50
};

///////
::B.Info[::Const.EntityType.Conscript].Builds["Cockroach"] <- {
	Name = "Cockroach",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"], //1
        ["scripts/skills/perks/perk_underdog"], //1
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_nine_lives"], //4 - 1
        ["scripts/skills/perks/perk_shield_expert"], //4 - 2
		["scripts/skills/perks/perk_survival_instinct"], //5
        ["D", 6],
    ],
	LevelUps = [
		["Health", 8, 2, 3],
		["Melee Skill", 8, 2, 3],
		["Melee Defense", 8, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/firelance",
			"scripts/items/shields/oriental/southern_light_shield"
		]
	]
};

::B.Info[::Const.EntityType.Conscript].Builds["Polearm"] <- {
	Name = "Polearm",
	Pattern = [
		["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_agile"], //4 - 1
        ["scripts/skills/perks/perk_adrenalin"], //4 - 2
        ["D", 6],
		["scripts/skills/perks/perk_legend_twirl"], //5
    ],
	LevelUps = [
		["Initiative", 8, 3, 3],
		["Melee Skill", 8, 2, 3],
		["Melee Defense", 8, 2, 3],
	],
	Loadout = [
		[
        	"scripts/items/weapons/oriental/polemace"
        ],
		[
        	"scripts/items/weapons/oriental/swordlance"
        ],
	]
};
