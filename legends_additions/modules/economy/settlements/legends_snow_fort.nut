::mods_hookExactClass("entity/world/settlements/legends_snow_fort", function(o) {
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
				"Holmgard",
				"Vallgard",
				"Falkenholm",
				"Glommenwold",
				"Gunnweir",
				"Asatorn",
				"Kungswold",
				"Hagenswold",
				"Lindweir",
				"Hindaswolt",
				"Lokewold",
				"Ringwold",
				"Hakonswold"
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
				"Gunhall",
				"Asaholm",
				"Grimmarsholm",
				"Hjalsgard",
				"Kungenshovel",
				"Wallhovel"
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
				"Snekkborg",
				"Groneborg",
				"Ramborg",
				"Vineborg",
				"Hunneborg",
				"Varborg",
				"Kungsborg",
				"Jarlsborg"
			]
		];
		this.m.DraftLists = [
			[
				
				"brawler_background",
				"cultist_background",
				"mason_background",
				"militia_background",
				"militia_background",
				"vagabond_background",
				"wildman_background",
				
				"deserter_background",
				"deserter_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",
				
				"brawler_background",
				"brawler_background",
				"cultist_background",
				"gravedigger_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"miner_background",
				
				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
				
				"deserter_background",
				"raider_background",
				"retired_soldier_background"
			],
			[
				"apprentice_background",
				"brawler_background",
				"gravedigger_background",
				"graverobber_background",
				"mason_background",
				"messenger_background",
				"militia_background",
				"militia_background",
				"militia_background",
				"ratcatcher_background",
				"refugee_background",
				"vagabond_background",
				"vagabond_background",
				"wildman_background",
				"wildman_background",
				
				
				"deserter_background",
				"deserter_background",
				"hedge_knight_background",
				"hedge_knight_background",
				"raider_background",
				"raider_background",
				"raider_background",
				"retired_soldier_background",
				"retired_soldier_background",
				"sellsword_background",
				
				"cripple_background"
			]
		];
		this.m.FemaleDraftLists = [
			[
				"female_beggar_background"
			],
			[
				"female_daytaler_background",
				"wildwoman_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background"
			],
			[
				"female_daytaler_background",
				"female_servant_background",
				"wildwoman_background",
				"female_adventurous_noble_background",
				"female_disowned_noble_background",
				"female_disowned_noble_background",
				"legend_shieldmaiden_background"
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

		// if (this.Const.DLC.Unhold)
		// {
		// 	this.m.DraftLists[0].push("beast_hunter_background");
		// 	this.m.DraftLists[1].push("beast_hunter_background");
		// 	this.m.DraftLists[2].push("beast_hunter_background");
		// }

		this.m.Rumors = this.Const.Strings.RumorsSnowSettlement;
	}

	o.onBuildOne = function( _settings )
	{
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/marketplace_building"), 2);

		local r = this.Math.rand(1, 2);
		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		}


		if (this.Math.rand(1, 100) <= 50)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 0, false, true);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/gatherers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 0, false, true);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.LeaveForest
			], 0, false, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/gatherers_hut_location", [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Tundra
			], [], 0, false, true);
		}

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/surface_iron_vein_location", [
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Snow
		], []);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/leather_tanner_location", [
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Snow
		], []);
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

		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else if (r == 2)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
		}

		if (this.Math.rand(1, 100) <= 70)
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

		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Hills
		], [], 2, false, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Hills
		], [], 2);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
			this.Const.World.TerrainType.Tundra,
			this.Const.World.TerrainType.Hills
		], [], 1, true);
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
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_location", ALL, [], 5, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fortified_outpost_location", ALL, [], 1, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/fletchers_hut_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/trapper_location", ALL, [], 0, false, true, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/hunters_cabin_location", ALL, [], 0, false, true, true);
			return;
		}

		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/armorsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/weaponsmith_building"));
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/training_hall_building"));

		if (this.Math.rand(1, 100) <= 60)
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/tavern_building"));
		}
		else
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));
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

		if (this.Math.rand(1, 100) <= 40)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/trapper_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills
			], [], 2);
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills
			], [], 1);
		}
		else
		{
			this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/trapper_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills
			], [], 2);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/workshop_location", [
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Hills
			], [], 1);
		}

		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/ore_smelters_location", [
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills,
			this.Const.World.TerrainType.Tundra
		], [
			this.Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(1, "scripts/entity/world/attached_location/blast_furnace_location", [
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills
		], [
			this.Const.World.TerrainType.Tundra
		]);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/hunters_cabin_location", [
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills
		], [], 0, false, true);
		this.buildAttachedLocation(this.Math.rand(0, 1), "scripts/entity/world/attached_location/fletchers_hut_location", [
			this.Const.World.TerrainType.Snow,
			this.Const.World.TerrainType.Hills
		], [], 0, false, true);
	}

});

