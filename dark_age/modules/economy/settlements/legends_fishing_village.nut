::mods_hookExactClass("entity/world/settlements/legends_fishing_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Seedorf",
				"Kielseng",
				"Meierwik",
				"Fischschlachten",
				"Schiffdrucken",
				"Schiffbauen",
				"Nassort",
				"Sanddorf",
				"Sandwik",
				"Holnis",
				"Holmwik",
				"Niewik",
				"Hattlund",
				"Stohl",
				"Strande",
				"Sandkamp",
				"Sandberg",
				"Birkenstrand",
				"Sundheim",
				"Seekamp",
				"Krakendorf",
				"Blankwasser",
				"Harkensee",
				"Otterndorf",
				"Seefeld",
				"Horum",
				"Krumhorn",
				"Gothmund",
				"Angeln",
				"Sandholm",
				"Jadensee",
				"Egernsande",
				"Nebelheim",
				"Sudersande",
				"Grossenkoog",
				"Aalbek",
				"Seedeich"
			],
			[
				"Seedock",
				"Wikhavn",
				"Sandhoom",
				"Sandkai",
				"Holnishovn",
				"Holmwader",
				"Niewekai",
				"Stohlhoven",
				"Strandekai",
				"Kampwader",
				"Birkhaven",
				"Sundkajung",
				"Seehoben",
				"Krakenwader",
				"Blankhoom",
				"Harkendock",
				"Krumwader",
				"Saltkai",
				"Salthaven",
				"Grotenhoom",
				"Lutendock",
				"Kaiwader",
				"Singhoben",
				"Weissenhaven",
				"Tiefenhaven",
				"Wasserkoog",
				"Osterstrande",
				"Steinhaven",
				"Duhnenhaven",
				"Neudeich",
				"Sandehaven"
			],
			[
				"Seestadt",
				"Wikstadt",
				"Konigshaven",
				"Grafenhaven",
				"Holnisland",
				"Nieweland",
				"Kampstadt",
				"Krakenland",
				"Blankenstadt",
				"Harkenstadt",
				"Tiefenstadt",
				"Weissenstadt",
				"Kobmanhaven",
				"Grotenhaven",
				"Konigswasser",
				"Konigsmunde",
				"Kronenkoog",
				"Steinkai",
				"Deichstadt"
			]
		];
		this.m.DraftLists = [
			[
				"beggar_background",
				"beggar_background",
				"daytaler_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",

				//"tailor_background",
				"vagabond_background",
				"vagabond_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",

				"vagabond_background",
				"vagabond_background"
			],
			[
				"apprentice_background",
				"beggar_background",
				"beggar_background",
				"brawler_background",
				"caravan_hand_background",
				"daytaler_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",
				"graverobber_background",
				"historian_background",
				"juggler_background",
				"killer_on_the_run_background",
				"messenger_background",
				"militia_background",



				"ratcatcher_background",
				"refugee_background",
				"servant_background",
				//"tailor_background",
				"thief_background",
				"vagabond_background",
				"cripple_background",
				"eunuch_background",
				"sellsword_background",
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",
				"graverobber_background",
				"historian_background",
				"juggler_background",
				"killer_on_the_run_background",
				"messenger_background",
				"militia_background",



				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"cripple_background",
				"eunuch_background",
				"sellsword_background"
			],
			[
				"apprentice_background",
				"brawler_background",
				"caravan_hand_background",
				"caravan_hand_background",
				"gambler_background",
				"cultist_background",
				"fisherman_background",
				"fisherman_background",
				"fisherman_background",
				"gravedigger_background",
				"graverobber_background",
				"historian_background",
				"juggler_background",
				"killer_on_the_run_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",


				"cripple_background",
				"eunuch_background",


				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"bastard_background",
				"raider_background",
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










				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			]
		];
		this.m.StablesLists = [
			[],
			[],
			[]
		];
		this.m.Rumors = ::Const.Strings.RumorsFishingSettlement;
		this.m.ProduceString = "fish";
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
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/port_building"), 3);

		if (this.m.Size >= 2 && ::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}

		if (::Math.rand(1, 100) <= 20)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			::Const.World.TerrainType.Shore
		], [
			::Const.World.TerrainType.Ocean,
			::Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fishing_huts_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/amber_collector_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		], 1);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/port_building"), 3);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (::Math.rand(1, 100) <= 66) if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/harbor_location", [
			::Const.World.TerrainType.Shore
		], [
			::Const.World.TerrainType.Ocean,
			::Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		], 1, true);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/amber_collector_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		], 2);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 1, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 2);
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
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/port_building"), 3);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));

		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (::Math.rand(1, 100) <= 50)
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

		if (::Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/amber_collector_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Tundra
			], [], 2);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/amber_collector_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Shore
			], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [], 1, true);
		}

		this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
			::Const.World.TerrainType.Shore
		], [
			::Const.World.TerrainType.Ocean,
			::Const.World.TerrainType.Shore
		], -1, false, false);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/fishing_huts_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Shore
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 3);
	}

});

