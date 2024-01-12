::mods_hookExactClass("entity/world/settlements/legends_steppe_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Wohlen",
				"Krauchthal",
				"Brunnenthal",
				"Erlach",
				"Treiten",
				"Pilgerort",
				"Heiligort",
				"Trocken",
				"Barbarisch",
				"Dunkelhautig",
				"Tentlingen",
				"Himmelsdorf",
				"Thurn",
				"Subingen",
				"Thunstetten",
				"Rothenbach",
				"Sandheim",
				"Sonstedt",
				"Siegau",
				"Strohdorf",
				"Sonnheim",
				"Sandfels",
				"Sonnfels",
				"Attendorn",
				"Strauchdorf",
				"Kargau",
				"Sudheim",
				"Krauchdorf",
				"Dornen",
				"Dornthal",
				"Dornheim"
			],
			[
				"Wohlen",
				"Krauchthal",
				"Brunnenthal",
				"Erlach",
				"Treiten",
				"Tentlingen",
				"Himmelsdorf",
				"Thurn",
				"Subingen",
				"Thunstetten",
				"Rothenbach",
				"Sandheim",
				"Sonstedt",
				"Siegau",
				"Strohdorf",
				"Sonnheim",
				"Sandfels",
				"Sonnfels",
				"Strauchdorf",
				"Kargau",
				"Attendorn",
				"Sudheim",
				"Krauchdorf",
				"Dornen",
				"Dornthal",
				"Dornheim"
			],
			[
				"Wunderstadt",
				"Wohlstadt",
				"Brunnstadt",
				"Erlstadt",
				"Himmelstadt",
				"Sandstadt",
				"Dornen",
				"Rothstadt",
				"Gelbstadt",
				"Krautmark",
				"Suderstadt",
				"Sonstadt",
				"Strohmark",
				"Sandmark",
				"Sonnmark",
				"Grafenschein",
				"Hellstadt",
				"Lichtmark",
				"Dornland",
				"Rothenmark",
				"Brunnenland"
			]
		];
		this.m.DraftLists = [
			[
				"apprentice_background",
				"beggar_background",
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"daytaler_background",
				"daytaler_background",

				"refugee_background",
				//"tailor_background",
				"thief_background",
				"vagabond_background",
				"poacher_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",

				"refugee_background",
				"vagabond_background",
				"poacher_background"
			],
			[
				"apprentice_background",
				"beggar_background",

				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"daytaler_background",
				"daytaler_background",
				"historian_background",
				"hunter_background",
				"mason_background",
				"militia_background",


				"ratcatcher_background",
				"refugee_background",
				"refugee_background",
				"servant_background",
				//"tailor_background",
				"thief_background",
				"vagabond_background",
				"adventurous_noble_background",
				"cripple_background",
				"poacher_background",
				"apprentice_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"historian_background",
				"hunter_background",
				"mason_background",
				"militia_background",

				"ratcatcher_background",
				"refugee_background",
				"refugee_background",
				"vagabond_background",
				"cripple_background",
				"poacher_background"
			],
			[
				"apprentice_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"gravedigger_background",
				"graverobber_background",
				"historian_background",
				"hunter_background",
				"juggler_background",
				"militia_background",
				"militia_background",
				"militia_background",





				"ratcatcher_background",
				"refugee_background",
				"refugee_background",
				"servant_background",
				"shepherd_background",
				"thief_background",
				"vagabond_background",
				"bastard_background",
				"raider_background",
				"retired_soldier_background",
				"sellsword_background",

				"cripple_background",
				"eunuch_background",

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

		// if (::Const.DLC.Unhold)
		// {
		// 	this.m.DraftLists[0].push("beast_hunter_background");
		// 	this.m.DraftLists[1].push("beast_hunter_background");
		// 	this.m.DraftLists[2].push("beast_hunter_background");
		// }

		this.m.Rumors = ::Const.Strings.RumorsSteppeSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.m.Size >= 2 && ::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}

		if (::Math.rand(1, 100) <= 25)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else if (::Math.rand(1, 100) <= 25)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (::Math.rand(1, 100) <= 25)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/beekeeper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/winery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			]);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/beekeeper_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/winery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			]);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/dye_maker_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 1);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Steppe
		]);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = ::Math.rand(1, 2);

		if (r == 1 || ::Const.World.Buildings.Fletchers == 0)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (r == 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/winery_location", [
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/winery_location", [
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/dye_maker_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}
		else if (::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (::Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wooden_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/dye_maker_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/winery_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Steppe
		]);
	}

});

