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
				"tailor_background",
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
				"bowyer_background",
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
				"tailor_background",
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
				"female_beggar_background",
				"female_daytaler_background",
				"female_daytaler_background",
				"female_tailor_background",
				"female_thief_background"
			],
			[
				"female_beggar_background",
				"female_bowyer_background",
				"female_daytaler_background",
				"female_daytaler_background",
				
				"female_servant_background",
				"female_tailor_background",
				"female_thief_background",
				"female_adventurous_noble_background"
			],
			[
				"female_beggar_background",
				"female_beggar_background",
				"female_bowyer_background",
				"female_daytaler_background",
				"female_tailor_background",
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

		if (this.Const.DLC.Unhold)
		{
			this.m.DraftLists[0].push("beast_hunter_background");
			this.m.DraftLists[1].push("beast_hunter_background");
			this.m.DraftLists[2].push("beast_hunter_background");
		}

		this.m.Rumors = this.Const.Strings.RumorsSteppeSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Math.rand(1, 100) <= 25)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else if (this.Math.rand(1, 100) <= 25)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (this.Math.rand(1, 100) <= 25)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/beekeeper_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/winery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			]);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/beekeeper_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/winery_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			]);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/dye_maker_location", [
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/goat_herd_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Steppe
		]);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = this.Math.rand(1, 2);

		if (r == 1 || this.Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/winery_location", [
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/winery_location", [
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/dye_maker_location", [
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Steppe
		]);
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

		if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));
		}
		else if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (this.Math.rand(1, 100) <= 60)
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

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/dye_maker_location", [
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/winery_location", [
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.SnowyForest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
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
			this.Const.World.TerrainType.Steppe
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Steppe
		]);
	}

});

