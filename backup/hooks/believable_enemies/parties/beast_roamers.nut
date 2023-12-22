::mods_hookExactClass("factions/actions/send_beast_roamers_action", function(o) {
    o.create = function()
	{
		this.m.ID = "send_beast_roamers_action";
		this.m.Cooldown = 5.0;
		this.faction_action.create();
		local distanceToNextAlly = 10;
		local beast;
		beast = function ( _action, _nearTile = null )
		{
			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if (i == ::Const.World.TerrainType.Forest || i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 50, 1000, 3, 0, _nearTile, 0.2);

			if (tile == null)
			{
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			{
				return false;
			}

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
			local party = _action.getFaction().spawnEntity(tile, "Direwolves", false, ::Const.World.Spawn.Direwolves, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
			party.setFootprintType(::Const.World.FootprintsType.Direwolves);
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Forest, true);
			roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
			roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
			roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
			roam.setTerrain(::Const.World.TerrainType.Hills, true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsLow.push(beast);

		if (::Const.DLC.Desert)
		{
			beast = function ( _action, _nearTile = null )
			{
				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Desert || i == ::Const.World.TerrainType.Oasis || i == ::Const.World.TerrainType.Hills)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 50, 1000, 3, 0, _nearTile, 0.0, 0.2);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Hyenas", false, ::Const.World.Spawn.Hyenas, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A pack of esurient hyenas on the hunt for prey.");
				party.setFootprintType(::Const.World.FootprintsType.Hyenas);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Desert, true);
				roam.setTerrain(::Const.World.TerrainType.Oasis, true);
				roam.setTerrain(::Const.World.TerrainType.Steppe, true);
				roam.setTerrain(::Const.World.TerrainType.Hills, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsLow.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 15 && _nearTile == null)
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Desert || i == ::Const.World.TerrainType.Oasis)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 50, 1000, 3, 0, _nearTile, 0.0, 0.2);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Serpents", false, ::Const.World.Spawn.Serpents, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("Giant serpents slithering about.");
				party.setFootprintType(::Const.World.FootprintsType.Serpents);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Desert, true);
				roam.setTerrain(::Const.World.TerrainType.Oasis, true);
				roam.setTerrain(::Const.World.TerrainType.Steppe, true);
				roam.setTerrain(::Const.World.TerrainType.Hills, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
		}

		if (::Const.DLC.Unhold)
		{
			beast = function ( _action, _nearTile = null )
			{
				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Forest || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 40, 1000, 3, 0, _nearTile, ::Const.DLC.Desert ? 0.2 : 0.1, 0.8);

				if (tile == null) return false;
				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2)) return false;

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Webknechts", false, ::Const.World.Spawn.Spiders, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A swarm of webknechts skittering about.");
				party.setFootprintType(::Const.World.FootprintsType.Spiders);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsWebknechts", true);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Forest, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
				roam.setMinRange(1);
				roam.setMaxRange(4);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsLow.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 10 && _nearTile == null)
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Tundra || i == ::Const.World.TerrainType.Hills || i == ::Const.World.TerrainType.Mountains)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 10 - (_nearTile == null ? 0 : 2), 100, 1000, 3, 0, _nearTile, 0.0, 0.9);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Unhold", false, ::Const.World.Spawn.Unhold, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("One or more lumbering giants.");
				party.setFootprintType(::Const.World.FootprintsType.Unholds);
				party.setSlowerAtNight(true);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsUnholds", true);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Forest, true);
				roam.setTerrain(::Const.World.TerrainType.Hills, true);
				roam.setTerrain(::Const.World.TerrainType.Tundra, true);
				roam.setTerrain(::Const.World.TerrainType.Mountains, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 10 && _nearTile == null)
				{
					return false;
				}

				local isTundraAllowed = ::Math.rand(1, 100) <= 20;
				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Snow || i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.Tundra && isTundraAllowed)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 5, 100, 1000, 3, 0, _nearTile, 0.7);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Unhold", false, ::Const.World.Spawn.UnholdFrost, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("One or more lumbering giants.");
				party.setFootprintType(::Const.World.FootprintsType.Unholds);
				party.setSlowerAtNight(true);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsUnholds", true);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Snow, true);
				roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
				roam.setTerrain(::Const.World.TerrainType.Hills, true);

				if (isTundraAllowed)
				{
					roam.setTerrain(::Const.World.TerrainType.Tundra, true);
				}

				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 10 && _nearTile == null)
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Swamp || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.Oasis)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 10 - (_nearTile == null ? 0 : 2), 100, 1000, 3, 0, _nearTile);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Unhold", false, ::Const.World.Spawn.UnholdBog, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("One or more lumbering giants.");
				party.setFootprintType(::Const.World.FootprintsType.Unholds);
				party.setSlowerAtNight(true);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsUnholds", true);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Swamp, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (_nearTile == null && ::Math.rand(1, 100) <= 25)
				{
					return false;
				}

				if (this.World.getTime().Days < 15 && _nearTile == null)
				{
					return false;
				}

				local tile = _action.getTileToSpawnLocation(10, [
					::Const.World.TerrainType.Mountains,
					::Const.World.TerrainType.Forest,
					::Const.World.TerrainType.LeaveForest,
					::Const.World.TerrainType.AutumnForest,
					::Const.World.TerrainType.SnowyForest,
					::Const.World.TerrainType.Swamp,
					::Const.World.TerrainType.Hills
				], 7, 35, 1000, 3, 0, _nearTile);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

				if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
				{
					distanceToNextSettlement = distanceToNextSettlement * 2;
				}

				local party = _action.getFaction().spawnEntity(tile, "Alps", false, ::Const.World.Spawn.Alps, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("Pale and haggard creatures creeping around.");
				party.setFootprintType(::Const.World.FootprintsType.Alps);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsAlps", true);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setAllTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Mountains, false);
				roam.setTerrain(::Const.World.TerrainType.Ocean, false);
				roam.setTerrain(::Const.World.TerrainType.Shore, false);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 20 && _nearTile == null)
				{
					return false;
				}

				if (_nearTile == null && ::Math.rand(1, 100) <= 10)
				{
					return false;
				}

				local tile = _action.getTileToSpawnLocation(10, [
					::Const.World.TerrainType.Mountains,
					::Const.World.TerrainType.Hills,
					::Const.World.TerrainType.Snow,
					::Const.World.TerrainType.SnowyForest,
					::Const.World.TerrainType.Desert,
					::Const.World.TerrainType.Oasis
				], 8, 50, 1000, 3, 0, _nearTile, 0.1, 0.9);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

				if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
				{
					distanceToNextSettlement = distanceToNextSettlement * 2;
				}

				local party = _action.getFaction().spawnEntity(tile, "Hexen", false, ::Const.World.Spawn.HexenAndMore, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A malevolent old crone, said to lure and abduct little children to make broth and concoctions out of, strike sinister pacts with villagers, and weave curses.");
				party.setFootprintType(::Const.World.FootprintsType.Hexen);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setAllTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Mountains, false);
				roam.setTerrain(::Const.World.TerrainType.Ocean, false);
				roam.setTerrain(::Const.World.TerrainType.Shore, false);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 25 && _nearTile == null)
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Forest || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 20 - (_nearTile == null ? 0 : 11), 100, 1000, 3, 0, _nearTile, 0.1, 0.9);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

				if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
				{
					distanceToNextSettlement = distanceToNextSettlement * 2;
				}

				local party = _action.getFaction().spawnEntity(tile, "Schrats", false, ::Const.World.Spawn.Schrats, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A creature of bark and wood, blending between trees and shambling slowly, its roots digging through the soil.");
				party.setFootprintType(::Const.World.FootprintsType.Schrats);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Forest, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
				roam.setMinRange(1);
				roam.setMaxRange(4);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsHigh.push(beast);
			beast = function ( _action, _nearTile = null )
			{
				if (!this.World.Flags.get("IsKrakenDefeated"))
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Swamp)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 25, 1000, 1000, 3, 0, _nearTile);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly)
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

				if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
				{
					distanceToNextSettlement = distanceToNextSettlement * 2;
				}

				local party = _action.getFaction().spawnEntity(tile, "Kraken", false, ::Const.World.Spawn.Kraken, 1000);
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A tentacled horror from another age.");
				party.setFootprintType(::Const.World.FootprintsType.Kraken);
				party.setSlowerAtNight(true);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Swamp, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
		}

		if (::Const.DLC.Desert)
		{
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 20 && _nearTile == null)
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Desert || i == ::Const.World.TerrainType.Oasis || i == ::Const.World.TerrainType.Hills)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 16 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile, 0.0, 0.2);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Ifrits", false, ::Const.World.Spawn.SandGolems, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("Creatures of living stone shaped by the blistering heat and fire of the burning sun of the south.");
				party.setFootprintType(::Const.World.FootprintsType.SandGolems);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Desert, true);
				roam.setTerrain(::Const.World.TerrainType.Oasis, true);
				roam.setTerrain(::Const.World.TerrainType.Hills, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
		}

		if (::Const.DLC.Lindwurm)
		{
			beast = function ( _action, _nearTile = null )
			{
				if (this.World.getTime().Days < 25 && _nearTile == null)
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Steppe || i == ::Const.World.TerrainType.Desert)
					{
					}
					else
					{
						disallowedTerrain.push(i);
					}

					i = ++i;
				}

				local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile, ::Const.DLC.Desert ? 0.1 : 0.0, 0.5);

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

				if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
				{
					distanceToNextSettlement = distanceToNextSettlement * 2;
				}

				local party = _action.getFaction().spawnEntity(tile, "Lindwurm", false, ::Const.World.Spawn.Lindwurm, 80));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A Lindwurm - a wingless bipedal dragon resembling a giant snake.");
				party.setFootprintType(::Const.World.FootprintsType.Lindwurms);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Forest, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
				roam.setTerrain(::Const.World.TerrainType.Desert, true);
				roam.setTerrain(::Const.World.TerrainType.Steppe, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsHigh.push(beast);
		}

		beast = function ( _action, _nearTile = null )
		{
			if (this.World.getTime().Days < 25 && _nearTile == null)
			{
				return false;
			}

			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if (i == ::Const.World.TerrainType.Mountains)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

			if (tile == null)
			{
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			{
				return false;
			}

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
			{
				distanceToNextSettlement = distanceToNextSettlement * 2;
			}

			local party = _action.getFaction().spawnEntity(tile, "Rock Unhold", false, ::Const.World.Spawn.LegendRockUnhold, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A Rock Unhold");
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Mountains, true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsHigh.push(beast);
		beast = function ( _action, _nearTile = null )
		{
			if (this.World.getTime().Days < 25 && _nearTile == null)
			{
				return false;
			}

			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if (i == ::Const.World.TerrainType.Swamp)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

			if (tile == null)
			{
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			{
				return false;
			}

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
			{
				distanceToNextSettlement = distanceToNextSettlement * 2;
			}

			local party = _action.getFaction().spawnEntity(tile, "Skin Ghoul", false, ::Const.World.Spawn.LegendSkinGhouls, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A Skin Ghoul");
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Steppe, true);
			roam.setTerrain(::Const.World.TerrainType.Plains, true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsHigh.push(beast);
		beast = function ( _action, _nearTile = null )
		{
			if (this.World.getTime().Days < 25 && _nearTile == null)
			{
				return false;
			}

			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if (i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.Snow)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

			if (tile == null)
			{
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			{
				return false;
			}

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
			{
				distanceToNextSettlement = distanceToNextSettlement * 2;
			}

			local party = _action.getFaction().spawnEntity(tile, "White Wolf", false, ::Const.World.Spawn.LegendWhiteDirewolf, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A White Wolf");
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Snow, true);
			roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsHigh.push(beast);
		beast = function ( _action, _nearTile = null )
		{
			if (this.World.getTime().Days < 25 && _nearTile == null)
			{
				return false;
			}

			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if (i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest || i == ::Const.World.TerrainType.Forest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

			if (tile == null)
			{
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			{
				return false;
			}

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
			{
				distanceToNextSettlement = distanceToNextSettlement * 2;
			}

			local party = _action.getFaction().spawnEntity(tile, "Redback Spider", false, ::Const.World.Spawn.LegendRedbackSpider, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A Redback Spider");
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Forest, true);
			roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
			roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsHigh.push(beast);
		beast = function ( _action, _nearTile = null )
		{
			if (this.World.getTime().Days < 25 && _nearTile == null)
			{
				return false;
			}

			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if (i == ::Const.World.TerrainType.Hills)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

			if (tile == null)
			{
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			{
				return false;
			}

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
			{
				distanceToNextSettlement = distanceToNextSettlement * 2;
			}

			local party = _action.getFaction().spawnEntity(tile, "Stollwurm", false, ::Const.World.Spawn.LegendStollwurm, 270);
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A Stollwurm - a wingless bipedal dragon resembling a giant snake.");
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Hills, true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsHigh.push(beast);
		beast = function ( _action, _nearTile = null )
		{
			if (this.World.getTime().Days < 25 && _nearTile == null)
			{
				return false;
			}

			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if (i == ::Const.World.TerrainType.Forest || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest)
				{
				}
				else
				{
					disallowedTerrain.push(i);
				}

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 20 - (_nearTile == null ? 0 : 11), 100, 1000, 3, 0, _nearTile);

			if (tile == null)
			{
				return false;
			}

			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			{
				return false;
			}

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
			{
				distanceToNextSettlement = distanceToNextSettlement * 2;
			}

			local party = _action.getFaction().spawnEntity(tile, "Greenwood Schrats", false, ::Const.World.Spawn.LegendGreenwoodSchrat, ::Math.rand(80, 120) * _action.getScaledDifficultyMult() * ::Math.maxf(0.7, ::Math.minf(1.5, distanceToNextSettlement / 14.0)));
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A creature of bark and wood, blending between trees and shambling slowly, its roots digging through the soil.");
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = this.new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Forest, true);
			roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
			roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
			roam.setMinRange(1);
			roam.setMaxRange(2);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsHigh.push(beast);
	}

});