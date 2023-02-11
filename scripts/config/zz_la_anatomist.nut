//Add anatomist and thug
::Const.EntityType.Anatomist <- 166;
::Const.Strings.EntityName.append("Anatomist");
::Const.EntityIcon.append("background_70");

::Const.World.Spawn.Troops.Anatomist <- {
	ID = ::Const.EntityType.Anatomist,
	Variant = 1,
	Strength = 25,
	Cost = 20,
	Row = 3,
	Script = "scripts/entity/tactical/enemies/anatomist",
	NameList = ::Const.Strings.NecromancerNames,
	TitleList = null
};

::Const.World.Spawn.Troops.BanditThugPotioned <- {
	ID = ::Const.EntityType.BanditThug,
	Variant = 0,
	Strength = 16,
	Cost = 11,
	Row = 3,
	Script = "scripts/entity/tactical/enemies/bandit_thug_potioned"
};