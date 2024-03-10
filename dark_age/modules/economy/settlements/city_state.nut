::mods_hookExactClass("entity/world/settlements/city_state", function(o) {
	o.create = function()
	{
		this.settlement.create();
		this.m.Name = this.getRandomName([
			"ORIENTAL CITY #1",
			"ORIENTAL CITY #2",
			"ORIENTAL CITY #3"
		]);
		this.m.FemaleDraftList = [];
		this.m.DraftList = [
			"daytaler_southern_background",
			"daytaler_southern_background",
			"daytaler_southern_background",
			"daytaler_southern_background",
			"daytaler_southern_background",
			"daytaler_southern_background",
			"daytaler_southern_background",
			"daytaler_southern_background",

			"butcher_southern_background",
			"butcher_southern_background",

			"thief_southern_background",
			"thief_southern_background",

			"beggar_southern_background",
			"beggar_southern_background",
			"cripple_southern_background",
			"cripple_southern_background",

			"slave_background",
			"slave_background",
			"slave_southern_background",
			"slave_southern_background",

			"juggler_southern_background",
			"historian_southern_background",
			"disowned_noble_background",
		];

		this.m.UIDescription = "A large and rich city state that thrives on trade at the edge of the desert";
		this.m.Description = "A large and rich city state that thrives on trade at the edge of the desert.";
		this.m.UIBackgroundCenter = "ui/settlements/desert_stronghold_03";
		this.m.UIBackgroundLeft = "ui/settlements/desert_bg_houses_03_left";
		this.m.UIBackgroundRight = "ui/settlements/desert_bg_houses_03_right";
		this.m.UIRampPathway = "ui/settlements/desert_ramp_01_cobblestone";
		this.m.UISprite = "ui/settlement_sprites/citystate_01.png";
		this.m.Sprite = "world_city_01";
		this.m.Lighting = "world_city_01_light";
		this.m.Rumors = ::Const.Strings.RumorsDesertSettlement;
		this.m.Culture = ::Const.World.Culture.Southern;
		this.m.IsMilitary = false;
		this.m.Size = 3;
		this.m.HousesType = 4;
		this.m.HousesMin = 4;
		this.m.HousesMax = 6;
		this.m.AttachedLocationsMax = 6;
	}

	o.onBuild = function( _settings = null )
	{
		local myTile = this.getTile();
		local tiles = [
			myTile
		];
		local mapGen = this.MapGen.get(::Const.World.TerrainScript[::Const.World.TerrainType.Oasis]);
		myTile.Type = ::Const.World.TerrainType.Oasis;

		for( local i = 0; i < 6; i = i )
		{
			local nextTile = myTile.getNextTile(i);

			if (nextTile.Type == ::Const.World.TerrainType.Desert)
			{
				tiles.push(nextTile);
			}

			for( local j = 0; j < 6; j = j )
			{
				local veryNextTile = nextTile.getNextTile(i);

				if (veryNextTile.Type == ::Const.World.TerrainType.Desert && ::Math.rand(1, 100) <= 66)
				{
					tiles.push(veryNextTile);
				}

				j = ++j;
			}

			i = ++i;
		}

		foreach( tile in tiles )
		{
			tile.Type = 0;
			tile.clear();
			mapGen.fill({
				X = tile.SquareCoords.X,
				Y = tile.SquareCoords.Y,
				W = 1,
				H = 1,
				IsEmpty = false
			}, null);
		}

		for( local x = myTile.SquareCoords.X - 3; x < myTile.SquareCoords.X + 3; x = x )
		{
			for( local y = myTile.SquareCoords.Y - 3; y < myTile.SquareCoords.Y + 3; y = y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Mountains)
				{
				}
				else
				{
					tile.clear();
					this.MapGen.get(::Const.World.TerrainScript[tile.Type]).fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = false
					}, null, 2);
				}

				y = ++y;
			}

			x = ++x;
		}

		for( local x = myTile.SquareCoords.X - 3; x < myTile.SquareCoords.X + 3; x = x )
		{
			for( local y = myTile.SquareCoords.Y - 3; y < myTile.SquareCoords.Y + 3; y = y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Mountains)
				{
				}
				else
				{
					this.MapGen.get(::Const.World.TerrainScript[tile.Type]).fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = false
					}, null, 3);
				}

				y = ++y;
			}

			x = ++x;
		}

		this.addBuilding(::new("scripts/entity/world/settlements/buildings/crowd_oriental_building"), 5);
		this.addBuilding(::new("scripts/entity/world/settlements/buildings/marketplace_oriental_building"), 2);
		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/alchemist_building"));
		local w = 0;
		local a = 0;

		for( local i = 0; i < 2; i = i )
		{
			if (::Const.World.Buildings.Arenas == 0)
			{
				if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/arena_building"));
			}
			else if (::Const.World.Buildings.WeaponsmithsOriental == 0)
			{
				if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_oriental_building"));
				w = ++w;
				w = w;
			}
			else if (::Const.World.Buildings.ArmorsmithsOriental == 0)
			{
				if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_oriental_building"));
				a = ++a;
				a = a;
			}
			else if (w == 0 && (a != 0 || ::Math.rand(1, 100) <= 50))
			{
				if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/weaponsmith_oriental_building"));
				w = ++w;
				w = w;
			}
			else
			{
				if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/armorsmith_oriental_building"));
				a = ++a;
				a = a;
			}

			i = ++i;
		}

		if (hasFreeBuildingSlot()) this.addBuilding(::new("scripts/entity/world/settlements/buildings/temple_oriental_building"));

		if (::Math.rand(1, 100) <= 60)
		{
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/stone_watchtower_oriental_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Desert
			], [], 4, true);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/militia_trainingcamp_oriental_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Desert
			], [], 1, true);
		}
		else
		{
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/stone_watchtower_oriental_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Desert
			], [], 4, true);
			this.buildAttachedLocation(1, "scripts/entity/world/attached_location/militia_trainingcamp_oriental_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Hills,
				::Const.World.TerrainType.Desert
			], [], 1, true);
		}

		if (this.m.IsCoastal)
		{
			this.buildAttachedLocation(2, "scripts/entity/world/attached_location/harbor_location", [
				::Const.World.TerrainType.Shore
			], [
				::Const.World.TerrainType.Ocean,
				::Const.World.TerrainType.Shore
			], -1, false, false);
			this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/fishing_huts_oriental_location", [
				::Const.World.TerrainType.Plains,
				::Const.World.TerrainType.Steppe,
				::Const.World.TerrainType.Desert,
				::Const.World.TerrainType.Oasis
			], [
				::Const.World.TerrainType.Shore
			]);
		}

		local settlements = this.World.EntityManager.getSettlements();
		local n = 0;

		foreach( s in settlements )
		{
			if (s.isSouthern())
			{
				n = ++n;
				n = n;

				if (s.getID() == this.getID())
				{
					break;
				}
			}
		}

		this.buildAttachedLocation(::Math.rand(n == 1 ? 2 : 0, n == 1 ? 2 : 1), "scripts/entity/world/attached_location/incense_dryer_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis
		], []);
		this.buildAttachedLocation(::Math.rand(n == 2 ? 2 : 0, n == 2 ? 2 : 1), "scripts/entity/world/attached_location/silk_farm_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis
		], []);
		this.buildAttachedLocation(::Math.rand(n == 3 ? 2 : 0, n == 3 ? 2 : 1), "scripts/entity/world/attached_location/plantation_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis
		], []);
		this.buildAttachedLocation(::Math.rand(0, 1), "scripts/entity/world/attached_location/dye_maker_oriental_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis
		], [
			::Const.World.TerrainType.Hills
		]);
		this.buildAttachedLocation(::Math.rand(1, 2), "scripts/entity/world/attached_location/goat_herd_oriental_location", [
			::Const.World.TerrainType.Steppe,
			::Const.World.TerrainType.Desert,
			::Const.World.TerrainType.Oasis
		], []);
	}

});
