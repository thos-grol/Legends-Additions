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
				"houndmaster_background",
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
				"houndmaster_background",
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
				"houndmaster_background",
				"farmhand_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"minstrel_background",
				"ratcatcher_background",
				"vagabond_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"disowned_noble_background",
				"sellsword_background",
				"squire_background",
				"squire_background",
				"cripple_background",
				"gambler_background",
				"houndmaster_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"ratcatcher_background",
				"vagabond_background",
				"witchhunter_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				"squire_background",
				"squire_background",
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
				"minstrel_background",
				"peddler_background",
				"ratcatcher_background",
				"refugee_background",
				"tailor_background",
				"vagabond_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"bastard_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"deserter_background",
				"disowned_noble_background",
				"disowned_noble_background",
				"hedge_knight_background",
				"retired_soldier_background",
				"sellsword_background",
				"squire_background",
				"squire_background",
				"swordmaster_background",
				"apprentice_background",
				"gambler_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"minstrel_background",
				"peddler_background",
				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"witchhunter_background",
				"bastard_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"deserter_background",
				"hedge_knight_background",
				"retired_soldier_background",
				"sellsword_background",
				"squire_background",
				"squire_background",
				"swordmaster_background"
			]
		];
		this.m.FemaleDraftLists = [
			[
				"female_farmhand_background",
				"female_farmhand_background",
				"female_miller_background",
				"female_adventurous_noble_background"
			],
			[
				"female_farmhand_background",
				"female_minstrel_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[
				"female_farmhand_background",
				"female_farmhand_background",
				"female_miller_background",
				"female_miller_background",
				"female_tailor_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background",
				"female_disowned_noble_background"
			]
		];
		this.m.StablesLists = [
			[
				"legend_donkey_background",
				"legend_horse_rouncey"
			],
			[
				"legend_donkey_background",
				"legend_horse_rouncey",
				"legend_horse_destrier"
			],
			[
				"legend_donkey_background",
				"legend_horse_rouncey",
				"legend_horse_destrier",
				"legend_horse_courser"
			]
		];
		this.m.Rumors = this.Const.Strings.RumorsFarmingSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else
		{
			local r = this.Math.rand(1, 4);

			if (r == 1)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
			}
			else if (r == 4)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
			}
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", [
				this.Const.World.TerrainType.Plains
			], [], 1);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
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
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		local r = this.Math.rand(1, 4);

		if (r == 1 || this.Const.World.Buildings.Kennels == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));
		}
		else if (r == 2 || this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else if (r == 3)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (r == 4)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}

		if (this.Math.rand(1, 100) <= 40)
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

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.SnowyForest
		], [], 2);
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", ALL, [], 0, false, true, true);
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		local r = this.Math.rand(1, 4);

		if (r == 1 || this.Const.World.Buildings.Stables == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/stables_building"));
		}
		else if (r == 2 || this.Const.World.Buildings.Fletchers == 0)
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

		if (this.Math.rand(1, 100) <= 40)
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

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wheat_fields_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/orchard_location", [
				this.Const.World.TerrainType.Plains
			], [
				this.Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.SnowyForest
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Plains
		], [
			this.Const.World.TerrainType.Plains
		]);
	}

});

