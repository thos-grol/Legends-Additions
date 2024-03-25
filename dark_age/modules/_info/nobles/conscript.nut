::Const.Tactical.Actor.Conscript <- {
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

::B.Info[::Const.EntityType.Conscript] <- {
    Level = 7,
    Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["W", 3],
        ["W", 4],
        ["scripts/skills/perks/perk_legend_back_to_basics"], //4 - 0
        ["scripts/skills/perks/perk_adrenalin"], //4 - 2
        ["D", 6],
    ],
	LevelUps = [
		["Initiative", 6, 3, 3],
		["Ranged Defense", 6, 2, 3],
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
        ["D", 6],
    ],
	LevelUps = [
		["Health", 6, 2, 3],
		["Ranged Defense", 6, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/firelance",
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
		["scripts/skills/perks/perk_legend_twirl"], //5
        ["D", 6],
    ],
	LevelUps = [
		["Initiative", 6, 3, 3],
		["Ranged Defense", 6, 2, 3],
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
