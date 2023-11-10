//Bandit Leader
//Level 11 Raider template
//raider template, 10 perks
//has weapon mastery, stance, and destiny
::Const.Tactical.Actor.BanditWarlord <- {
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

::B.Info[::Const.EntityType.BanditWarlord] <- {
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
		["T", 7], //10
    ],
	LevelUps = [
		["Health", 10, 1, 3],
		["Melee Skill", 10, 1, 3],
		["Melee Defense", 10, 1, 3],
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
			"scripts/items/weapons/named/named_greatsword",
		],
		[
			"scripts/items/weapons/named/named_greataxe",
		],
		[
			"scripts/items/weapons/named/legend_named_longsword",
		],
		[
			"scripts/items/weapons/named/named_two_handed_hammer",
		],
	],
	Builds = {},
	BuildsChance = 0
};

///////

// if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
// {
// 	local weapons = [
// 		"scripts/items/weapons/noble_sword",
// 		"scripts/items/weapons/fighting_axe",
// 		"scripts/items/weapons/warhammer",
// 		"scripts/items/weapons/legend_glaive",
// 		"scripts/items/weapons/fighting_spear",
// 		"scripts/items/weapons/winged_mace",
// 		"scripts/items/weapons/arming_sword",
// 		"scripts/items/weapons/military_cleaver"
// 	];
// 	// "shields/heater_shield",
// 	// "shields/kite_shield"
// }

// shields.extend([
// 	"shields/named/named_bandit_kite_shield",
// 	"shields/named/named_bandit_heater_shield"
// ]);