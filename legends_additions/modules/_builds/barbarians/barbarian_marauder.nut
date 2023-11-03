//Level 8 Raider template
//barbarian template, 7 perks

::Const.Tactical.Actor.BarbarianMarauder <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 60,
	Stamina = 110,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

"scripts/items/weapons/barbarians/axehammer" //1h hammer
"scripts/items/weapons/barbarians/crude_axe" //1h axe
"scripts/items/weapons/barbarians/blunt_cleaver" //1h cleaver
"scripts/items/weapons/barbarians/skull_hammer" //2h hammer
"scripts/items/weapons/barbarians/two_handed_spiked_mace" //2h hammer

"scripts/items/shields/wooden_shield_old" //

::B.Info[::Const.EntityType.BarbarianMarauder] <- {
    Level = 8,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.BanditLeader].Builds["2H Flail"] <- {
	Name = "2H Flail",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"],
        ["D", 2],
        ["scripts/skills/perks/perk_adrenalin"],
        ["W", 3],
        ["W", 4],
        ["D", 6],
        ["scripts/skills/perks/perk_duelist"],
    ],
	LevelUps = [
		["Initiative", 7, 0, 2],
		["Melee Skill", 7, 0, 2],
		["Melee Defense", 7, 0, 2],
	],
	Loadout = [
		[
			"scripts/items/weapons/two_handed_flail",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_two_handed_flail",
		]
	],
};