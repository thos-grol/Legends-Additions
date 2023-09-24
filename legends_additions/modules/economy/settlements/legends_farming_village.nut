::mods_hookExactClass("entity/world/settlements/legends_farming_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Weidefeld",
				"Hemmeln",
				"Saxdorf",
				"Kochendorf",
				"Altenhof",
				"Weidenau",
				"Schnellen",
				"Neudorf",
				"Freidorf",
				"Weissenhaus",
				"Muhlenheim",
				"Grunfelde",
				"Ivendorf",
				"Ohnemenschen",
				"Kornstadt",
				"Ausbeute",
				"Feldgehen",
				"Tierbauernhof",
				"Grafenheide",
				"Hermannshof",
				"Koppeldorf",
				"Meiding",
				"Varel",
				"Durbach",
				"Dreifelden",
				"Bockhorn",
				"Hufschlag",
				"Hage",
				"Wagenheim",
				"Harlingen",
				"Wiese",
				"Wiesendorf",
				"Markdorf",
				"Heuweiler",
				"Bitterfeld",
				"Neuenried",
				"Auenbach",
				"Adelshofen",
				"Allersdorf",
				"Brunnendorf",
				"Ochsenhausen",
				"Weingarten",
				"Konigsfeld",
				"Rosenhof",
				"Weidenbach"
			],
			[
				"Weidefeld",
				"Hemmeln",
				"Saxdorf",
				"Kochendorf",
				"Altenhof",
				"Schnellen",
				"Neudorf",
				"Freidorf",
				"Durbach",
				"Weissenhaus",
				"Muhlenheim",
				"Grunfelde",
				"Ivendorf",
				"Weidenau",
				"Grafenheide",
				"Hermannshof",
				"Koppeldorf",
				"Meiding",
				"Varel",
				"Dreifelden",
				"Bockhorn",
				"Hufschlag",
				"Hage",
				"Wagenheim",
				"Harlingen",
				"Wiese",
				"Wiesendorf",
				"Markdorf",
				"Heuweiler",
				"Bitterfeld"
			],
			[
				"Weidemark",
				"Hemmelmark",
				"Kochenland",
				"Altenstadt",
				"Schnellmark",
				"Neumark",
				"Freistadt",
				"Weissenstadt",
				"Muhlstadt",
				"Grunmark",
				"Ivenstadt",
				"Grafenstadt",
				"Konigsland",
				"Dreigrafen",
				"Koppelstadt",
				"Varelmark",
				"Hageland",
				"Dulmen",
				"Wiesenmark",
				"Heuland",
				"Auenmark",
				"Kornstadt",
				"Konigsheim",
				"Wedelmark",
				"Albstadt",
				"Kammersmark",
				"Adelsland",
				"Heldenland",
				"Dinkelsmark",
				"Schwanstadt",
				"Grunhain"
			]
		];
		this.m.DraftLists = [
			[
				"beggar_background",
				"daytaler_background",
				"daytaler_background",
				"farmhand_background",
				"farmhand_background",
				"farmhand_background",
				"farmhand_background",
				"miller_background",
				"miller_background",
				"ratcatcher_background",
				//"tailor_background",
				"vagabond_background",
				"poacher_background",
				"ratcatcher_background",
				"vagabond_background",
				"poacher_background"
			],
			[
				"apprentice_background",
				"beggar_background",
				"butcher_background",
				"gambler_background",
				"daytaler_background",
				"daytaler_background",
				"farmhand_background",
				"farmhand_background",
				"farmhand_background",
				"juggler_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"miller_background",
				"miller_background",

				"ratcatcher_background",
				"refugee_background",
				"servant_background",
				//"tailor_background",
				"vagabond_background",
				"retired_soldier_background",
				"apprentice_background",
				"butcher_background",
				"gambler_background",
				"juggler_background",
				"messenger_background",
				"militia_background",
				"militia_background",

				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"retired_soldier_background"
			],
			[

				"apprentice_background",
				"caravan_hand_background",
				"gambler_background",
				"historian_background",
				"juggler_background",
				"militia_background",
				"militia_background",



				"ratcatcher_background",
				"refugee_background",
				"shepherd_background",
				"vagabond_background",
				"bastard_background",
				"raider_background",
				"retired_soldier_background",
				"sellsword_background",



			]
		];
		this.m.FemaleDraftLists = [
			[
				
				
				
				
				
				
				
				
				
				
			],
			[
				
				
				
				
				
				
				
				
				
				
			],
			[
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				"female_adventurous_noble_background"
			]
		];
		this.m.StablesLists = [
			[

				"legend_donkey_background"
			],
			[



			],
			[



			]
		];
		this.m.Rumors = ::Const.Strings.RumorsFarmingSettlement;
	}

	o.getHousesMin = function()
	{
		switch(this.m.Size)
		{
		case 1:
			return 1;

		case 2:
			return 2;

		case 3:
			return 4;
		}

		return 1;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.Math.rand(1, 100) <= 25)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}
		else if (this.Math.rand(1, 100) <= 25)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			::Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
			::Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Plains
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 2, true);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wool_spinner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			]);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1);
		}

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			::Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/orchard_location", [
			::Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Plains
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3, true);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Const.World.Buildings.Fletchers == 0)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));
		}
		else if (this.Math.rand(1, 100) <= 50)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wool_spinner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wool_spinner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Plains
			], 1, true);
		}

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/wooden_watchtower_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 4, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/militia_trainingcamp_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
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

		this.buildAttachedLocation(this.Math.rand(1, 2), "scripts/entity/world/attached_location/wheat_fields_location", [
			::Const.World.TerrainType.Plains
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 2), "scripts/entity/world/attached_location/orchard_location", [
			::Const.World.TerrainType.Plains
		], [], 1);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
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

});

