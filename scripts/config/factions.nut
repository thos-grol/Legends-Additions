local gt = this.getroottable();
gt.Const.Factions <- {
	GlobalMinDelay = 3.0,
	BuildCampTries = 1,
	RelationDecayPerDay = 0.33,
	CyclesOnNewCampaign = 2000,
	NeutralColor = this.createColor("#ffffff"),
	HostileColor = this.createColor("#e57878"),
	PermanentHostileColor = this.createColor("#c72727"),
	GreaterEvilStartStrength = 125.0,
	GreaterEvilDailyStrength = -1.0,
	GreaterEvilStrengthOnPartyDestroyed = -2.0,
	GreaterEvilStrengthOnLocationDestroyed = -4.0,
	GreaterEvilStrengthOnCriticalContract = -12.0,
	GreaterEvilStrengthOnCommonContract = -6.0,
	GreaterEvilStrengthOnFailedContract = 6.0,
	GreaterEvilStrengthOnTownDestroyed = 0.0
};
gt.Const.FactionType <- {
	None = 0,
	Neutral = 1,
	Player = 1,
	NobleHouse = 2,
	Settlement = 3,
	TradingCompany = 4,
	Bandits = 5,
	Orcs = 6,
	Goblins = 7,
	Undead = 8,
	Zombies = 9,
	Beasts = 10,
	Generic = 11,
	Barbarians = 12,
	OrientalCityState = 13,
	OrientalBandits = 14,
	Arena = 15,
	FreeCompany = 16,
	DummyFaction = 17,
	Cultists = 18,
	COUNT = 19
};
gt.Const.Faction <- {
	None = 0,
	Player = 1,
	PlayerAnimals = 2,
	Enemy = 3,
	Civilian = 4,
	NobleHouse = 5,
	Bandits = 6,
	Beasts = 7,
	Undead = 8,
	Zombies = 9,
	Orcs = 10,
	Goblins = 11,
	Barbarians = 12,
	OrientalCityState = 13,
	OrientalBandits = 14,
	Arena = 15,
	FreeCompany = 16,
	DummyFaction = 17,
	Cultists = 18,
	COUNT = 19
};
gt.Const.FactionColor <- [
	this.createColor("#ffffff"),
	this.createColor("#02dc1b"),
	this.createColor("#02dc1b"),
	this.createColor("#ababab"),
	this.createColor("#ffffff"),
	this.createColor("#ffffff"),
	this.createColor("#ff9595"),
	this.createColor("#b75a00"),
	this.createColor("#bd00c4"),
	this.createColor("#bd00c4"),
	this.createColor("#bd00c4"),
	this.createColor("#1aa83f"),
	this.createColor("#537117"),
	this.createColor("#ff9595"),
	this.createColor("#ffffff"),
	this.createColor("#ff9595"),
	this.createColor("#b75a00"),
	this.createColor("#ffffff"),
	this.createColor("#ffffff"),
];
gt.Const.FactionBase <- [
	"",
	"bust_base_player",
	"bust_base_player",
	"bust_base_bandits",
	"bust_base_militia",
	"bust_base_military",
	"bust_base_bandits",
	"bust_base_beasts",
	"bust_base_undead",
	"bust_base_undead",
	"bust_base_orcs",
	"bust_base_goblins",
	"bust_base_wildmen_01",
	"bust_base_militia",
	"bust_base_militia",
	"bust_base_beasts",
	"bust_base_militia",
	"bust_base_beasts",
];
gt.Const.FactionAlliance <- [
	[
		this.Const.Faction.None,
		this.Const.Faction.Player,
		this.Const.Faction.PlayerAnimals,
		this.Const.Faction.Enemy,
		this.Const.Faction.Civilian,
		this.Const.Faction.NobleHouse,
		this.Const.Faction.Bandits,
		this.Const.Faction.Beasts,
		this.Const.Faction.Undead,
		this.Const.Faction.Orcs,
		this.Const.Faction.Goblins
	],
	[
		this.Const.Faction.Player,
		this.Const.Faction.PlayerAnimals,
		this.Const.Faction.Civilian,
		this.Const.Faction.NobleHouse
	],
	[
		this.Const.Faction.PlayerAnimals,
		this.Const.Faction.Player,
		this.Const.Faction.Civilian,
		this.Const.Faction.NobleHouse
	],
	[
		this.Const.Faction.Enemy
	],
	[
		this.Const.Faction.Civilian,
		this.Const.Faction.NobleHouse,
		this.Const.Faction.Player,
		this.Const.Faction.PlayerAnimals,
		this.Const.Faction.FreeCompany
	],
	[
		this.Const.Faction.NobleHouse,
		this.Const.Faction.Civilian,
		this.Const.Faction.Player,
		this.Const.Faction.PlayerAnimals,
		this.Const.Faction.FreeCompany
	],
	[
		this.Const.Faction.Bandits
	],
	[
		this.Const.Faction.Beasts,
		this.Const.Faction.Undead
	],
	[
		this.Const.Faction.Undead,
		this.Const.Faction.Beasts,
		this.Const.Faction.Zombies
	],
	[
		this.Const.Faction.Zombies,
		this.Const.Faction.Beasts,
		this.Const.Faction.Undead
	],
	[
		this.Const.Faction.Orcs
	],
	[
		this.Const.Faction.Goblins
	],
	[
		this.Const.Faction.Barbarians
	],
	[
		this.Const.Faction.NobleHouse,
		this.Const.Faction.Civilian,
		this.Const.Faction.Player,
		this.Const.Faction.PlayerAnimals,
		this.Const.Faction.FreeCompany
	],
	[
		this.Const.Faction.OrientalBandits
	],
	[
		this.Const.Faction.Arena
	],
	[
		this.Const.Faction.FreeCompany,
		this.Const.Faction.Civilian,
		this.Const.Faction.OrientalCityState,
		this.Const.Faction.NobleHouse
	],
	[],
	[
		this.Const.Faction.Cultists
	]
];
gt.Const.GenericFootprints <- [
	"world_footprints_n",
	"world_footprints_ne",
	"world_footprints_e",
	"world_footprints_se",
	"world_footprints_s",
	"world_footprints_sw",
	"world_footprints_w",
	"world_footprints_nw"
];
gt.Const.OrcFootprints <- [
	"world_footprints_orcs_n",
	"world_footprints_orcs_ne",
	"world_footprints_orcs_e",
	"world_footprints_orcs_se",
	"world_footprints_orcs_s",
	"world_footprints_orcs_sw",
	"world_footprints_orcs_w",
	"world_footprints_orcs_nw"
];
gt.Const.BeastFootprints <- [
	"world_footprints_beasts_n",
	"world_footprints_beasts_ne",
	"world_footprints_beasts_e",
	"world_footprints_beasts_se",
	"world_footprints_beasts_s",
	"world_footprints_beasts_sw",
	"world_footprints_beasts_w",
	"world_footprints_beasts_nw"
];
gt.Const.UndeadFootprints <- [
	"world_footprints_undead_n",
	"world_footprints_undead_ne",
	"world_footprints_undead_e",
	"world_footprints_undead_se",
	"world_footprints_undead_s",
	"world_footprints_undead_sw",
	"world_footprints_undead_w",
	"world_footprints_undead_nw"
];

