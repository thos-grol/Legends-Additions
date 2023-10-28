//Bandit Leader
//Level 10 Raider template
//raider template, 9 perks
//has weapon mastery and stance
::Const.Tactical.Actor.BanditLeader <- {
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

::B.Info[::Const.EntityType.BanditLeader] <- {
    Level = 10,
    Pattern = [
        ["Z", "scripts/skills/perks/perk_lead_by_example"], //1 LeadByExample
        ["D", 2], //2
        ["W", 3], //3
        ["W", 4], //4
        ["T", 1], //5
        ["D", 6], //6
        ["Z", "scripts/skills/perks/perk_trial_by_fire"], //7 TrialByFire
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
	BuildsChance = 50
};

///////

// if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
// {
// 	local weapons = [
// 		"weapons/noble_sword",
// 		"weapons/fighting_axe",
// 		"weapons/warhammer",
// 		"weapons/legend_glaive",
// 		"weapons/fighting_spear",
// 		"weapons/winged_mace",
// 		"weapons/arming_sword",
// 		"weapons/military_cleaver"
// 	];
// 	// "shields/heater_shield",
// 	// "shields/kite_shield"
// }

// shields.extend([
// 	"shields/named/named_bandit_kite_shield",
// 	"shields/named/named_bandit_heater_shield"
// ]);

::B.Info[::Const.EntityType.BanditLeader].Builds["Swordstaff"] <- {
	Name = "Swordstaff",
	Pattern = [
        ["Z", "scripts/skills/perks/perk_legend_recuperation"], //1 LeadByExample
        ["D", 2], //2
        ["W", "scripts/skills/perks/perk_pokepoke"], //3
        ["Z", "scripts/skills/perks/perk_mastery_spearc"], //4
        ["T", "scripts/skills/perks/perk_steadfast"], //5
        ["D", 6],
        ["Z", "scripts/skills/perks/perk_mastery_sword"], //7 TrialByFire
        ["T", "scripts/skills/perks/perk_battle_flow"], //8
        ["Z", "scripts/skills/perks/perk_stance_breakthrough"], //9
    ],
	LevelUps = [
		["Health", 9, 1, 3],
		["Melee Skill", 9, 2, 3],
		["Melee Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/legend_swordstaff",
		],
	],
	NamedLoadout = [
		[
			"weapons/named/legend_named_swordstaff",
		]
	],
};