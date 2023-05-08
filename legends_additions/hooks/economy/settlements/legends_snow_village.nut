::mods_hookExactClass("entity/world/settlements/legends_snow_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Tonder",
				"Lydersholm",
				"Kravlund",
				"Bola",
				"Ravestad",
				"Gammeljord",
				"Tabtmennesker",
				"Morktoppe",
				"Lysdal",
				"Narredod",
				"Forsvinde",
				"Alsliv",
				"Hellevad",
				"Heimstad",
				"Hornheim",
				"Jerstal",
				"Hejsager",
				"Kalk",
				"Sommerstad",
				"Horn",
				"Bramming",
				"Varde",
				"Norre",
				"Vistadt",
				"Olbing",
				"Grimstad",
				"Birkeland",
				"Donnerstad",
				"Tangvall",
				"Helvik",
				"Ogna",
				"Norheim",
				"Undheim",
				"Torvastad",
				"Skjold",
				"Eidsvik",
				"Halheim",
				"Gerheim",
				"Asenstad",
				"Gunnheim",
				"Hammar",
				"Bullarsby",
				"Lonneberg"
			],
			[
				"Tonder",
				"Lydersholm",
				"Kravlund",
				"Bola",
				"Ravestad",
				"Alsliv",
				"Hellevad",
				"Heimstad",
				"Hornheim",
				"Jerstal",
				"Hejsager",
				"Kalk",
				"Sommerstad",
				"Horn",
				"Bramming",
				"Varde",
				"Norre",
				"Vistadt",
				"Olbing",
				"Grimstad",
				"Birkeland",
				"Donnerstad",
				"Tangvall",
				"Helvik",
				"Ogna",
				"Norheim",
				"Undheim",
				"Torvastad",
				"Skjold",
				"Eidsvik",
				"Halheim",
				"Gerheim",
				"Asenstad",
				"Gunnheim",
				"Hammar"
			],
			[
				"Tondersted",
				"Jarlsted",
				"Lydersted",
				"Bolasted",
				"Ravested",
				"Hellested",
				"Hornsted",
				"Hejsted",
				"Sommersted",
				"Brammingsted",
				"Vardested",
				"Norrested",
				"Grimsted",
				"Ognasted",
				"Eidsted",
				"Gersted",
				"Asested",
				"Gunnsted",
				"Hammarsted",
				"Arsasted",
				"Rollarsted",
				"Skagensted",
				"Harkensted",
				"Agersted",
				"Svarrested",
				"Ovarsted"
			]
		];
		this.m.DraftLists = [
			[
				"beggar_background",
				"brawler_background",
				"brawler_background",
				"cultist_background",
				"daytaler_background",
				"lumberjack_background",
				"mason_background",
				"miner_background",
				
				"poacher_background",
				"thief_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
				"brawler_background",
				"brawler_background",
				"cultist_background",
				"lumberjack_background",
				"mason_background",
				"miner_background",
				
				"poacher_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background"
			],
			[
				"apprentice_background",
				"brawler_background",
				"brawler_background",
				"cultist_background",
				"daytaler_background",
				"daytaler_background",
				"gravedigger_background",
				"gravedigger_background",
				"graverobber_background",
				"hunter_background",
				"killer_on_the_run_background",
				"lumberjack_background",
				"militia_background",
				"miner_background",
				"peddler_background",
				"poacher_background",
				"poacher_background",
				"poacher_background",
				"thief_background",
				"vagabond_background",
				"wildman_background",
				"disowned_noble_background",
				"cripple_background",
				"apprentice_background",
				"brawler_background",
				"brawler_background",
				"cultist_background",
				"gravedigger_background",
				"gravedigger_background",
				"graverobber_background",
				"hunter_background",
				"killer_on_the_run_background",
				"lumberjack_background",
				"militia_background",
				"miner_background",
				"peddler_background",
				"poacher_background",
				"poacher_background",
				"poacher_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
				"cripple_background"
			],
			[
				"apprentice_background",
				"brawler_background",
				"brawler_background",
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"cultist_background",
				"gravedigger_background",
				"graverobber_background",
				"killer_on_the_run_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",
				"peddler_background",
				
				"poacher_background",
				"poacher_background",
				"poacher_background",
				"ratcatcher_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
				"witchhunter_background",
				"bastard_background",
				"raider_background",
				"raider_background",
				"sellsword_background",
				
				
			]
		];
		this.m.FemaleDraftLists = [
			[
				"female_beggar_background",
				"female_daytaler_background",
				"female_thief_background"
			],
			[
				"wildwoman_background",
				"female_daytaler_background",
				"female_daytaler_background",
				"female_thief_background",
				"female_disowned_noble_background"
			],
			[
				"legend_shieldmaiden_background",
				"female_beggar_background",
				"female_bowyer_background",
				"female_daytaler_background",
				"female_daytaler_background",
				"female_farmhand_background",
				"female_tailor_background",
				"female_thief_background",
				"wildwoman_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background",
				"female_disowned_noble_background"
			]
		];
		this.m.StablesLists = [
			[],
			[],
			[]
		];

		if (this.Const.DLC.Unhold)
		{
			this.m.DraftLists[0].push("beast_hunter_background");
			this.m.DraftLists[1].push("beast_hunter_background");
			this.m.DraftLists[2].push("beast_hunter_background");
		}

		this.m.Rumors = this.Const.Strings.RumorsSnowSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Math.rand(1, 100) <= 30)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (this.Math.rand(1, 100) <= 30)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 0, false, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 0, false, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 0, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 0, false, true);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Snow
		], [
			this.Const.World.TerrainType.Snow >= 2
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.SnowyForest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Tundra
		], 3, true);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/barber_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/surface_iron_vein_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra
			], [], 1);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/trapper_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Snow
		], [
			this.Const.World.TerrainType.Tundra
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 3, true);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Math.rand(1, 100) <= 50 || this.Const.World.Buildings.Barbers == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/barber_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wooden_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Snow
			], [], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				this.Const.World.TerrainType.Snow
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Snow
			], [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				this.Const.World.TerrainType.Snow
			], [], 1, true);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/trapper_location", [
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Snow
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			this.Const.World.TerrainType.Snow
		], [], 1, false, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Snow
		], [], 1, true);
	}

});

