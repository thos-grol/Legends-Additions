::B.Info[::Const.EntityType.Necromancer] <- {
    Level = 10,
	Builds = {},
	BuildsChance = 100
};

//TODO: NECROMANCER finish necromancer builds
//TODO: NECROMANCER edit stats here

::B.Info[::Const.EntityType.Necromancer].Builds["tome_flesh"] <- {
	Name = "Flesh Puppeteer",
	Drop = "tome_flesh",
	Pattern = [
        ["scripts/skills/perks/perk_student"], //1
        ["D", 2], //2
        ["scripts/skills/perks/pattern_recognition"], //3
        ["scripts/skills/perks/"], //4
        ["scripts/skills/perks/"], //5 //TODO: flesh servant for npcs, generate 4 templates
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