::mods_hookExactClass("entity/world/settlements/legends_farm_fort", function(o) {
	o.create = function()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
				"Gardendorf",
				"Walldorf",
				"Hageturm",
				"Starkort",
				"Todesmauer",
				"Grimmigwand",
				"Hochturm",
				"Wiesenwacht",
				"Markwall",
				"Hornwall",
				"Hemmelswacht",
				"Weissenwacht",
				"Grafenturm",
				"Grafenwacht",
				"Wagenwall",
				"Herrmanswacht",
				"Wallheim",
				"Schanzdorf",
				"Koppelwacht",
				"Grafenschanze",
				"Hammerturm",
				"Speerheim",
				"Grunwacht",
				"Schonwall",
				"Auwall",
				"Graswacht",
				"Hainwall",
				"Krugwall",
				"Grafenburg",
				"Furstenwall",
				"Thalwacht",
				"Weiherwacht"
			],
			[
				"Haselburg",
				"Hageburg",
				"Marksburg",
				"Wehrburg",
				"Hemmelsburg",
				"Weissenburg",
				"Grafenburg",
				"Tiefenburg",
				"Grunburg",
				"Wallburg",
				"Koppelburg",
				"Weideburg",
				"Auenburg",
				"Gardeburg",
				"Friedland",
				"Kroonsburg",
				"Grasburg",
				"Thalburg",
				"Weihersburg",
				"Sommerburg",
				"Freudburg",
				"Feldburg",
				"Langenburg",
				"Heuburg",
				"Muhlburg",
				"Weisenburg",
				"Weinburg"
			],
			[
				"Haselfeste",
				"Reiherfeste",
				"Wehrfeste",
				"Konigsfeste",
				"Grafenschanze",
				"Weissenfeste",
				"Koppelfeste",
				"Weidefeste",
				"Auenfeste",
				"Gardefeste",
				"Kroonsfeste",
				"Grunfeste",
				"Hoberfeste",
				"Grunlandfeste",
				"Freilandfeste",
				"Lowenschanze",
				"Weidenfeste",
				"Feldfeste",
				"Aulenfeste",
				"Gerstenfeste",
				"Brunnenfeste",
				"Tauschanze"
			]
		];
		this.m.DraftLists = [
			[
				"farmhand_background",
				"farmhand_background",

				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"miller_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background",

				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background"
			],
			[
				"gambler_background",

				"farmhand_background",
				"mason_background",
				"messenger_background",
				"militia_background",

				"ratcatcher_background",
				"vagabond_background",

				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"disowned_noble_background",
				"sellsword_background",


				"cripple_background",
				"gambler_background",

				"mason_background",
				"messenger_background",
				"militia_background",
				"ratcatcher_background",
				"vagabond_background",

				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",


				"cripple_background"
			],
			[
				"apprentice_background",
				"gambler_background",
				"farmhand_background",
				"farmhand_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"miller_background",
				"miller_background",


				"ratcatcher_background",
				"refugee_background",
				//"tailor_background",
				"vagabond_background",

				"adventurous_noble_background",
				"bastard_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"deserter_background",
				"disowned_noble_background",
				"disowned_noble_background",
				"retired_soldier_background",
				"sellsword_background",



				"apprentice_background",
				"gambler_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",


				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",

				"bastard_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"sellsword_background",


			]
		];
		this.m.FemaleDraftLists = [
			[
				
				
				
				"female_adventurous_noble_background"
			],
			[
				

				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[
				
				
				
				
				
				"female_adventurous_noble_background",
				"female_disowned_noble_background",
				"female_disowned_noble_background"
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
		this.m.Rumors = ::Const.Strings.RumorsFarmingSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		local r = this.Math.rand(1, 2);
		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [], 1);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], 4, true);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		local r = this.Math.rand(1, 3);

		if (r == 1 || ::Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.SnowyForest
		], [], 2);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (::Legends.Mod.ModSettings.getSetting("StackCitadels").getValue())
		{
			local ALL = [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", ALL, [], 0, false, true, true);
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		local r = this.Math.rand(2, 4);
		if (r == 2 || ::Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [
				::Const.World.TerrainType.Tundra
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [
				::Const.World.TerrainType.Tundra
			], 1, true);
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 2, true);
		}

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", [
				::Const.World.TerrainType.Plains
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.SnowyForest
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains
		], [
			::Const.World.TerrainType.Plains
		]);
	}

});

