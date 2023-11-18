::B.Info[::Const.EntityType.Necromancer] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

::Const.Tactical.Actor.Necromancer <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 35,
	Stamina = 95,
	MeleeSkill = 56,
	RangedSkill = 40,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

//TODO: NECROMANCER finish necromancer builds

::B.Info[::Const.EntityType.Necromancer].Builds["tome_flesh"] <- {
	Name = "Flesh Puppeteer",
	Drop = "tome_flesh",
	Pattern = [
        ["scripts/skills/perks/perk_student"], //1
        ["D", 2], //2
        ["scripts/skills/perks/pattern_recognition"], //3
        ["scripts/skills/perks/"], //4
        ["scripts/skills/perks/"], //5
        ["D", 6],
        ["scripts/skills/perks/"], //7
        ["scripts/skills/perks/"], //7
        ["scripts/skills/perks/perk_spell_reanimate"], //9
		["scripts/skills/perks/perk_spell_flesh_servant"], //10 bc student
		["scripts/skills/perks/perk_meditation_underworld_thoughts"], //11 bc meditation is free
    ],
	LevelUps = [
		["Health", 9, 3, 3],
		["Ranged Skill", 9, 3, 3],
		["Melee Defense", 9, 3, 3],
	],
	Loadout = [
		[],
	],
	NamedLoadout = [
		[],
	],
};