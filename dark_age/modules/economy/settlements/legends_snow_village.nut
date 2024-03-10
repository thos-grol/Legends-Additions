::mods_hookExactClass("entity/world/settlements/legends_snow_village", function(o) {
	o.create = function()
	{
		this.legends_village.create();
		this.m.Names = [
			[
				"Tonder",
				"Lydersholm",
				"Kravlund",
				"Bola",
				"Ravestad",
				"Gammeljord",
				"Tabtmennesker",
				"Morktoppe",
				"Lysdal",
				"Narredod",
				"Forsvinde",
				"Alsliv",
				"Hellevad",
				"Heimstad",
				"Hornheim",
				"Jerstal",
				"Hejsager",
				"Kalk",
				"Sommerstad",
				"Horn",
				"Bramming",
				"Varde",
				"Norre",
				"Vistadt",
				"Olbing",
				"Grimstad",
				"Birkeland",
				"Donnerstad",
				"Tangvall",
				"Helvik",
				"Ogna",
				"Norheim",
				"Undheim",
				"Torvastad",
				"Skjold",
				"Eidsvik",
				"Halheim",
				"Gerheim",
				"Asenstad",
				"Gunnheim",
				"Hammar",
				"Bullarsby",
				"Lonneberg"
			],
			[
				"Tonder",
				"Lydersholm",
				"Kravlund",
				"Bola",
				"Ravestad",
				"Alsliv",
				"Hellevad",
				"Heimstad",
				"Hornheim",
				"Jerstal",
				"Hejsager",
				"Kalk",
				"Sommerstad",
				"Horn",
				"Bramming",
				"Varde",
				"Norre",
				"Vistadt",
				"Olbing",
				"Grimstad",
				"Birkeland",
				"Donnerstad",
				"Tangvall",
				"Helvik",
				"Ogna",
				"Norheim",
				"Undheim",
				"Torvastad",
				"Skjold",
				"Eidsvik",
				"Halheim",
				"Gerheim",
				"Asenstad",
				"Gunnheim",
				"Hammar"
			],
			[
				"Tondersted",
				"Jarlsted",
				"Lydersted",
				"Bolasted",
				"Ravested",
				"Hellested",
				"Hornsted",
				"Hejsted",
				"Sommersted",
				"Brammingsted",
				"Vardested",
				"Norrested",
				"Grimsted",
				"Ognasted",
				"Eidsted",
				"Gersted",
				"Asested",
				"Gunnsted",
				"Hammarsted",
				"Arsasted",
				"Rollarsted",
				"Skagensted",
				"Harkensted",
				"Agersted",
				"Svarrested",
				"Ovarsted"
			]
		];
		this.m.DraftLists = [
			[
				"beggar_background",
				"brawler_background",
				"brawler_background",
				
				"daytaler_background",
				"lumberjack_background",
				
				"miner_background",

				"poacher_background",
				"thief_background",
				
				"wildman_background",
				"wildman_background",
				"brawler_background",
				"brawler_background",
				
				"lumberjack_background",
				
				"miner_background",

				"poacher_background",
				
				"wildman_background",
				"wildman_background"
			],
			[
				"apprentice_background",
				"brawler_background",
				"brawler_background",
				
				"daytaler_background",
				"daytaler_background",
				
				
				"graverobber_background",
				"hunter_background",
				"killer_on_the_run_background",
				"lumberjack_background",
				"militia_background",
				"miner_background",

				"poacher_background",
				"poacher_background",
				"poacher_background",
				"thief_background",
				
				"wildman_background",
				"disowned_noble_background",
				"cripple_background",
				"apprentice_background",
				"brawler_background",
				"brawler_background",
				
				
				
				"graverobber_background",
				"hunter_background",
				"killer_on_the_run_background",
				"lumberjack_background",
				"militia_background",
				"miner_background",

				"poacher_background",
				"poacher_background",
				"poacher_background",
				
				"wildman_background",
				"wildman_background",
				"cripple_background"
			],
			[
				"apprentice_background",
				"brawler_background",
				"brawler_background",
				"brawler_background",
				
				
				
				
				"graverobber_background",
				"killer_on_the_run_background",
				
				
				"militia_background",
				"militia_background",
				"militia_background",


				"poacher_background",
				"poacher_background",
				"poacher_background",
				
				
				"wildman_background",
				"wildman_background",

				"bastard_background",
				
			]
		];
		this.m.FemaleDraftLists = [
			[



			],
			[




				"female_disowned_noble_background"
			],
			[
				"legend_shieldmaiden_background",








				"female_adventurous_noble_background",
				"female_disowned_noble_background",
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
		// }

		this.m.Rumors = ::Const.Strings.RumorsSnowSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		if (this.m.Size >= 2 && ::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/blackmarket_building"));
		}

		if (::Math.rand(1, 100) <= 30)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (::Math.rand(1, 100) <= 30)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 0, false, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
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
			], [], 0, false, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Forest,
				::Const.World.TerrainType.SnowyForest,
				::Const.World.TerrainType.AutumnForest,
				::Const.World.TerrainType.LeaveForest
			], 0, false, true);
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
			], [], 0, false, true);
		}

		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Snow
		], [
			::Const.World.TerrainType.Snow >= 2
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
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
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/wooden_watchtower_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Snow,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], [
			::Const.World.TerrainType.Tundra
		], 3, true);
	}

	o.onBuildTwo = function( _settings )
	{
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/tavern_building"));
		local r = ::Math.rand(1, 2);

		if (r == 1)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}
		else if (r == 2)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Snow,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Tundra
			], [
				::Const.World.TerrainType.Tundra,
				::Const.World.TerrainType.Hills
			], 1);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/leather_tanner_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Tundra
			], [], 1);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Snow
		], [
			::Const.World.TerrainType.Tundra
		]);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			::Const.World.TerrainType.Plains,
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra
		], []);
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

		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (::Math.rand(1, 100) <= 50)
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else
		{
			if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}

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

		if (::Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Snow
			], [], 1, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/blast_furnace_location", [
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Snow
			], [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
				::Const.World.TerrainType.Snow
			], [], 1, true);
		}

		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/trapper_location", [
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Tundra,
			::Const.World.TerrainType.Snow
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			::Const.World.TerrainType.Snow
		], [], 1, false, true);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/surface_copper_vein_location", [
			::Const.World.TerrainType.Hills,
			::Const.World.TerrainType.Snow
		], [], 1, true);
	}

});

