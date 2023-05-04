::mods_hookExactClass("entity/world/settlements/legends_mining_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Goldhoft",
				"Ellenberg",
				"Kahlenberg",
				"Bokenberg",
				"Gronenberg",
				"Eisenstein",
				"Fuchsberg",
				"Dunkelspitzen",
				"Hochland",
				"Felsig",
				"Reinberg",
				"Kaltenhof",
				"Jaderberg",
				"Steinhausen",
				"Eichenberg",
				"Thal",
				"Wolfhaiden",
				"Trogen",
				"Sattel",
				"Koppingen",
				"Schweikhof",
				"Hochdorf",
				"Bergau",
				"Nasenfels",
				"Adlerstein",
				"Felsheim",
				"Mitterfels",
				"Hohenau",
				"Pfeilstein",
				"Schneeberg",
				"Weissenfels",
				"Senftenberg",
				"Eisengrab",
				"Weitblick",
				"Erdfall",
				"Helfenstein",
				"Hammererden"
			],
			[
				"Hochgrube",
				"Erzgrube",
				"Schachtheim",
				"Erzheim",
				"Schmelzheim",
				"Eisenstein",
				"Erzfels",
				"Gemmenschacht",
				"Salzbruch",
				"Salzfels",
				"Erzbruch",
				"Hohenbruch",
				"Eisenheim",
				"Grubenheim",
				"Eisenberg",
				"Erzberg",
				"Havelberg",
				"Goldbruch",
				"Wolkenstein",
				"Goldstein",
				"Gemmenstein",
				"Grafenschacht",
				"Kahlengrube",
				"Trogenschacht",
				"Adlerstollen",
				"Reinbruch",
				"Hammererden",
				"Schneefels",
				"Weissenschacht",
				"Ellengrube"
			],
			[
				"Hochgrube",
				"Erzgrube",
				"Schachtheim",
				"Erzheim",
				"Schmelzheim",
				"Eisenstein",
				"Erzfels",
				"Gemmenschacht",
				"Salzbruch",
				"Salzfels",
				"Erzbruch",
				"Hohenbruch",
				"Eisenheim",
				"Grubenheim",
				"Eisenberg",
				"Erzberg",
				"Havelberg",
				"Goldbruch",
				"Wolkenstein",
				"Goldstein",
				"Gemmenstein",
				"Grafenschacht",
				"Kahlengrube",
				"Trogenschacht",
				"Adlerstollen",
				"Reinbruch",
				"Hammererden",
				"Schneefels",
				"Weissenschacht",
				"Ellengrube"
			]
		];
		this.m.DraftLists = [
			[
				"apprentice_background",
				"beggar_background",
				"brawler_background",
				"daytaler_background",
				"graverobber_background",
				"mason_background",
				"messenger_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"peddler_background",
				"thief_background",
				"poacher_background",
				"apprentice_background",
				"brawler_background",
				"graverobber_background",
				"mason_background",
				"messenger_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"peddler_background",
				"poacher_background"
			],
			[
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"daytaler_background",
				"juggler_background",
				"killer_on_the_run_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"peddler_background",
				"ratcatcher_background",
				"servant_background",
				"shepherd_background",
				"thief_background",
				"vagabond_background",
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"juggler_background",
				"killer_on_the_run_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"peddler_background",
				"ratcatcher_background",
				"shepherd_background",
				"vagabond_background"
			],
			[
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"daytaler_background",
				"juggler_background",
				"killer_on_the_run_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"peddler_background",
				"ratcatcher_background",
				"servant_background",
				"shepherd_background",
				"thief_background",
				"vagabond_background",
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"juggler_background",
				"killer_on_the_run_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"peddler_background",
				"ratcatcher_background",
				"shepherd_background",
				"vagabond_background"
			]
		];
		this.m.FemaleDraftLists = [
			[
				"female_beggar_background",
				"female_daytaler_background",
				"female_thief_background"
			],
			[
				"female_daytaler_background",
				"female_servant_background",
				"female_thief_background"
			],
			[
				"female_daytaler_background",
				"female_servant_background",
				"female_thief_background"
			]
		];
		this.m.StablesLists = [
			[
				"legend_donkey_background"
			],
			[
				"legend_donkey_background"
			],
			[
				"legend_donkey_background"
			]
		];
		this.m.Rumors = this.Const.Strings.RumorsMiningSettlement;
		this.m.ProduceString = "ore";
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Const.DLC.Unhold && (this.Const.World.Buildings.Taxidermists == 0 || this.Math.rand(1, 100) <= 33))
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		}
		else if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/salt_mine_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = this.Math.rand(1, 3);

		if (r <= 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r <= 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gem_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/salt_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gem_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/salt_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gold_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 1, true);
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
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = this.Math.rand(1, 3);

		if (r <= 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r <= 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gem_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/salt_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gem_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/salt_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gold_mine_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 3, true);
	}

});

