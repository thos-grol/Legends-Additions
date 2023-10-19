::mods_hookExactClass("entity/world/settlements/legends_steppe_fort", function(o) {
	o.create = function()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
				"Wohlenwacht",
				"Krauchwall",
				"Erlachwall",
				"Treitenwacht",
				"Thurnwall",
				"Rothenwall",
				"Sandwacht",
				"Sonnwehr",
				"Siegwacht",
				"Schanzthal",
				"Sudschanze",
				"Strauchwacht",
				"Kargwall",
				"Dornwall",
				"Dornturm",
				"Gelbwall",
				"Suderwacht",
				"Dorngard",
				"Dornwacht",
				"Weissenwacht",
				"Goldwall",
				"Wurmwacht",
				"Brunnwall",
				"Unterwall",
				"Brackenwacht",
				"Steppwall"
			],
			[
				"Wohlenburg",
				"Krauchburg",
				"Erlachburg",
				"Treitenburg",
				"Thunburg",
				"Rothburg",
				"Sonnenburg",
				"Siegburg",
				"Sudburg",
				"Strauchburg",
				"Maderburg",
				"Kargburg",
				"Dornburg",
				"Gelbburg",
				"Suderburg",
				"Lichtburg",
				"Hellenburg",
				"Glanzburg",
				"Strahlenburg",
				"Trockenburg",
				"Schattenburg",
				"Schimmerburg",
				"Splitterburg",
				"Staubburg",
				"Lehmburg",
				"Wustenburg"
			],
			[
				"Wohlenfeste",
				"Krauchfeste",
				"Erlachfeste",
				"Treitenfeste",
				"Thunfeste",
				"Rothenfeste",
				"Sonnenfeste",
				"Siegfeste",
				"Sudfeste",
				"Suderfeste",
				"Strauchfeste",
				"Maderfeste",
				"Kargfeste",
				"Dornenfeste",
				"Gelbfeste",
				"Lichtfeste",
				"Hellenfeste",
				"Glanzfeste",
				"Strahlfeste",
				"Konigsfeste",
				"Knochenfeste",
				"Durrfeste",
				"Sandsturmfeste",
				"Gelbfelsfeste",
				"Rothsteinfeste",
				"Goldfeste",
				"Scharfzahnfeste",
				"Brandfeste",
				"Staubfeste",
				"Odfeste",
				"Habichtfeste"
			]
		];
		this.m.FemaleDraftLists = [
			[
				
			],
			[
				
				
				"female_adventurous_noble_background"
			],
			[
				

				
				
				"female_adventurous_noble_background",
				"female_adventurous_noble_background",
				"female_adventurous_noble_background"
			]
		];
		this.m.DraftLists = [
			[
				"caravan_hand_background",
				"caravan_hand_background",

				"daytaler_background",
				"mason_background",
				"militia_background",
				"militia_background",
				"shepherd_background",
				"vagabond_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"caravan_hand_background",
				"caravan_hand_background",

				"mason_background",
				"militia_background",
				"militia_background",
				"shepherd_background",
				"vagabond_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",

				"beggar_background",
				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"hunter_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",
				"refugee_background",
				"servant_background",
				"vagabond_background",

				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				"apprentice_background",

				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"hunter_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",

				"bastard_background",
				"deserter_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background"
			],
			[
				"apprentice_background",
				"beggar_background",

				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"gravedigger_background",
				"hunter_background",
				"hunter_background",
				"juggler_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",

				"ratcatcher_background",
				"refugee_background",
				"servant_background",
				//"tailor_background",
				"vagabond_background",

				"adventurous_noble_background",
				"adventurous_noble_background",
				"adventurous_noble_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				"sellsword_background",
				"sellsword_background",


				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"gravedigger_background",
				"hunter_background",
				"hunter_background",
				"juggler_background",
				"mason_background",
				"messenger_background",
				"militia_background",
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
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				"sellsword_background",
				"sellsword_background",
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
		this.m.Rumors = ::Const.Strings.RumorsSteppeSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		local r = this.Math.rand(1, 2);
		if (r == 1)
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/beekeeper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/beekeeper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
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
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		local r = this.Math.rand(1, 2);

		if (r == 1 || ::Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
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

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			]);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [
				::Const.World.TerrainType.Tundra
			]);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			]);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [
				::Const.World.TerrainType.Tundra
			]);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/training_hall_building"));
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));

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
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 0, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/goat_herd_location", ALL, [], 0, false, true, true);
			return;
		}

		if (this.Math.rand(1, 100) <= 50 || ::Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else
		{
			this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 5, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 5, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1, true);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills
		], []);
	}

});

