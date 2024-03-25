//Lvl 10 Raider template
::Const.Tactical.Actor.Executioner <- {
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

::B.Info[::Const.EntityType.Executioner] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.Executioner].Builds["Seismic Decap"] <- {
	Name = "Seismic Decap",
	Pattern = [
        ["scripts/skills/perks/perk_colossus"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_hammerc"], //4
        ["scripts/skills/perks/perk_sundering_strikes"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_dismemberment"], //7
        ["scripts/skills/perks/perk_rattle"], //8
        ["scripts/skills/perks/perk_stance_seismic_slam"], //9
    ],
	LevelUps = [
		["Initiative", 9, 3, 3],
		["Ranged Skill", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/oriental/two_handed_scimitar",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_two_handed_scimitar",
		],
	],
};

::B.Info[::Const.EntityType.Executioner].Builds["Bardiche Damage"] <- {
	Name = "Bardiche Damage",
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
		["Initiative", 9, 3, 3],
		["Ranged Skill", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/bardiche",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_bardiche",
		],
	],
};

