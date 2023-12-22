local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.Unit <- {
	ID = 0,
	Variant = 0,
	Strength = 0.0,
	Row = 0,
	Party = null,
	Faction = null,
	Tag = null,
	Script = "",
	Name = ""
};

gt.Const.World.Spawn.Troops <- {
	Necromancer = {
		ID = ::Const.EntityType.Necromancer,
		Variant = 1,
		Strength = 35,
		Cost = 30,
		Row = 3,
		Script = "scripts/entity/tactical/enemies/necromancer",
		NameList = ::Const.Strings.NecromancerNames,
		TitleList = null
	},
	Zombie = {
		ID = ::Const.EntityType.Zombie,
		Variant = 0,
		Strength = 5,
		Cost = 5,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie"
	},
	ZombieYeoman = {
		ID = ::Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 10,
		Cost = 12,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_yeoman"
	},
	ZombieNomad = {
		ID = ::Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 10,
		Cost = 12,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_nomad"
	},
	ZombieNomadBodyguard = {
		ID = ::Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 6,
		Cost = 6,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_nomad_bodyguard"
	},
	ZombieKnight = {
		ID = ::Const.EntityType.ZombieKnight,
		Variant = 1,
		Strength = 20,
		Cost = 24,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_knight",
		NameList = ::Const.Strings.KnightNames,
		TitleList = ::Const.Strings.FallenHeroTitles
	},
	ZombieBodyguard = {
		ID = ::Const.EntityType.Zombie,
		Variant = 0,
		Strength = 6,
		Cost = 6,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_bodyguard"
	},
	ZombieYeomanBodyguard = {
		ID = ::Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_yeoman_bodyguard"
	},
	ZombieKnightBodyguard = {
		ID = ::Const.EntityType.ZombieKnight,
		Variant = 0,
		Strength = 20,
		Cost = 24,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_knight_bodyguard"
	},
	ZombieBetrayer = {
		ID = ::Const.EntityType.ZombieBetrayer,
		Variant = 0,
		Strength = 25,
		Cost = 30,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_betrayer"
	},
	ZombieBoss = {
		ID = ::Const.EntityType.ZombieBoss,
		Variant = 0,
		Strength = 80,
		Cost = 80,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_boss"
	},
	Ghost = {
		ID = ::Const.EntityType.Ghost,
		Variant = 0,
		Strength = 25,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/ghost"
	},
	SkeletonLight = {
		ID = ::Const.EntityType.SkeletonLight,
		Variant = 0,
		Strength = 14,
		Cost = 13,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_light"
	},
	SkeletonMedium = {
		ID = ::Const.EntityType.SkeletonMedium,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_medium"
	},
	SkeletonMediumPolearm = {
		ID = ::Const.EntityType.SkeletonMedium,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/skeleton_medium_polearm"
	},
	SkeletonHeavy = {
		ID = ::Const.EntityType.SkeletonHeavy,
		Variant = 1,
		Strength = 30,
		Cost = 35,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_heavy",
		NameList = ::Const.Strings.AncientDeadNames,
		TitleList = null
	},
	SkeletonHeavyPolearm = {
		ID = ::Const.EntityType.SkeletonHeavy,
		Variant = 0,
		Strength = 30,
		Cost = 35,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/skeleton_heavy_polearm"
	},
	SkeletonHeavyBodyguard = {
		ID = ::Const.EntityType.SkeletonHeavy,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/skeleton_heavy_bodyguard"
	},
	SkeletonPriest = {
		ID = ::Const.EntityType.SkeletonPriest,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/skeleton_priest"
	},
	SkeletonBoss = {
		ID = ::Const.EntityType.SkeletonBoss,
		Variant = 0,
		Strength = 80,
		Cost = 80,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/skeleton_boss"
	},
	Vampire = {
		ID = ::Const.EntityType.Vampire,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/vampire"
	},
	VampireLOW = {
		ID = ::Const.EntityType.Vampire,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/vampire_low"
	},
	OrcYoung = {
		ID = ::Const.EntityType.OrcYoung,
		Variant = 0,
		Strength = 16,
		Cost = 16,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/orc_young"
	},
	OrcYoungLOW = {
		ID = ::Const.EntityType.OrcYoung,
		Variant = 0,
		Strength = 14,
		Cost = 13,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/orc_young"
	},
	OrcBerserker = {
		ID = ::Const.EntityType.OrcBerserker,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/orc_berserker"
	},
	LegendOrcElite = {
		ID = ::Const.EntityType.LegendOrcElite,
		Variant = 1,
		Strength = 80,
		Cost = 80,
		Row = 1,
		NameList = ::Const.Strings.OrcWarlordNames,
		TitleList = ::Const.Strings.GoblinTitles,
		Script = "scripts/entity/tactical/enemies/legend_orc_elite"
	},
	LegendOrcBehemoth = {
		ID = ::Const.EntityType.LegendOrcBehemoth,
		Variant = 1,
		Strength = 70,
		Cost = 70,
		Row = 1,
		NameList = ::Const.Strings.OrcWarlordNames,
		TitleList = ::Const.Strings.GoblinTitles,
		Script = "scripts/entity/tactical/enemies/legend_orc_behemoth"
	},
	OrcWarrior = {
		ID = ::Const.EntityType.OrcWarrior,
		Variant = 1,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/orc_warrior",
		NameList = ::Const.Strings.OrcWarlordNames,
		TitleList = ::Const.Strings.GoblinTitles
	},
	OrcWarriorLOW = {
		ID = ::Const.EntityType.OrcWarrior,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/orc_warrior_low"
	},
	OrcWarlord = {
		ID = ::Const.EntityType.OrcWarlord,
		Variant = 10,
		Strength = 45,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/orc_warlord",
		NameList = ::Const.Strings.OrcWarlordNames,
		TitleList = ::Const.Strings.GoblinTitles
	},
	GreenskinCatapult = {
		ID = ::Const.EntityType.GreenskinCatapult,
		Variant = 0,
		Strength = 50,
		Cost = 25,
		Row = 2,
		Script = "scripts/entity/tactical/objective/greenskin_catapult"
	},
	GoblinSkirmisher = {
		ID = ::Const.EntityType.GoblinFighter,
		Variant = 1,
		Strength = 18,
		Cost = 15,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/goblin_fighter",
		NameList = ::Const.Strings.GoblinNames,
		TitleList = ::Const.Strings.GoblinTitles
	},
	GoblinSkirmisherLOW = {
		ID = ::Const.EntityType.GoblinFighter,
		Variant = 0,
		Strength = 14,
		Cost = 10,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/goblin_fighter_low"
	},
	GoblinAmbusher = {
		ID = ::Const.EntityType.GoblinAmbusher,
		Variant = 1,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/goblin_ambusher",
		NameList = ::Const.Strings.GoblinNames,
		TitleList = ::Const.Strings.GoblinTitles
	},
	GoblinAmbusherLOW = {
		ID = ::Const.EntityType.GoblinAmbusher,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/goblin_ambusher_low"
	},
	GoblinShaman = {
		ID = ::Const.EntityType.GoblinShaman,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/goblin_shaman"
	},
	GoblinOverseer = {
		ID = ::Const.EntityType.GoblinLeader,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/goblin_leader"
	},
	GoblinWolfrider = {
		ID = ::Const.EntityType.GoblinWolfrider,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/goblin_wolfrider"
	},
	Wolf = {
		ID = ::Const.EntityType.Wolf,
		Variant = 0,
		Strength = 15,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/wolf"
	},
	Direwolf = {
		ID = ::Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 15,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/direwolf"
	},
	DirewolfHIGH = {
		ID = ::Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/direwolf_high"
	},
	DirewolfBodyguard = {
		ID = ::Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/direwolf_bodyguard"
	},
	GhoulLOW = {
		ID = ::Const.EntityType.Ghoul,
		Variant = 0,
		Strength = 10,
		Cost = 9,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/ghoul"
	},
	Ghoul = {
		ID = ::Const.EntityType.Ghoul,
		Variant = 0,
		Strength = 15,
		Cost = 19,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/ghoul_medium"
	},
	GhoulHIGH = {
		ID = ::Const.EntityType.Ghoul,
		Variant = 0,
		Strength = 25,
		Cost = 30,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/ghoul_high"
	},
	Lindwurm = {
		ID = ::Const.EntityType.Lindwurm,
		Variant = 0,
		Strength = 100,
		Cost = 90,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/lindwurm"
	},
	LegendBear = {
		ID = ::Const.EntityType.LegendBear,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/legend_bear"
	},
	Unhold = {
		ID = ::Const.EntityType.Unhold,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/unhold"
	},
	UnholdFrost = {
		ID = ::Const.EntityType.UnholdFrost,
		Variant = 0,
		Strength = 60,
		Cost = 60,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/unhold_frost"
	},
	UnholdBog = {
		ID = ::Const.EntityType.UnholdBog,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/unhold_bog"
	},
	Spider = {
		ID = ::Const.EntityType.Spider,
		Variant = 0,
		Strength = 13,
		Cost = 12,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/spider"
	},
	SpiderBodyguard = {
		ID = ::Const.EntityType.Spider,
		Variant = 0,
		Strength = 13,
		Cost = 12,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/spider_bodyguard"
	},
	Alp = {
		ID = ::Const.EntityType.Alp,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = -2,
		Script = "scripts/entity/tactical/enemies/alp"
	},
	Hexe = {
		ID = ::Const.EntityType.Hexe,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/hexe"
	},
	Schrat = {
		ID = ::Const.EntityType.Schrat,
		Variant = 1,
		Strength = 70,
		Cost = 70,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/schrat"
	},
	SchratSmall = {
		ID = ::Const.EntityType.SchratSmall,
		Variant = 1,
		Strength = 70,
		Cost = 70,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/schrat"
	},
	LegendGreenwoodSchrat = {
		ID = ::Const.EntityType.LegendGreenwoodSchrat,
		Variant = 0,
		Strength = 280,
		Cost = 210,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/legend_greenwood_schrat"
	},
	LegendGreenwoodSchratSmall = {
		ID = ::Const.EntityType.LegendGreenwoodSchratSmall,
		Variant = 0,
		Strength = 280,
		Cost = 210,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/legend_greenwood_schrat"
	},
	Kraken = {
		ID = ::Const.EntityType.Kraken,
		Variant = 0,
		Strength = 200,
		Cost = 200,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/kraken"
	},
	TricksterGod = {
		ID = ::Const.EntityType.TricksterGod,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/trickster_god"
	},
	Serpent = {
		ID = ::Const.EntityType.Serpent,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/serpent"
	},
	Hyena = {
		ID = ::Const.EntityType.Hyena,
		Variant = 0,
		Strength = 15,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/hyena"
	},
	HyenaHIGH = {
		ID = ::Const.EntityType.Hyena,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/hyena_high"
	},
	SandGolem = {
		ID = ::Const.EntityType.SandGolem,
		Variant = 0,
		Strength = 13,
		Cost = 13,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/sand_golem"
	},
	SandGolemMEDIUM = {
		ID = ::Const.EntityType.SandGolem,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/sand_golem_medium"
	},
	SandGolemHIGH = {
		ID = ::Const.EntityType.SandGolem,
		Variant = 0,
		Strength = 70,
		Cost = 70,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/sand_golem_high"
	},
	Militia = {
		ID = ::Const.EntityType.Militia,
		Variant = 0,
		Strength = 9,
		Cost = 10,
		Row = 0,
		Script = "scripts/entity/tactical/humans/militia"
	},
	MilitiaRanged = {
		ID = ::Const.EntityType.MilitiaRanged,
		Variant = 0,
		Strength = 12,
		Cost = 10,
		Row = 1,
		Script = "scripts/entity/tactical/humans/militia_ranged"
	},
	MilitiaVeteran = {
		ID = ::Const.EntityType.MilitiaVeteran,
		Variant = 0,
		Strength = 14,
		Cost = 12,
		Row = 0,
		Script = "scripts/entity/tactical/humans/militia_veteran"
	},
	MilitiaCaptain = {
		ID = ::Const.EntityType.MilitiaCaptain,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/militia_captain"
	},
	BountyHunter = {
		ID = ::Const.EntityType.BountyHunter,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/bounty_hunter"
	},
	BountyHunterRanged = {
		ID = ::Const.EntityType.BountyHunter,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/humans/bounty_hunter_ranged"
	},
	Peasant = {
		ID = ::Const.EntityType.Peasant,
		Variant = 0,
		Strength = 4,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/peasant"
	},
	SouthernPeasant = {
		ID = ::Const.EntityType.PeasantSouthern,
		Variant = 0,
		Strength = 4,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/peasant_southern"
	},
	PeasantArmed = {
		ID = ::Const.EntityType.Peasant,
		Variant = 0,
		Strength = 5,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/peasant_armed"
	},
	Mercenary = {
		ID = ::Const.EntityType.Mercenary,
		Variant = 0,
		Strength = 30,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/mercenary"
	},
	MercenaryLOW = {
		ID = ::Const.EntityType.Mercenary,
		Variant = 0,
		Strength = 20,
		Cost = 18,
		Row = 0,
		Script = "scripts/entity/tactical/humans/mercenary_low"
	},
	MercenaryRanged = {
		ID = ::Const.EntityType.Mercenary,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/mercenary_ranged"
	},
	Swordmaster = {
		ID = ::Const.EntityType.Swordmaster,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/swordmaster",
		NameList = ::Const.Strings.CharacterNames,
		TitleList = ::Const.Strings.SwordmasterTitles
	},
	HedgeKnight = {
		ID = ::Const.EntityType.HedgeKnight,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/hedge_knight",
		NameList = ::Const.Strings.HedgeKnightTitles,
		TitleList = null
	},
	MasterArcher = {
		ID = ::Const.EntityType.MasterArcher,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/master_archer",
		NameList = ::Const.Strings.MasterArcherNames,
		TitleList = null
	},
	Cultist = {
		ID = ::Const.EntityType.Cultist,
		Variant = 0,
		Strength = 30,
		Cost = 15,
		Row = -1,
		Script = "scripts/entity/tactical/humans/cultist"
	},
	CultistAmbush = {
		ID = ::Const.EntityType.Cultist,
		Variant = 0,
		Strength = 30,
		Cost = 15,
		Row = -2,
		Script = "scripts/entity/tactical/humans/cultist"
	},
	CaravanHand = {
		ID = ::Const.EntityType.CaravanHand,
		Variant = 0,
		Strength = 9,
		Cost = 10,
		Row = 2,
		Script = "scripts/entity/tactical/humans/caravan_hand"
	},
	LegendCaravanPolearm = {
		ID = ::Const.EntityType.LegendCaravanPolearm,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 3,
		Script = "scripts/entity/tactical/humans/legend_caravan_polearm"
	},
	CaravanGuard = {
		ID = ::Const.EntityType.CaravanGuard,
		Variant = 0,
		Strength = 14,
		Cost = 14,
		Row = 2,
		Script = "scripts/entity/tactical/humans/caravan_guard"
	},
	CaravanDonkey = {
		ID = ::Const.EntityType.CaravanDonkey,
		Variant = 0,
		Strength = 10,
		Cost = 0,
		Row = 3,
		Script = "scripts/entity/tactical/objective/donkey"
	},
	ArmoredWardog = {
		ID = ::Const.EntityType.Wardog,
		Variant = 0,
		Strength = 9,
		Cost = 8,
		Row = 0,
		Script = "scripts/entity/tactical/armored_wardog"
	},
	Footman = {
		ID = ::Const.EntityType.Footman,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/humans/noble_footman"
	},
	Greatsword = {
		ID = ::Const.EntityType.Greatsword,
		Variant = 0,
		Strength = 30,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_greatsword"
	},
	Billman = {
		ID = ::Const.EntityType.Billman,
		Variant = 0,
		Strength = 20,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_billman"
	},
	Arbalester = {
		ID = ::Const.EntityType.Arbalester,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_arbalester"
	},
	StandardBearer = {
		ID = ::Const.EntityType.StandardBearer,
		Variant = 0,
		Strength = 25,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/standard_bearer"
	},
	Sergeant = {
		ID = ::Const.EntityType.Sergeant,
		Variant = 0,
		Strength = 30,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/noble_sergeant"
	},
	Knight = {
		ID = ::Const.EntityType.Knight,
		Variant = 2,
		Strength = 40,
		Cost = 35,
		Row = 2,
		Script = "scripts/entity/tactical/humans/knight",
		NameList = ::Const.Strings.KnightNames,
		TitleList = null
	},
	MilitaryDonkey = {
		ID = ::Const.EntityType.MilitaryDonkey,
		Variant = 0,
		Strength = 10,
		Cost = 0,
		Row = 3,
		Script = "scripts/entity/tactical/objective/donkey_military"
	},
	Wardog = {
		ID = ::Const.EntityType.Wardog,
		Variant = 0,
		Strength = 9,
		Cost = 8,
		Row = 0,
		Script = "scripts/entity/tactical/wardog"
	},
	BanditRabble = {
		ID = ::Const.EntityType.BanditRabble,
		Variant = 1,
		DieRoll = 100000,
		Strength = 5,
		Cost = 5,
		Row = 0,
		NameList = ::Const.Strings.BanditRabbleNames,
		TitleList = null,
		Script = "scripts/entity/tactical/enemies/bandit_rabble"
	},
	BanditRabblePoacher = {
		ID = ::Const.EntityType.BanditRabblePoacher,
		Variant = 0,
		Strength = 5,
		Cost = 5,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/bandit_rabble_poacher"
	},
	BanditThug = {
		ID = ::Const.EntityType.BanditThug,
		Variant = 0,
		Strength = 8,
		Cost = 8,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_thug"
	},
	BanditMarksman = {
		ID = ::Const.EntityType.BanditMarksman,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/bandit_marksman"
	},
	BanditMarksmanLOW = {
		ID = ::Const.EntityType.BanditPoacher,
		Variant = 0,
		Strength = 8,
		Cost = 8,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/bandit_poacher"
	},
	BanditRaider = {
		ID = ::Const.EntityType.BanditRaider,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_raider"
	},
	BanditRaiderLOW = {
		ID = ::Const.EntityType.BanditRaider,
		Variant = 0,
		Strength = 15,
		Cost = 16,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_raider_low"
	},
	BanditRaiderWolf = {
		ID = ::Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_raider_wolf"
	},
	BanditVeteran = {
		ID = ::Const.EntityType.BanditVeteran,
		Variant = 0,
		Strength = 30,
		Cost = 35,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/legend_bandit_veteran"
	},
	BanditLeader = {
		ID = ::Const.EntityType.BanditLeader,
		Variant = 1,
		Strength = 30,
		Cost = 25,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/bandit_leader",
		NameList = ::Const.Strings.BanditLeaderNames,
		TitleList = null
	},
	BanditWarlord = {
		ID = ::Const.EntityType.BanditWarlord,
		Variant = 1,
		Strength = 60,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_bandit_warlord",
		NameList = ::Const.Strings.BanditLeaderNames,
		TitleList = null
	},
	BanditOutrider = {
		ID = ::Const.EntityType.BanditOutrider,
		Variant = 0,
		Strength = 40,
		Cost = 45,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/legend_bandit_outrider"
	},
	NomadCutthroat = {
		ID = ::Const.EntityType.NomadCutthroat,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 0,
		Script = "scripts/entity/tactical/humans/nomad_cutthroat"
	},
	NomadArcher = {
		ID = ::Const.EntityType.NomadArcher,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/humans/nomad_archer"
	},
	NomadSlinger = {
		ID = ::Const.EntityType.NomadSlinger,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 1,
		Script = "scripts/entity/tactical/humans/nomad_slinger"
	},
	NomadOutlaw = {
		ID = ::Const.EntityType.NomadOutlaw,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/nomad_outlaw"
	},
	NomadLeader = {
		ID = ::Const.EntityType.NomadLeader,
		Variant = 1,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/humans/nomad_leader",
		NameList = ::Const.Strings.SouthernNames,
		TitleList = ::Const.Strings.NomadChampionTitles
	},
	DesertDevil = {
		ID = ::Const.EntityType.DesertDevil,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/desert_devil",
		NameList = ::Const.Strings.DesertDevilChampionTitles,
		TitleList = null
	},
	Executioner = {
		ID = ::Const.EntityType.Executioner,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/executioner",
		NameList = ::Const.Strings.ExecutionerChampionTitles,
		TitleList = null
	},
	DesertStalker = {
		ID = ::Const.EntityType.DesertStalker,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/desert_stalker",
		NameList = ::Const.Strings.SouthernNames,
		TitleList = ::Const.Strings.DesertStalkerChampionTitles
	},
	Warhound = {
		ID = ::Const.EntityType.Warhound,
		Variant = 0,
		Strength = 10,
		Cost = 10,
		Row = 0,
		Script = "scripts/entity/tactical/warhound"
	},
	BarbarianThrall = {
		ID = ::Const.EntityType.BarbarianThrall,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 0,
		Script = "scripts/entity/tactical/humans/barbarian_thrall"
	},
	BarbarianMarauder = {
		ID = ::Const.EntityType.BarbarianMarauder,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/barbarian_marauder"
	},
	BarbarianChampion = {
		ID = ::Const.EntityType.BarbarianChampion,
		Variant = 1,
		Strength = 35,
		Cost = 35,
		Row = 0,
		Script = "scripts/entity/tactical/humans/barbarian_champion",
		NameList = ::Const.Strings.BarbarianNames,
		TitleList = ::Const.Strings.BarbarianTitles
	},
	BarbarianChosen = {
		ID = ::Const.EntityType.BarbarianChosen,
		Variant = 10,
		Strength = 999,
		Cost = 45,
		Row = 1,
		Script = "scripts/entity/tactical/humans/barbarian_chosen",
		NameList = [
			"The King of the North"
		],
		TitleList = [
			""
		]
	},
	BarbarianDrummer = {
		ID = ::Const.EntityType.BarbarianDrummer,
		Variant = 0,
		Strength = 30,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/barbarian_drummer"
	},
	BarbarianUnhold = {
		ID = ::Const.EntityType.BarbarianUnhold,
		Variant = 0,
		Strength = 50,
		Cost = 55,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/unhold_armored"
	},
	BarbarianUnholdFrost = {
		ID = ::Const.EntityType.BarbarianUnholdFrost,
		Variant = 0,
		Strength = 70,
		Cost = 75,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/unhold_frost_armored"
	},
	BarbarianBeastmaster = {
		ID = ::Const.EntityType.BarbarianBeastmaster,
		Variant = 0,
		Strength = 20,
		Cost = 15,
		Row = 2,
		Script = "scripts/entity/tactical/humans/barbarian_beastmaster"
	},
	Slave = {
		ID = ::Const.EntityType.Slave,
		Variant = 0,
		Strength = 7,
		Cost = 7,
		Row = 0,
		Script = "scripts/entity/tactical/humans/slave"
	},
	NorthernSlave = {
		ID = ::Const.EntityType.Slave,
		Variant = 0,
		Strength = 7,
		Cost = 7,
		Row = 0,
		Script = "scripts/entity/tactical/humans/slave_northern"
	},
	Conscript = {
		ID = ::Const.EntityType.Conscript,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/humans/conscript"
	},
	ConscriptPolearm = {
		ID = ::Const.EntityType.Conscript,
		Variant = 0,
		Strength = 20,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/humans/conscript_polearm"
	},
	Officer = {
		ID = ::Const.EntityType.Officer,
		Variant = 1,
		Strength = 35,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/officer",
		NameList = ::Const.Strings.SouthernNames,
		TitleList = ::Const.Strings.SouthernOfficerTitles
	},
	Gunner = {
		ID = ::Const.EntityType.Gunner,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/humans/gunner"
	},
	Engineer = {
		ID = ::Const.EntityType.Engineer,
		Variant = 0,
		Strength = 10,
		Cost = 10,
		Row = 2,
		Script = "scripts/entity/tactical/humans/engineer"
	},
	Mortar = {
		ID = ::Const.EntityType.Mortar,
		Variant = 0,
		Strength = 30,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/objective/mortar"
	},
	Gladiator = {
		ID = ::Const.EntityType.Gladiator,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/gladiator",
		NameList = ::Const.Strings.SouthernNames,
		TitleList = ::Const.Strings.GladiatorTitles
	},
	Assassin = {
		ID = ::Const.EntityType.Assassin,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = 1,
		Script = "scripts/entity/tactical/humans/assassin"
	},
	SouthernDonkey = {
		ID = ::Const.EntityType.CaravanDonkey,
		Variant = 0,
		Strength = 10,
		Cost = 0,
		Row = 3,
		Script = "scripts/entity/tactical/objective/donkey_southern"
	},
	LegendWhiteDirewolf = {
		ID = ::Const.EntityType.LegendWhiteDirewolf,
		Variant = 0,
		Strength = 300,
		Cost = 75,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_white_direwolf"
	},
	LegendWhiteDirewolfBodyguard = {
		ID = ::Const.EntityType.LegendWhiteDirewolf,
		Variant = 0,
		Strength = 300,
		Cost = 75,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_white_direwolf_bodyguard"
	},
	LegendSkinGhoulLOW = {
		ID = ::Const.EntityType.LegendSkinGhoul,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_skin_ghoul"
	},
	LegendSkinGhoulMED = {
		ID = ::Const.EntityType.LegendSkinGhoul,
		Variant = 0,
		Strength = 75,
		Cost = 100,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_skin_ghoul_med"
	},
	LegendSkinGhoulHIGH = {
		ID = ::Const.EntityType.LegendSkinGhoul,
		Variant = 0,
		Strength = 100,
		Cost = 200,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_skin_ghoul_high"
	},
	LegendStollwurm = {
		ID = ::Const.EntityType.LegendStollwurm,
		Variant = 0,
		Strength = 270,
		Cost = 270,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/legend_stollwurm"
	},
	LegendRockUnhold = {
		ID = ::Const.EntityType.LegendRockUnhold,
		Variant = 0,
		Strength = 180,
		Cost = 180,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/legend_rock_unhold"
	},
	LegendRedbackSpider = {
		ID = ::Const.EntityType.LegendRedbackSpider,
		Variant = 0,
		Strength = 100,
		Cost = 100,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_redback_spider"
	},
	LegendRedbackSpiderBodyguard = {
		ID = ::Const.EntityType.LegendRedbackSpider,
		Variant = 0,
		Strength = 100,
		Cost = 100,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_redback_spider_bodyguard"
	},
	LegendDemonAlp = {
		ID = ::Const.EntityType.LegendDemonAlp,
		Variant = 0,
		Strength = 200,
		Cost = 105,
		Row = -2,
		Script = "scripts/entity/tactical/enemies/legend_demon_alp"
	},
	LegendHexeLeader = {
		ID = ::Const.EntityType.LegendHexeLeader,
		Variant = 0,
		Strength = 200,
		Cost = 200,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_hexe_leader"
	},
	LegendBanshee = {
		ID = ::Const.EntityType.LegendBanshee,
		Variant = 0,
		Strength = 70,
		Cost = 70,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/legend_banshee"
	},
	LegendDemonHound = {
		ID = ::Const.EntityType.LegendDemonHound,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/legend_demon_hound"
	},
	LegendVampireLord = {
		ID = ::Const.EntityType.LegendVampireLord,
		Variant = 1,
		Strength = 60,
		Cost = 60,
		Row = 2,
		NameList = ::Const.Strings.VampireLordNames,
		TitleList = ::Const.Strings.FallenHeroTitles,
		Script = "scripts/entity/tactical/enemies/legend_vampire_lord"
	},
	LegendPeasantButcher = {
		ID = ::Const.EntityType.LegendPeasantButcher,
		Variant = 1,
		DieRoll = 300,
		Strength = 5,
		Cost = 10,
		Row = -1,
		NameList = ::Const.Strings.PeasantButcherNames,
		TitleList = ::Const.Strings.PeasantButcherTitles,
		Script = "scripts/entity/tactical/humans/legend_peasant_butcher"
	},
	LegendPeasantBlacksmith = {
		ID = ::Const.EntityType.LegendPeasantBlacksmith,
		Variant = 0,
		Strength = 10,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_blacksmith"
	},
	LegendPeasantMonk = {
		ID = ::Const.EntityType.LegendPeasantMonk,
		Variant = 0,
		Strength = 10,
		Cost = 15,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_monk"
	},
	LegendPeasantFarmhand = {
		ID = ::Const.EntityType.LegendPeasantFarmhand,
		Variant = 0,
		Strength = 5,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_farmhand"
	},
	LegendPeasantMinstrel = {
		ID = ::Const.EntityType.LegendPeasantMinstrel,
		Variant = 0,
		Strength = 5,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_minstrel"
	},
	LegendPeasantPoacher = {
		ID = ::Const.EntityType.LegendPeasantPoacher,
		Variant = 0,
		Strength = 5,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_poacher"
	},
	LegendPeasantWoodsman = {
		ID = ::Const.EntityType.LegendPeasantWoodsman,
		Variant = 0,
		Strength = 5,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_woodsman"
	},
	LegendPeasantMiner = {
		ID = ::Const.EntityType.LegendPeasantMiner,
		Variant = 0,
		Strength = 5,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_miner"
	},
	LegendPeasantSquire = {
		ID = ::Const.EntityType.LegendPeasantSquire,
		Variant = 0,
		Strength = 10,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_squire"
	},
	LegendPeasantWitchHunter = {
		ID = ::Const.EntityType.LegendPeasantWitchHunter,
		Variant = 0,
		Strength = 15,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/humans/legend_peasant_witchhunter"
	},
	LegendHalberdier = {
		ID = ::Const.EntityType.LegendHalberdier,
		Variant = 0,
		Strength = 60,
		Cost = 60,
		Row = 0,
		Script = "scripts/entity/tactical/humans/legend_noble_halberdier"
	},
	LegendSlinger = {
		ID = ::Const.EntityType.LegendSlinger,
		Variant = 0,
		Strength = 80,
		Cost = 80,
		Row = 0,
		Script = "scripts/entity/tactical/humans/legend_noble_slinger"
	},
	LegendFencer = {
		ID = ::Const.EntityType.LegendFencer,
		Variant = 0,
		Strength = 70,
		Cost = 70,
		Row = 0,
		Script = "scripts/entity/tactical/humans/legend_noble_fencer"
	},
	LegendCatapult = {
		ID = ::Const.EntityType.LegendCatapult,
		Variant = 0,
		Strength = 60,
		Cost = 60,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_catapult"
	},
	LegendHorse = {
		ID = ::Const.EntityType.LegendHorse,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_catapult"
	},
	SkeletonGladiator = {
		ID = ::Const.EntityType.SkeletonGladiator,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_skeleton_gladiator"
	},
	BanditVermes = {
		ID = ::Const.EntityType.BanditVermes,
		Variant = 0,
		Strength = 7,
		Cost = 7,
		Row = 0,
		Script = "scripts/entity/tactical/humans/peasant_armed_infected"
	},
	SatoManhunter = {
		ID = ::Const.EntityType.SatoManhunter,
		Variant = 0,
		Strength = 20,
		Cost = 15,
		Row = 0,
		Script = "scripts/entity/tactical/humans/sato_manhunter"
	},
	SatoManhunterVeteran = {
		ID = ::Const.EntityType.SatoManhunterVeteran,
		Variant = 1,
		Strength = 25,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/humans/sato_manhunter_veteran",
		NameList = ::Const.Strings.SouthernNames,
		TitleList = ::Const.Strings.SatoManhunterVeteranTitles
	},
	KoboldFighter = {
		ID = ::Const.EntityType.KoboldFighter,
		Variant = 0,
		Strength = 5,
		Cost = 5,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/kobold_fighter"
	},
	KoboldWolfrider = {
		ID = ::Const.EntityType.KoboldWolfrider,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/kobold_wolfrider"
	},
	LegendMummyLight = {
		ID = ::Const.EntityType.LegendMummyLight,
		Variant = 0,
		Strength = 21,
		Cost = 21,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/legend_mummy_light"
	},
	LegendMummyMedium = {
		ID = ::Const.EntityType.LegendMummyMedium,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/legend_mummy_medium"
	},
	LegendMummyHeavy = {
		ID = ::Const.EntityType.LegendMummyHeavy,
		Variant = 1,
		Strength = 45,
		Cost = 45,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/legend_mummy_heavy",
		NameList = ::Const.Strings.EmbalmedNobleNames,
		TitleList = null
	},
	LegendMummyQueen = {
		ID = ::Const.EntityType.LegendMummyQueen,
		Variant = 1,
		Strength = 90,
		Cost = 90,
		Row = 2,
		NameList = ::Const.Strings.SouthernFemaleNames,
		TitleList = ::Const.Strings.FallenHeroTitles,
		Script = "scripts/entity/tactical/enemies/legend_mummy_queen"
	},
	SkeletonLich = {
		ID = ::Const.EntityType.SkeletonLich,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_lich"
	},
	SkeletonLichMirrorImage = {
		ID = ::Const.EntityType.SkeletonLichMirrorImage,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_lich_mirror_image"
	},
	SkeletonGladiator = {
		ID = ::Const.EntityType.SkeletonGladiator,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/legend_skeleton_gladiator"
	},
	SkeletonPhylactery = {
		ID = ::Const.EntityType.SkeletonPhylactery,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/phylactery"
	},
	ZombieTreasureHunter = {
		ID = ::Const.EntityType.ZombieTreasureHunter,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/zombie_treasure_hunter"
	},
	FlyingSkull = {
		ID = ::Const.EntityType.FlyingSkull,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/flying_skull"
	},
	LegendMummyPriest = {
		ID = ::Const.EntityType.LegendMummyPriest,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/legend_mummy_priest"
	},
	FreeCompanySpearman = {
		ID = ::Const.EntityType.FreeCompanySpearman,
		Variant = 0,
		Strength = 17,
		Cost = 17,
		Row = 1,
		Script = "scripts/entity/tactical/humans/free_company_spearman"
	},
	FreeCompanySpearmanLow = {
		ID = ::Const.EntityType.FreeCompanySpearman,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 1,
		Script = "scripts/entity/tactical/humans/free_company_spearman_low"
	},
	FreeCompanySlayer = {
		ID = ::Const.EntityType.FreeCompanySlayer,
		Variant = 0,
		Strength = 22,
		Cost = 22,
		Row = 1,
		Script = "scripts/entity/tactical/humans/free_company_slayer"
	},
	FreeCompanyFootman = {
		ID = ::Const.EntityType.FreeCompanyFootman,
		Variant = 0,
		Strength = 22,
		Cost = 22,
		Row = 2,
		Script = "scripts/entity/tactical/humans/free_company_footman"
	},
	FreeCompanyArcher = {
		ID = ::Const.EntityType.FreeCompanyArcher,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 3,
		Script = "scripts/entity/tactical/humans/free_company_archer"
	},
	FreeCompanyArcherLow = {
		ID = ::Const.EntityType.FreeCompanyArcher,
		Variant = 0,
		Strength = 10,
		Cost = 10,
		Row = 3,
		Script = "scripts/entity/tactical/humans/free_company_archer_low"
	},
	FreeCompanyCrossbow = {
		ID = ::Const.EntityType.FreeCompanyCrossbow,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 3,
		Script = "scripts/entity/tactical/humans/free_company_crossbow"
	},
	FreeCompanyLongbow = {
		ID = ::Const.EntityType.FreeCompanyLongbow,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 3,
		Script = "scripts/entity/tactical/humans/free_company_longbow"
	},
	FreeCompanyBillman = {
		ID = ::Const.EntityType.FreeCompanyBillman,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/free_company_billman"
	},
	FreeCompanyPikeman = {
		ID = ::Const.EntityType.FreeCompanyPikeman,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/free_company_pikeman"
	},
	FreeCompanyInfantry = {
		ID = ::Const.EntityType.FreeCompanyInfantry,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/free_company_infantry"
	},
	FreeCompanyLeader = {
		ID = ::Const.EntityType.FreeCompanyLeader,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 1,
		Script = "scripts/entity/tactical/humans/free_company_leader"
	},
	FreeCompanyLeaderLow = {
		ID = ::Const.EntityType.FreeCompanyLeaderLow,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/humans/free_company_leader_low"
	},
	Oathbringer = {
		ID = ::Const.EntityType.Oathbringer,
		Variant = 1,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/oathbringer",
		NameList = ::Const.Strings.OathbringerNames,
		TitleList = null
	},
	SatoManhunterRanged = {
		ID = ::Const.EntityType.SatoManhunterRanged,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/sato_manhunter_ranged"
	},
	SatoManhunterVeteranRanged = {
		ID = ::Const.EntityType.SatoManhunterVeteranRanged,
		Variant = 1,
		Strength = 25,
		Cost = 28,
		Row = 2,
		Script = "scripts/entity/tactical/humans/sato_manhunter_veteran_ranged",
		NameList = ::Const.Strings.SouthernNames,
		TitleList = ::Const.Strings.SatoManhunterVeteranTitles
	},
	LegendNobleGuard = {
		ID = ::Const.EntityType.LegendNobleGuard,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_footman_veteran"
	},
	LegendManAtArms = {
		ID = ::Const.EntityType.LegendManAtArms,
		Variant = 0,
		Strength = 100,
		Cost = 100,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_man_at_arms"
	}
};

gt.Const.World.Spawn.Caravan <- {
	Name = "Caravan",
	IsDynamic = true,
	MovementSpeedMult = 0.5,
	VisibilityMult = 1.0,
	VisionMult = 0.25,
	Body = "cart_02",
	MaxR = 225,
	MinR = 30,
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 3,
			Weight = 30,
			Type = ::Const.World.Spawn.Troops.CaravanDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.CaravanGuard,
					Cost = 15
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.CaravanHand,
					Cost = 12
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendCaravanPolearm,
					Cost = 12
				}
			]
		},
	]
};

gt.Const.World.Spawn.CaravanEscort <- [
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanGuard,
				Num = 1
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanGuard,
				Num = 1
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanGuard,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanGuard,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanGuard,
				Num = 1
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanGuard,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.CaravanDonkey,
				Num = 3
			}
		]
	}
];
gt.Const.World.Spawn.CaravanSouthernEscort <- [
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.Conscript,
				Num = 1
			},
			{
				Type = ::Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.Conscript,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.SouthernDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.Conscript,
				Num = 2
			},
			{
				Type = ::Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.Conscript,
				Num = 3
			},
			{
				Type = ::Const.World.Spawn.Troops.SouthernDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.Conscript,
				Num = 3
			},
			{
				Type = ::Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_03",
		Troops = [
			{
				Type = ::Const.World.Spawn.Troops.Conscript,
				Num = 4
			},
			{
				Type = ::Const.World.Spawn.Troops.SouthernDonkey,
				Num = 3
			}
		]
	}
];
function onCostCompare( _t1, _t2 )
{
	if (_t1.Cost < _t2.Cost)
	{
		return -1;
	}
	else if (_t1.Cost > _t2.Cost)
	{
		return 1;
	}

	return 0;
}

function calculateCosts( _p )
{
	foreach( p in _p )
	{
		p.Cost <- 0;

		foreach( t in p.Troops )
		{
			p.Cost += t.Type.Cost * t.Num;
		}

		if (!("MovementSpeedMult" in p))
		{
			p.MovementSpeedMult <- 1.0;
		}
	}

	_p.sort(this.onCostCompare);
}

this.calculateCosts(::Const.World.Spawn.CaravanEscort);
this.calculateCosts(::Const.World.Spawn.CaravanSouthernEscort);
local spawnMap = {};

//new

local function addEntityType(_id, _name, _namePlural, _icon)
{
	if (!("EntityTypeMax" in ::Const))
	{
		local max = 0;
		foreach(key, value in ::Const.EntityType)
		{
			if (typeof value == "integer" && value > max) max = value;
		}
		::Const.EntityTypeMax <- max;
	}
	::Const.EntityType[_id] <- ++::Const.EntityTypeMax;
	::Const.Strings.EntityName.push(_name);
	::Const.Strings.EntityNamePlural.push(_namePlural);
	::Const.EntityIcon.push(_icon);
}

addEntityType("CultistPriest", "Priest of Davkul", "Priests of Davkul", "cultist_orientation");
addEntityType("CultistKnight", "Knight of Davkul", "Knights of Davkul", "cultist_orientation");
addEntityType("CultistChosen", "Chosen of Davkul", "Chosen of Davkul", "cultist_orientation");

::Const.World.Spawn.Troops.CultistPriest <- {
	ID = ::Const.EntityType.CultistPriest,
	Variant = 0,
	Strength = 60,
	Cost = 15,
	Row = 3,
	Script = "scripts/entity/tactical/humans/cultist_priest"
};

::Const.World.Spawn.Troops.CultistKnight <- {
	ID = ::Const.EntityType.CultistKnight,
	Variant = 0,
	Strength = 90,
	Cost = 15,
	Row = -1,
	Script = "scripts/entity/tactical/humans/cultist_knight"
};

::Const.World.Spawn.Troops.CultistChosen <- {
	ID = ::Const.EntityType.CultistChosen,
	Variant = 0,
	Strength = 120,
	Cost = 15,
	Row = -1,
	Script = "scripts/entity/tactical/humans/cultist_chosen"
};

foreach( t in gt.Const.World.Spawn.Troops )
{
	spawnMap[t.ID] <- t;
}

gt.Const.World.Spawn.TroopsMap <- spawnMap;

