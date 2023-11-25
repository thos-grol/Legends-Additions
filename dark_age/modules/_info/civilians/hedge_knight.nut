//Lvl 10 Raider template
::Const.Tactical.Actor.HedgeKnight <- {
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

::B.Info[::Const.EntityType.HedgeKnight] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.HedgeKnight].Builds["Seismic"] <- {
	Name = "Seismic",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_hammerc"], //4
        ["scripts/skills/perks/perk_sundering_strikes"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_death_dealer"], //7
        ["scripts/skills/perks/perk_rattle"], //8
        ["scripts/skills/perks/perk_stance_seismic_slam"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/two_handed_hammer",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_two_handed_hammer",
		],
	],
};

::B.Info[::Const.EntityType.HedgeKnight].Builds["Axe Damage"] <- {
	Name = "Axe Damage",
	Pattern = [
		["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_sundering_strikes"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_death_dealer"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_dismemberment"], //7
        ["scripts/skills/perks/perk_berserk"], //8
        ["scripts/skills/perks/perk_stance_executioner"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greataxe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_greataxe",
		],
	],
};

::B.Info[::Const.EntityType.HedgeKnight].Builds["Axe Roundswing"] <- {
	Name = "Axe Roundswing",
	Pattern = [
		["scripts/skills/perks/perk_underdog"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_sundering_strikes"], //3
        ["scripts/skills/perks/perk_mastery_axec"], //4
        ["scripts/skills/perks/perk_death_dealer"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_lone_wolf"], //7
        ["scripts/skills/perks/perk_mastery_swordc"], //8
        ["scripts/skills/perks/perk_stance_wrath"], //9
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Melee Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greataxe",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_greataxe",
		],
	],
};

