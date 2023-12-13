::mods_hookExactClass("entity/world/settlements/legends_tundra_fort", function(o) {
	o.create = function()
	{
		this.legends_fort.create();
		this.m.Names = [
			[
				"Tonderwold",
				"Hornwold",
				"Grimtorn",
				"Helleweir",
				"Kalkweir",
				"Lyderswold",
				"Hornspira",
				"Sommerspira",
				"Brammingwold",
				"Vardegard",
				"Norrewold",
				"Birketorn",
				"Donnerswold",
				"Tangweir",
				"Helviktorn",
				"Torvastorn",
				"Skjoldwold",
				"Eidsviktorn",
				"Halspira",
				"Gerwold",
				"Gunnspira",
				"Asentorn",
				"Hammarwold",
				"Holmwold",
				"Eidarswold",
				"Skallewold",
				"Knorrespira",
				"Linderstorn",
				"Neidspira",
				"Bredaswold"
			],
			[
				"Tonderhovel",
				"Horngard",
				"Grimhaug",
				"Hellehovel",
				"Kalkhovel",
				"Lydersgard",
				"Homsgard",
				"Sommersholm",
				"Brammingholm",
				"Vardegard",
				"Norreholm",
				"Birkehovel",
				"Donnersgard",
				"Tanghaug",
				"Helvikholm",
				"Torvaholm",
				"Skjoldgard",
				"Eidsvikholm",
				"Halshovel",
				"Gerholm",
				"Gunnholm",
				"Asengard",
				"Hammargard",
				"Vikeholm",
				"Skandergard",
				"Skallegard",
				"Varehaug",
				"Gufirsgard",
				"Hafnarsholm",
				"Ragnhaug",
				"Torgeirsholm",
				"Heersgard",
				"Holmhaug",
				"Lundirsholm"
			],
			[
				"Tonderborg",
				"Hornborg",
				"Grimborg",
				"Helleborg",
				"Kalkborg",
				"Lydersborg",
				"Homsborg",
				"Sommersborg",
				"Brammingborg",
				"Vardeborg",
				"Norreborg",
				"Birkeborg",
				"Donnersborg",
				"Tangborg",
				"Helvikborg",
				"Torvaborg",
				"Skjoldborg",
				"Eidsvikborg",
				"Halsborg",
				"Gerborg",
				"Gunnborg",
				"Asenborg",
				"Hammarborg",
				"Skagaborg",
				"Selasborg",
				"Haellborg",
				"Kampaborg",
				"Gufarsborg",
				"Husnarborg",
				"Reistarborg",
				"Geirborg"
			]
		];
		this.m.DraftLists = [
			[
				"apprentice_background",

				"militia_background",
				"militia_background",
				"miner_background",
				"vagabond_background",
				
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"retired_soldier_background",
				"retired_soldier_background"
			],
			[

				"brawler_background",
				"gravedigger_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",
				"vagabond_background",
				

				"bastard_background",
				"deserter_background",
				"deserter_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background"
			],
			[
				"apprentice_background",
				"brawler_background",
				"brawler_background",
				"brawler_background",
				"gambler_background",
				"cultist_background",
				"gravedigger_background",
				"graverobber_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",

				"ratcatcher_background",
				"refugee_background",
				"shepherd_background",
				"shepherd_background",
				"vagabond_background",
				
				

				"bastard_background",
				"bastard_background",
				"deserter_background",
				"deserter_background",
				"raider_background",
				"retired_soldier_background",
				"sellsword_background",
				"sellsword_background",


				"cripple_background",
				"eunuch_background",

			]
		];
		this.m.FemaleDraftLists = [
			[
				"legend_shieldmaiden_background",
				
			],
			[
				"legend_shieldmaiden_background",

				
				

				"female_disowned_noble_background"
			],
			[
				"legend_shieldmaiden_background",
				

				
				
				

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
		this.m.Rumors = ::Const.Strings.RumorsTundraSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		local r = this.Math.rand(1, 2);
		if (r == 1)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], []);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [
			::Const.World.TerrainType.Tundra
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
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));

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

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], [], 1, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/herbalists_grove_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Swamp,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Forest,
			::Const.World.TerrainType.AutumnForest,
			::Const.World.TerrainType.SnowyForest,
			::Const.World.TerrainType.LeaveForest,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [], 2);
	}

	o.onBuildThree = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

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
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/training_hall_building"));
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/fletcher_building"));
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", ALL, [], 0, false, true, true);
			return;
		}

		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (this.Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 30)
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

		if (this.Math.rand(1, 100) <= 70)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/pig_farm_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/brewery_location", [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], [], 1);
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
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
		this.buildAttachedLocation(this.Math.rand(1, 1), "scripts/entity/world/attached_location/workshop_location", [
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Hills
		], []);
	}

});

