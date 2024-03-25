//raider template, 9 perks
//has weapon mastery and stance
::Const.Tactical.Actor.MilitiaCaptain <- {
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

::B.Info[::Const.EntityType.MilitiaCaptain] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

///////

::B.Info[::Const.EntityType.MilitiaCaptain].Builds["Commander"] <- {
	Name = "Commander",
	Pattern = [
        ["scripts/skills/perks/perk_lead_by_example"], //1
        ["D", 2],
        ["scripts/skills/perks/perk_fearsome"], //3
        ["scripts/skills/perks/perk_mastery_polearmc"], //4
        ["scripts/skills/perks/perk_fortified_mind"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_trial_by_fire"], //7
        ["scripts/skills/perks/perk_intimidate"], //8
        ["scripts/skills/perks/perk_stance_followup"], //9
    ],
	LevelUps = [
		["Resolve", 7, 3, 3],
		["Health", 2, 3, 3],
		["Ranged Defense", 9, 3, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/pike",
		]
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/pike",
		]
	],
};