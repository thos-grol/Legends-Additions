::mods_hookExactClass("entity/world/settlements/legends_swamp_village.nut", function(o) {
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
				"flagellant_background",
				"poacher_background",
				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"vagabond_background",
				"wildman_background",
				"witchhunter_background",
				"cultist_background",
				"cultist_background",
				"flagellant_background",
				"poacher_background",
				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
				"witchhunter_background"
			],
			[
				"beggar_background",
				"beggar_background",
				"cultist_background",
				"cultist_background",
				"daytaler_background",
				"daytaler_background",
				"flagellant_background",
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
				"witchhunter_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"disowned_noble_background",
				"cripple_background",
				"cultist_background",
				"cultist_background",
				"flagellant_background",
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
				"witchhunter_background",
				"witchhunter_background",
				"cripple_background"
			],
			[
				"brawler_background",
				"caravan_hand_background",
				"gambler_background",
				"cultist_background",
				"cultist_background",
				"daytaler_background",
				"flagellant_background",
				"flagellant_background",
				"gravedigger_background",
				"graverobber_background",
				"historian_background",
				"juggler_background",
				"killer_on_the_run_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",
				"minstrel_background",
				"monk_background",
				"peddler_background",
				"poacher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
				"witchhunter_background",
				"witchhunter_background",
				"adventurous_noble_background",
				"bastard_background",
				"hedge_knight_background",
				"retired_soldier_background",
				"sellsword_background",
				"swordmaster_background",
				"cripple_background",
				"eunuch_background",
				"legend_inventor_background"
			]
		];
		this.m.FemaleDraftLists = [
			[
				"wildwoman_background",
				"female_beggar_background",
				"female_daytaler_background",
				"female_daytaler_background"
			],
			[
				"wildwoman_background",
				"female_beggar_background",
				"female_beggar_background",
				"female_daytaler_background",
				"female_daytaler_background",
				"female_thief_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[
				"female_beggar_background",
				"female_beggar_background",
				"female_daytaler_background",
				"female_servant_background",
				"female_thief_background",
				"wildwoman_background",
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
			this.m.DraftLists[2].push("beast_hunter_background");
		}

		this.m.Rumors = this.Const.Strings.RumorsSwampSettlement;
		this.m.ProduceString = "mushrooms";
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Const.DLC.Unhold && (this.Const.World.Buildings.Taxidermists == 0 || this.Math.rand(1, 100) <= 33))
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		}
		else if (this.Math.rand(1, 100) <= 33)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], []);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/mushroom_grove_location", [
				this.Const.World.TerrainType.Swamp
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], []);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			this.Const.World.TerrainType.Swamp
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Swamp,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Forest,
			this.Const.World.TerrainType.AutumnForest,
			this.Const.World.TerrainType.LeaveForest,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [], 2);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Const.DLC.Unhold)
		{
			local r = this.Math.rand(1, 3);

			if (r == 1 || this.Const.World.Buildings.Taxidermists == 0)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
			}
			else if (r == 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/barber_building"));
			}
		}
		else
		{
			local r = this.Math.rand(1, 3);

			if (r <= 2)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
			}
			else if (r == 3)
			{
				this.addBuilding(this.new("scripts/entity/world/settlements/buildings/barber_building"));
			}
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			this.Const.World.TerrainType.Swamp
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			this.Const.World.TerrainType.Swamp
		], [], 2);
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
		], 3, true);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (this.Const.DLC.Unhold)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));
		}
		else if (this.Math.rand(1, 100) <= 80 || this.Const.World.Buildings.Barbers == 0)
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
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}

		if (this.Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/herbalists_grove_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Swamp
			]);
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

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/peat_pit_location", [
			this.Const.World.TerrainType.Swamp
		], []);
		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/mushroom_grove_location", [
			this.Const.World.TerrainType.Swamp
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Plains,
			this.Const.World.TerrainType.Steppe,
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], []);
	}

});

