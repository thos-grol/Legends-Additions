::mods_hookExactClass("entity/world/settlements/legends_coast_fort", function(o) {
	o.create = function()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
				"Seefeste",
				"Kleifeste",
				"Otterfeste",
				"Blankenfeste",
				"Kampfeste",
				"Stohlfeste",
				"Krakenfeste",
				"Sandfeste",
				"Aalfeste",
				"Sturmfeste",
				"Wesefeste",
				"Dunenfeste",
				"Horizont",
				"Ertrunkenort",
				"Diekante",
				"Dasende",
				"Wasserkante",
				"Seemarkfeste",
				"Seelandfeste",
				"Regenfeste",
				"Segelfeste",
				"Kranichfeste",
				"Schwalbenfeste",
				"Dunstfeste",
				"Windfeste",
				"Reedfeste"
			],
			[
				"Seeburg",
				"Kielburg",
				"Otternburg",
				"Blankenburg",
				"Kampburg",
				"Stohlburg",
				"Wikburg",
				"Krakenburg",
				"Krumburg",
				"Sandeburg",
				"Meerburg",
				"Aalburg",
				"Dunenburg",
				"Sturmburg",
				"Weseburg",
				"Gischtburg",
				"Mowenburg",
				"Beltburg",
				"Sundburg",
				"Salzburg",
				"Blauburg",
				"Sichelburg",
				"Heringsburg",
				"Schollburg"
			],
			[
				"Seeturm",
				"Sandwacht",
				"Seewall",
				"Kielwall",
				"Strandwall",
				"Otternwacht",
				"Kampwacht",
				"Stohlwall",
				"Seeschanz",
				"Wikwall",
				"Sandturm",
				"Krakenwacht",
				"Strandwehr",
				"Seewehr",
				"Blankwehr",
				"Krumwehr",
				"Wallsande",
				"Salzwacht",
				"Sturmwall",
				"Seewacht",
				"Fernwall",
				"Wesselburg",
				"Dagewall",
				"Windwacht",
				"Weissenwacht",
				"Fishburg",
				"Stindwall",
				"Tidenwall",
				"Ebbenwacht",
				"Prielburg",
				"Sundwall",
				"Sielburg"
			]
		];
		this.m.DraftLists = [
			[
				"fisherman_background",
				"fisherman_background",

				"messenger_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",

				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background",
				"fisherman_background",
				"fisherman_background",

				"messenger_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",

				"bastard_background",
				"deserter_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",
				"caravan_hand_background",
				"gambler_background",
				"daytaler_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",
				"historian_background",
				"messenger_background",
				"militia_background",
				"militia_background",


				"ratcatcher_background",
				"servant_background",
				"vagabond_background",

				"adventurous_noble_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background",
				"sellsword_background",
				"apprentice_background",
				"caravan_hand_background",
				"gambler_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",
				"historian_background",
				"messenger_background",
				"militia_background",
				"militia_background",


				"ratcatcher_background",
				"vagabond_background",

				"bastard_background",
				"deserter_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background",
				"sellsword_background",
			],
			[
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"daytaler_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",
				"historian_background",
				"messenger_background",
				"militia_background",
				"militia_background",

				"ratcatcher_background",
				"refugee_background",
				"servant_background",
				"vagabond_background",

				"adventurous_noble_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"raider_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				
				"cripple_background",
				"eunuch_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",
				"historian_background",
				"messenger_background",
				"militia_background",
				"militia_background",

				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",

				"bastard_background",
				"deserter_background",
				"deserter_background",
				"raider_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				

				"cripple_background",
				"eunuch_background"
			]
		];
		this.m.FemaleDraftLists = [
			[
				"female_butcher_background",
				"female_butcher_background",
				"female_adventurous_noble_background"
			],
			[
				"female_daytaler_background",
				"female_servant_background",
				"female_adventurous_noble_background",
				"female_adventurous_noble_background"
			],
			[
				"female_daytaler_background",
				"female_servant_background",
				"female_adventurous_noble_background",
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
		this.m.Rumors = this.Const.Strings.RumorsFishingSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);

		local r = this.Math.rand(1, 2);
		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 4, true);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		local r = this.Math.rand(1, 2);
		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fishing_huts_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Shore
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fishing_huts_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Shore
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/surface_iron_vein_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills
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
			], [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills
			], [], 1);
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 4, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Hills
		], [], 2, true);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue())
		{
			local ALL = [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			];
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
				this.Const.World.TerrainType.Shore
			], [
				this.Const.World.TerrainType.Ocean,
				this.Const.World.TerrainType.Shore
			], 1, false, false);
			this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", ALL, [
				this.Const.World.TerrainType.Shore
			]);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/amber_collector_location", ALL, [
				this.Const.World.TerrainType.Shore
			]);
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 2, true);
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [
				this.Const.World.TerrainType.Tundra
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Hills
			], [
				this.Const.World.TerrainType.Tundra
			], 1, true);
		}

		this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
			this.Const.World.TerrainType.Shore
		], [
			this.Const.World.TerrainType.Ocean,
			this.Const.World.TerrainType.Shore
		], 1, false, false);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/amber_collector_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Shore
		]);
	}

});

