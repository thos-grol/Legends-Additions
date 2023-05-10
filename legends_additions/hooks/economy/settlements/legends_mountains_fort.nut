::mods_hookExactClass("entity/world/settlements/legends_mountains_fort", function(o) {
	o.create = function()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
				"Wallstein",
				"Hohenwacht",
				"Steinberg",
				"Wolfswall",
				"Felswall",
				"Steinwacht",
				"Eisenwall",
				"Jaderwall",
				"Hohenschanze",
				"Wallheim",
				"Gronenwall",
				"Thalwacht",
				"Schanzberg",
				"Windwacht",
				"Turmwacht",
				"Felswacht",
				"Hohenturm",
				"Adlerwacht",
				"Scharfenstein",
				"Oberwallheim",
				"Hochwall",
				"Bergwall",
				"Finkenwacht",
				"Greifenwall",
				"Himmelswacht"
			],
			[
				"Hohenburg",
				"Wolfenburg",
				"Felsburg",
				"Eisenburg",
				"Jadeburg",
				"Gronenburg",
				"Thalburg",
				"Sattelburg",
				"Windburg",
				"Turmburg",
				"Adlerburg",
				"Scharfenburg",
				"Wolfenstein",
				"Brunwald",
				"Heldenburg",
				"Wurmburg",
				"Schwertburg",
				"Lanzenburg",
				"Himmelsburg",
				"Granitschanze",
				"Erzburg",
				"Wolkenburg",
				"Hochburg",
				"Windfall",
				"Gemmenburg",
				"Hohenstein",
				"Oberburg"
			],
			[
				"Hohenfeste",
				"Wolfenfeste",
				"Wolfenstein",
				"Felsfeste",
				"Eisenfeste",
				"Grollfeste",
				"Grubenfeste",
				"Donnerfeste",
				"Erzfeste",
				"Gronenfeste",
				"Sattelfeste",
				"Kammfeste",
				"Turmfeste",
				"Windfeste",
				"Adlerfeste",
				"Brunwald",
				"Heldenfeste",
				"Wurmfeste",
				"Schwertfeste",
				"Lanzenfeste",
				"Falkenstein",
				"Flechtenstein",
				"Himmelsfeste",
				"Steinturm",
				"Gipfelfeste",
				"Zugfeste",
				"Granitfeste",
				"Zinnenfeste",
				"Wackersfeste",
				"Fernsichtfeste",
				"Wildbergfeste"
			]
		];
		this.m.DraftLists = [
			[
				"apprentice_background",
				
				"beggar_background",
				"brawler_background",
				"daytaler_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"vagabond_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"apprentice_background",
				
				"brawler_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"vagabond_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",
				"apprentice_background",
				
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"mason_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"servant_background",
				"shepherd_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"disowned_noble_background",
				"retired_soldier_background",
				"sellsword_background",
				"sellsword_background",
				"apprentice_background",
				"apprentice_background",
				
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"mason_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"shepherd_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"sellsword_background",
				"sellsword_background"
			],
			[
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"gravedigger_background",
				"graverobber_background",
				"juggler_background",
				"mason_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"ratcatcher_background",
				"vagabond_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"disowned_noble_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				"sellsword_background",
				"sellsword_background",
				"squire_background",
				"squire_background",
				
				"cripple_background",
				"hedge_knight_background",
				"hedge_knight_background",
				"apprentice_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"gravedigger_background",
				"graverobber_background",
				"juggler_background",
				"mason_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",
				"miner_background",
				"miner_background",
				"miner_background",
				"ratcatcher_background",
				"vagabond_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"disowned_noble_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				"sellsword_background",
				"sellsword_background",
				"squire_background",
				"squire_background",
				
				"cripple_background",
				"hedge_knight_background",
				"hedge_knight_background"
			]
		];
		this.m.FemaleDraftLists = [
			[
				"female_beggar_background",
				"female_daytaler_background"
			],
			[
				"female_servant_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[
				"female_adventurous_noble_background"
			]
		];
		this.m.StablesLists = [
			[
			],
			[
			],
			[
			]
		];
		this.m.Rumors = this.Const.Strings.RumorsMiningSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			}
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

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], 4, true);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 1, true);
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

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/salt_mine_location", [
			this.Const.World.TerrainType.Hills
		], [
			this.Const.World.TerrainType.Hills
		]);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue())
		{
			local ALL = [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			];
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 0, false, true, true);
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 1, true);
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

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
	}

});

