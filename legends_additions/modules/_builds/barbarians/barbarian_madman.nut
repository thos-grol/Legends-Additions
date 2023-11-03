//Lvl 11 Raider template
::Const.Tactical.Actor.BarbarianMadman <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 150,
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

::B.Info[::Const.EntityType.BarbarianMadman] <- {
    Level = 11,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.BarbarianMadman].Builds["Cleaver"] <- {
	Name = "Cleaver",
	Pattern = [
        ["scripts/skills/perks/perk_legend_alert"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_adrenalin"], //3
        ["scripts/skills/perks/perk_mastery_cleaverc"], //4
        ["scripts/skills/perks/perk_fitness"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_steadfast"], //7
        ["scripts/skills/perks/perk_dismemberment"], //8
        ["scripts/skills/perks/perk_stance_gourmet"], //9
		["scripts/skills/perks/perk_fresh_and_furious"], //10
    ],
	LevelUps = [
		["Initiative", 10, 3, 3],
		["Melee Skill", 10, 3, 3],
		["Melee Defense", 10, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/named/named_rusty_warblade",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/named/named_rusty_warblade",
		],
	],
};