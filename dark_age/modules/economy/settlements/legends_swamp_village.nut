::mods_hookExactClass("entity/world/settlements/legends_swamp_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Stakendorf",
				"Schwartbuck",
				"Monkamp",
				"Sehlendorf",
				"Schwarzpfuhl",
				"Ehlerstorf",
				"Torfbruck",
				"Mohrdorf",
				"Streekmoor",
				"Kolkdorf",
				"Schwarzwasser",
				"Lauenbruck",
				"Farnheim",
				"Birkhain",
				"Rankestadt",
				"Trubewasser",
				"Sumpfschritt",
				"Verschwunden",
				"Ahlen",
				"Suderbusch",
				"Altenfurth",
				"Breitenbrunn",
				"Grunbach",
				"Grunwasser",
				"Schmalfurth",
				"Grossfurth",
				"Grunkraut",
				"Schattenfluth",
				"Weissenbach",
				"Kaltenbach",
				"Tarsdorf",
				"Tiefenbach",
				"Julbach",
				"Auengrund",
				"Schwarzbrook",
				"Brookdorf",
				"Brookheim"
			],
			[
				"Stakendorf",
				"Schwartbuck",
				"Monkamp",
				"Sehlendorf",
				"Schwarzpfuhl",
				"Ehlerstorf",
				"Torfbruck",
				"Mohrdorf",
				"Streekmoor",
				"Kolkdorf",
				"Schwarzwasser",
				"Lauenbruck",
				"Farnheim",
				"Birkhain",
				"Ahlen",
				"Suderbusch",
				"Altenfurth",
				"Breitenbrunn",
				"Grunbach",
				"Grunwasser",
				"Schmalfurth",
				"Grossfurth",
				"Grunkraut",
				"Schattenfluth",
				"Weissenbach",
				"Kaltenbach",
				"Tarsdorf",
				"Tiefenbach",
				"Julbach",
				"Auengrund",
				"Schwarzbrook",
				"Brookdorf",
				"Brookheim"
			],
			[
				"Stakenland",
				"Sehlenstadt",
				"Schwarzland",
				"Ehelerstadt",
				"Streekland",
				"Grafenwasser",
				"Lauenstadt",
				"Ahlenstadt",
				"Grunstadt",
				"Austadt",
				"Muckenland",
				"Brookstadt",
				"Pfuhlstadt",
				"Schwarzmark",
				"Muckenmark",
				"Torfmark",
				"Fuhrtmark",
				"Schwartmark",
				"Tiefenmark",
				"Schwanenwasser",
				"Fletland",
				"Fennstedt",
				"Auenhausen",
				"Moorland",
				"Riedland",
				"Drakenstadt",
				"Schwarmstadt",
				"Niedermark"
			]
		];
		this.m.DraftLists = [
			[
				"beggar_background",
				"cultist_background",
				"cultist_background",
				"daytaler_background",
				"daytaler_background",

				"poacher_background",
				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"vagabond_background",
				"wildman_background",

				"cultist_background",
				"cultist_background",

				"poacher_background",
				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
			],
			[
				"beggar_background",
				"beggar_background",
				"cultist_background",
				"cultist_background",
				"daytaler_background",
				"daytaler_background",

				"graverobber_background",
				"historian_background",
				"killer_on_the_run_background",
				"militia_background",
				"militia_background",
				"poacher_background",
				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"thief_background",
				"vagabond_background",
				"wildman_background",


				"adventurous_noble_background",
				"disowned_noble_background",
				"cripple_background",
				"cultist_background",
				"cultist_background",

				"graverobber_background",
				"historian_background",
				"killer_on_the_run_background",
				"militia_background",
				"militia_background",
				"poacher_background",
				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",


				"cripple_background"
			],
			[
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"cultist_background",
				"cultist_background",
				"daytaler_background",


				"gravedigger_background",
				"graverobber_background",
				"historian_background",
				"juggler_background",
				"killer_on_the_run_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",



				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",


				"adventurous_noble_background",
				"bastard_background",
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






				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[






				"female_disowned_noble_background"
			]
		];
		this.m.StablesLists = [
			[],
			[],
			[]
		];

		// if (::Const.DLC.Unhold)
		// {
		// 	this.m.DraftLists[0].push("beast_hunter_background");
		// 	this.m.DraftLists[1].push("beast_hunter_background");
		// 	this.m.DraftLists[2].push("beast_hunter_background");
		// 	this.m.DraftLists[2].push("beast_hunter_background");
		// }

		this.m.Rumors = ::Const.Strings.RumorsSwampSettlement;
		this.m.ProduceString = "mushrooms";
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.m.Size >= 2 && ::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}

		if (::Math.rand(1, 100) <= 33)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				::Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			::Const.World.TerrainType.Swamp
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 2);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			::Const.World.TerrainType.Swamp
		], [], 1);
		this.buildAttachedLocation(::Math.rand(0, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			::Const.World.TerrainType.Swamp
		], [], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
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
		], 3, true);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (::Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Swamp,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Swamp
			]);
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

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			::Const.World.TerrainType.Swamp
		], []);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			::Const.World.TerrainType.Swamp
		], [], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
	}

});

