//Lvl 10 Merc template
::Const.Tactical.Actor.Greatsword <- {
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

::B.Info[::Const.EntityType.Greatsword] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::B.Info[::Const.EntityType.Greatsword].Builds["Sword"] <- {
	Name = "Sword",
	Pattern = [
        ["scripts/skills/perks/perk_underdog"], //1
        ["D", 2], //2
        ["scripts/skills/perks/perk_lone_wolf"], //3
        ["scripts/skills/perks/perk_mastery_swordc"], //4
        ["scripts/skills/perks/perk_survival_instinct"], //5
        ["D", 6],
        ["scripts/skills/perks/perk_strange_strikes"], //7
        ["scripts/skills/perks/perk_rattle"], //8
        ["scripts/skills/perks/perk_stance_the_strongest"], //9
    ],
	LevelUps = [
		["Health", 9, 2, 3],
		["Ranged Defense", 9, 2, 3],
	],
	Loadout = [
		[
			"scripts/items/weapons/greatsword",
		],
	],
	NamedLoadout = [
		[
			"scripts/items/weapons/greatsword",
		],
	],
};