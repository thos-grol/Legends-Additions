::Const.Tactical.Actor.OrcWarrior <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 200,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 50,
	RangedSkill = 30,
	MeleeDefense = -10,
	RangedDefense = 0,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.0
};

::B.Info[::Const.EntityType.OrcWarrior] <- {
    Level = 8,
    Pattern = [
        ["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["T", 5],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Ranged Skill", 7, 0, 2],
	],
    Trait = [],
	Loadout = [
        [
        	"scripts/items/weapons/greenskins/legend_skin_flayer"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_skullbreaker"
        ]
	],
	NamedLoadout = [
		[
        	"scripts/items/weapons/greenskins/legend_skin_flayer"
        ],
        [
        	"scripts/items/weapons/greenskins/legend_skullbreaker"
        ]
	],
	Builds = {},
	BuildsChance = 50
};

::B.Info[::Const.EntityType.OrcWarrior].Builds["1H Axe Shield"] <- {
	Name = "1H Axe Shield",
	Pattern = [
        ["scripts/skills/perks/perk_rotation"],
        ["W", 3],
        ["scripts/skills/perks/perk_shield_bash"],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["scripts/skills/perks/perk_shield_expert"],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Ranged Skill", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/orc_axe",
			"scripts/items/shields/greenskins/orc_heavy_shield"
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_orc_axe",
			"scripts/items/weapons/named/named_orc_heavy_shield",
		],
	],
};

::B.Info[::Const.EntityType.OrcWarrior].Builds["1H Duelist"] <- {
	Name = "1H Duelist",
	Pattern = [
		["T", 1],
        ["D", 2],
        ["W", 3],
        ["W", 4],
        ["T", 5],
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"],
    ],
	LevelUps = [
		["Health", 7, 0, 2],
		["Ranged Skill", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/greenskins/orc_cleaver"
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_orc_cleaver",
		],
	],
};