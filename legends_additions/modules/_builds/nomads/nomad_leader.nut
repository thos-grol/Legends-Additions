//Lvl 10 Raider Template
//Has stance, 9 perks
::Const.Tactical.Actor.NomadLeader <- {
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

::B.Info[::Const.EntityType.NomadLeader] <- {
    Level = 10,
    Pattern = [
        ["scripts/skills/perks/perk_lead_by_example"], //1 LeadByExample
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 1], //5
        ["D", 6], //6
        ["scripts/skills/perks/perk_trial_by_fire"], //7 TrialByFire
        ["T", 5], //8
        ["W", 7], //9
    ],
	LevelUps = [
		["Health", 9, 1, 3],
		["Melee Skill", 9, 1, 3],
		["Melee Defense", 9, 1, 3],
	],
    Trait = [],
	Loadout = [
		[
			"scripts/items/weapons/greatsword",
		],
		[
			"scripts/items/weapons/greataxe",
		],
		[
			"scripts/items/weapons/legend_longsword",
		],
		[
			"scripts/items/weapons/two_handed_hammer",
		],
	],
	NamedLoadout = [
		[
			"weapons/named/named_greatsword",
		],
		[
			"weapons/named/named_greataxe",
		],
		[
			"weapons/named/legend_named_longsword",
		],
		[
			"weapons/named/named_two_handed_hammer",
		],
	],
	Builds = {},
	BuildsChance = 100
};

"weapons/shamshir",
"weapons/oriental/heavy_southern_mace",
"weapons/fighting_spear"
"weapons/oriental/two_handed_scimitar"

"shields/oriental/metal_round_shield"


// "weapons/named/named_shamshir"
// "weapons/named/named_qatal_dagger"
// "weapons/named/named_swordlance"
// "weapons/named/named_polemace"
// "weapons/named/named_two_handed_scimitar"
// "weapons/named/named_spear"

// "shields/named/named_sipar_shield"

