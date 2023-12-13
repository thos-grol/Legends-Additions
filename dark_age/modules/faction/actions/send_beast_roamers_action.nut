//Reworked beasts
::mods_hookExactClass("factions/actions/send_beast_roamers_action", function(o) {
	o.onUpdate = function( _faction )
	{
		foreach( u in _faction.getUnits() )
		{
			if (!u.isDiscovered() && this.Time.getVirtualTimeF() - u.getSpawnTime() >= 20.0 * this.World.getTime().SecondsPerDay && !u.getSprite("selection").Visible && (this.World.State.getPlayer() == null || this.World.State.getPlayer().getTile().getDistanceTo(u.getTile()) >= 8))
			{
				u.die();
				break;
			}
		}

		if (_faction.getUnits().len() >= 6) return;
		this.m.Score = 10;
	}

	o.onExecute = function( _faction )
	{
		local r = this.Math.rand(0, this.m.Options.len() - 1);

		if (this.World.getTime().Days <= 9)
		{
			r = this.Math.rand(0, this.m.BeastsLow.len() - 1);
		}

		local cap = 10;

		for( local i = 0; i < cap - _faction.getUnits().len(); i = i )
		{
			this.m.Cooldown = 0.0;

			if (this.m.Options[r](this))
			{
				this.m.Cooldown = 5.0;
				break;
			}

			r = this.Math.rand(0, this.m.Options.len() - 1);

			if (this.World.getTime().Days <= 9)
			{
				r = this.Math.rand(0, this.m.BeastsLow.len() - 1);
			}

			i = ++i;
		}
	}

	o.create = function()
	{
		this.m.ID = "send_beast_roamers_action";
		this.m.Cooldown = 5.0;
		this.faction_action.create();
		local distanceToNextAlly = 10;
		local beast;

		beast = function ( _action, _nearTile = null ) //Direwolf
		{
			local disallowedTerrain = [];

			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			{
				if   ( i == ::Const.World.TerrainType.SnowyForest
					|| i == ::Const.World.TerrainType.AutumnForest
					|| i == ::Const.World.TerrainType.Snow
					|| i == ::Const.World.TerrainType.Tundra
				) {}
				else disallowedTerrain.push(i);

				i = ++i;
			}

			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 50, 1000, 3, 0, _nearTile, 0.2);

			if (tile == null) return false;
			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2)) return false;

			local DIREWOLF = {
				ID = ::Const.EntityType.Direwolf,
				Variant = 0,
				Strength = 250,
				Cost = 30,
				Row = 0,
				Script = "scripts/entity/tactical/enemies/la_direwolf"
			};

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
			local party = ::Const.World.Common.la_spawnEntity_single(_action.getFaction(), tile, "Direwolf", false, DIREWOLF, ::Const.World.Spawn.Direwolves);
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A ferocious direwolf looking to lay ruin to all.");
			party.setFootprintType(::Const.World.FootprintsType.Direwolves);
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);

			local roam = ::new("scripts/ai/world/orders/roam_order");
			roam.setAllTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Ocean, false);
			roam.setTerrain(::Const.World.TerrainType.Mountains, false);
			roam.setAvoidHeat(true);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsLow.push(beast);



		beast = function ( _action, _nearTile = null ) //Nachzehrer
		{
			local disallowedTerrain = [];
			for( local i = 0; i < ::Const.World.TerrainType.COUNT; i += 1 )
			{
				if   ( i == ::Const.World.TerrainType.Steppe
					|| i == ::Const.World.TerrainType.Plains
				) {}
				else disallowedTerrain.push(i);
			}
			local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 35, 1000, 3, 0, _nearTile, 0.0, 0.75);
			if (tile == null) return false;
			if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2)) return false;

			local NACHZERER = {
				ID = ::Const.EntityType.Ghoul,
				Variant = 0,
				Strength = 250,
				Cost = 30,
				Row = 0,
				Script = "scripts/entity/tactical/enemies/la_nachzerer"
			};

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
			local party = ::Const.World.Common.la_spawnEntity_single(_action.getFaction(), tile, "Nachzehrer", false, NACHZERER, ::Const.World.Spawn.Ghouls);
			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A scavenging nachzehrer.");
			party.setFootprintType(::Const.World.FootprintsType.Ghouls);
			party.setSlowerAtNight(false);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			local roam = ::new("scripts/ai/world/orders/roam_order");
			roam.setAllTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Mountains, false);
			roam.setTerrain(::Const.World.TerrainType.Ocean, false);
			roam.setTerrain(::Const.World.TerrainType.Shore, false);
			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsLow.push(beast);



		beast = function ( _action, _nearTile = null ) //Unhold
		{
			// if (this.World.getTime().Days < 10 && _nearTile == null)
			// {
			// 	return false;
			// }

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

			local UNHOLD = {
				ID = ::Const.EntityType.Unhold,
				Variant = 0,
				Strength = 400,
				Cost = 30,
				Row = 0,
				Script = "scripts/entity/tactical/enemies/la_unhold"
			};

			local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
			local party = ::Const.World.Common.la_spawnEntity_single(_action.getFaction(), tile, "Unhold", false, UNHOLD, ::Const.World.Spawn.Unhold);

			party.getSprite("banner").setBrush("banner_beasts_01");
			party.setDescription("A lumbering giant");
			party.setFootprintType(::Const.World.FootprintsType.Unholds);
			party.setSlowerAtNight(true);
			party.setUsingGlobalVision(false);
			party.setLooting(false);
			party.getFlags().set("IsUnholds", true);
			local roam = ::new("scripts/ai/world/orders/roam_order");
			roam.setNoTerrainAvailable();
			roam.setTerrain(::Const.World.TerrainType.Forest, true);
			roam.setTerrain(::Const.World.TerrainType.Hills, true);
			roam.setTerrain(::Const.World.TerrainType.Tundra, true);
			roam.setTerrain(::Const.World.TerrainType.Mountains, true);
			local r = this.Math.rand(1, 20);

			if (r == 1)
			{
				roam.setTerrain(::Const.World.TerrainType.Plains, true);
			}
			else if (r == 2)
			{
				roam.setTerrain(::Const.World.TerrainType.Badlands, true);
			}
			else if (r == 3)
			{
				roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
			}
			else if (r == 4)
			{
				roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
			}
			else if (r == 5)
			{
				roam.setTerrain(::Const.World.TerrainType.Farmland, true);
			}
			else if (r == 6)
			{
				roam.setTerrain(::Const.World.TerrainType.Steppe, true);
			}
			else if (r == 7)
			{
				roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
			}
			else if (r == 8)
			{
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
			}
			else if (r == 9)
			{
				roam.setTerrain(::Const.World.TerrainType.Snow, true);
			}

			party.getController().addOrder(roam);
			return true;
		};
		this.m.Options.push(beast);
		this.m.BeastsLow.push(beast);

		return; //FIXME: PLACEHOLDER remove for normal function, add more supernatural monsters


		if (::Const.DLC.Desert)
		{
			// beast = function ( _action, _nearTile = null ) //Hyenas
			// {
			// 	local disallowedTerrain = [];

			// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			// 	{
			// 		if (i == ::Const.World.TerrainType.Desert || i == ::Const.World.TerrainType.Oasis || i == ::Const.World.TerrainType.Hills)
			// 		{
			// 		}
			// 		else
			// 		{
			// 			disallowedTerrain.push(i);
			// 		}

			// 		i = ++i;
			// 	}

			// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 50, 1000, 3, 0, _nearTile, 0.0, 0.2);

			// 	if (tile == null)
			// 	{
			// 		return false;
			// 	}

			// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			// 	{
			// 		return false;
			// 	}

			// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
			// 	local party = _action.getFaction().spawnEntity(tile, "Hyenas", false, ::Const.World.Spawn.Hyenas, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
			// 	party.getSprite("banner").setBrush("banner_beasts_01");
			// 	party.setDescription("A pack of esurient hyenas on the hunt for prey.");
			// 	party.setFootprintType(::Const.World.FootprintsType.Hyenas);
			// 	party.setSlowerAtNight(false);
			// 	party.setUsingGlobalVision(false);
			// 	party.setLooting(false);
			// 	local roam = ::new("scripts/ai/world/orders/roam_order");
			// 	roam.setNoTerrainAvailable();
			// 	roam.setTerrain(::Const.World.TerrainType.Desert, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Oasis, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Steppe, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Hills, true);
			// 	local r = this.Math.rand(1, 10);

			// 	if (r == 1)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Plains, true);
			// 	}
			// 	else if (r == 2)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Plains, true);
			// 		roam.setTerrain(::Const.World.TerrainType.Farmland, true);
			// 	}
			// 	else if (r == 3)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Swamp, true);
			// 	}
			// 	else if (r == 4)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Badlands, true);
			// 	}
			// 	else if (r == 5)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Mountains, true);
			// 	}

			// 	party.getController().addOrder(roam);
			// 	return true;
			// };
			// this.m.Options.push(beast);
			// this.m.BeastsLow.push(beast);
			// beast = function ( _action, _nearTile = null ) //Serpents
			// {
			// 	if (this.World.getTime().Days < 15 && _nearTile == null)
			// 	{
			// 		return false;
			// 	}

			// 	local disallowedTerrain = [];

			// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			// 	{
			// 		if (i == ::Const.World.TerrainType.Tundra || ::Const.World.TerrainType.Snow || i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.Hills || i == ::Const.World.TerrainType.Mountains)
			// 		{
			// 		}
			// 		else
			// 		{
			// 			disallowedTerrain.push(i);
			// 		}

			// 		i = ++i;
			// 	}

			// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 7, 50, 1000, 3, 0, _nearTile, 0.0, 0.2);

			// 	if (tile == null)
			// 	{
			// 		return false;
			// 	}

			// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			// 	{
			// 		return false;
			// 	}

			// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
			// 	local party = _action.getFaction().spawnEntity(tile, "Serpents", false, ::Const.World.Spawn.Serpents, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
			// 	party.getSprite("banner").setBrush("banner_beasts_01");
			// 	party.setDescription("Giant serpents slithering about.");
			// 	party.setFootprintType(::Const.World.FootprintsType.Serpents);
			// 	party.setSlowerAtNight(false);
			// 	party.setUsingGlobalVision(false);
			// 	party.setLooting(false);
			// 	local roam = ::new("scripts/ai/world/orders/roam_order");
			// 	roam.setNoTerrainAvailable();
			// 	roam.setTerrain(::Const.World.TerrainType.Desert, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Oasis, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Steppe, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Hills, true);
			// 	roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
			// 	roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
			// 	local r = this.Math.rand(1, 20);

			// 	if (r == 1)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Plains, true);
			// 	}
			// 	else if (r == 2)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Plains, true);
			// 		roam.setTerrain(::Const.World.TerrainType.Farmland, true);
			// 	}
			// 	else if (r == 3)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Swamp, true);
			// 	}
			// 	else if (r == 4)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
			// 	}
			// 	else if (r == 5)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Farmland, true);
			// 	}
			// 	else if (r == 6)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Ocean, true);
			// 	}
			// 	else if (r == 7)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Badlands, true);
			// 	}
			// 	else if (r == 8)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
			// 	}
			// 	else if (r == 9)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Mountains, true);
			// 	}

			// 	party.getController().addOrder(roam);
			// 	return true;
			// };
			// this.m.Options.push(beast);
		}

		if (::Const.DLC.Unhold)
		{
			beast = function ( _action, _nearTile = null ) //Webknechts
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

				if (tile == null)
				{
					return false;
				}

				if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
				{
					return false;
				}

				local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
				local party = _action.getFaction().spawnEntity(tile, "Webknechts", false, ::Const.World.Spawn.Spiders, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A swarm of webknechts skittering about.");
				party.setFootprintType(::Const.World.FootprintsType.Spiders);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsWebknechts", true);
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Forest, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
				roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
				roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
				roam.setMinRange(1);
				roam.setMaxRange(4);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsLow.push(beast);


			beast = function ( _action, _nearTile = null ) //Unhold Frost
			{
				if (this.World.getTime().Days < 10 && _nearTile == null)
				{
					return false;
				}

				local disallowedTerrain = [];

				for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
				{
					if (i == ::Const.World.TerrainType.Snow || i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.Tundra)
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
				local party = _action.getFaction().spawnEntity(tile, "Unhold", false, ::Const.World.Spawn.UnholdFrost, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("One or more lumbering giants.");
				party.setFootprintType(::Const.World.FootprintsType.Unholds);
				party.setSlowerAtNight(true);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsUnholds", true);
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Snow, true);
				roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
				roam.setTerrain(::Const.World.TerrainType.Hills, true);
				local r = this.Math.rand(1, 20);

				if (r <= 5)
				{
					roam.setTerrain(::Const.World.TerrainType.Tundra, true);
				}
				else if (r >= 18)
				{
					roam.setTerrain(::Const.World.TerrainType.Mountains, true);
				}

				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null ) //Unhold Bog
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
				local party = _action.getFaction().spawnEntity(tile, "Unhold", false, ::Const.World.Spawn.UnholdBog, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("One or more lumbering giants.");
				party.setFootprintType(::Const.World.FootprintsType.Unholds);
				party.setSlowerAtNight(true);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsUnholds", true);
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Swamp, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
				roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
				local r = this.Math.rand(1, 20);

				if (r == 1)
				{
					roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
				}
				else if (r == 2)
				{
					roam.setTerrain(::Const.World.TerrainType.Oasis, true);
					roam.setTerrain(::Const.World.TerrainType.Shore, true);
				}
				else if (r == 3)
				{
					roam.setTerrain(::Const.World.TerrainType.Farmland, true);
				}

				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null ) //Alps
			{
				if (_nearTile == null && this.Math.rand(1, 100) <= 25)
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
					::Const.World.TerrainType.SwampForest,
					::Const.World.TerrainType.SwampGreen,
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

				local party = _action.getFaction().spawnEntity(tile, "Alps", false, ::Const.World.Spawn.Alps, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("Pale and haggard creatures creeping around.");
				party.setFootprintType(::Const.World.FootprintsType.Alps);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				party.getFlags().set("IsAlps", true);
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setAllTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Mountains, false);
				roam.setTerrain(::Const.World.TerrainType.Ocean, false);
				roam.setTerrain(::Const.World.TerrainType.Shore, false);
				local r = this.Math.rand(1, 20);

				if (r == 1)
				{
					roam.setTerrain(::Const.World.TerrainType.Hills, true);
				}
				else if (r == 2)
				{
					roam.setTerrain(::Const.World.TerrainType.Forest, true);
					roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
				}
				else if (r == 3)
				{
					roam.setTerrain(::Const.World.TerrainType.Tundra, true);
				}
				else if (r == 4)
				{
					roam.setTerrain(::Const.World.TerrainType.Swamp, true);
					roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
				}

				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsMedium.push(beast);
			// beast = function ( _action, _nearTile = null ) //Hexen
			// {
			// 	if (this.World.getTime().Days < 20 && _nearTile == null)
			// 	{
			// 		return false;
			// 	}

			// 	if (_nearTile == null && this.Math.rand(1, 100) <= 10)
			// 	{
			// 		return false;
			// 	}

			// 	local tile = _action.getTileToSpawnLocation(10, [
			// 		::Const.World.TerrainType.Mountains,
			// 		::Const.World.TerrainType.Hills,
			// 		::Const.World.TerrainType.Snow,
			// 		::Const.World.TerrainType.SnowyForest,
			// 		::Const.World.TerrainType.Desert,
			// 		::Const.World.TerrainType.Oasis
			// 	], 8, 50, 1000, 3, 0, _nearTile, 0.1, 0.9);

			// 	if (tile == null)
			// 	{
			// 		return false;
			// 	}

			// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			// 	{
			// 		return false;
			// 	}

			// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

			// 	if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
			// 	{
			// 		distanceToNextSettlement = distanceToNextSettlement * 2;
			// 	}

			// 	local party = _action.getFaction().spawnEntity(tile, "Hexen", false, ::Const.World.Spawn.HexenAndMore, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
			// 	party.getSprite("banner").setBrush("banner_beasts_01");
			// 	party.setDescription("A malevolent old crone, said to lure and abduct little children to make broth and concoctions out of, strike sinister pacts with villagers, and weave curses.");
			// 	party.setFootprintType(::Const.World.FootprintsType.Hexen);
			// 	party.setSlowerAtNight(false);
			// 	party.setUsingGlobalVision(false);
			// 	party.setLooting(false);
			// 	local roam = ::new("scripts/ai/world/orders/roam_order");
			// 	roam.setAllTerrainAvailable();
			// 	roam.setTerrain(::Const.World.TerrainType.Mountains, false);
			// 	roam.setTerrain(::Const.World.TerrainType.Ocean, false);
			// 	roam.setTerrain(::Const.World.TerrainType.Shore, false);
			// 	local r = this.Math.rand(1, 20);

			// 	if (r == 1)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
			// 	}
			// 	else if (r == 2)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Forest, true);
			// 		roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
			// 	}
			// 	else if (r == 3)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Farmland, true);
			// 		roam.setTerrain(::Const.World.TerrainType.Urban, true);
			// 	}
			// 	else if (r == 4)
			// 	{
			// 		roam.setTerrain(::Const.World.TerrainType.Swamp, true);
			// 		roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
			// 	}

			// 	party.getController().addOrder(roam);
			// 	return true;
			// };
			// this.m.Options.push(beast);
			// this.m.BeastsMedium.push(beast);
			beast = function ( _action, _nearTile = null ) //Schrat
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

				local party = _action.getFaction().spawnEntity(tile, "Schrats", false, ::Const.World.Spawn.Schrats, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A creature of bark and wood, blending between trees and shambling slowly, its roots digging through the soil.");
				party.setFootprintType(::Const.World.FootprintsType.Schrats);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Forest, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
				local r = this.Math.rand(1, 20);

				if (r == 1)
				{
					roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
					roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
				}
				else if (r == 2)
				{
					roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
					roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
				}
				else if (r == 3)
				{
					roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
				}
				else if (r == 4)
				{
					roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
				}

				roam.setMinRange(1);
				roam.setMaxRange(4);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsHigh.push(beast);
			beast = function ( _action, _nearTile = null ) //Kraken
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
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Swamp, true);
				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
		}

		if (::Const.DLC.Desert)
		{
			// beast = function ( _action, _nearTile = null ) //Ifrit
			// {
			// 	if (this.World.getTime().Days < 20 && _nearTile == null)
			// 	{
			// 		return false;
			// 	}

			// 	local disallowedTerrain = [];

			// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
			// 	{
			// 		if (i == ::Const.World.TerrainType.Desert || i == ::Const.World.TerrainType.Oasis || i == ::Const.World.TerrainType.Hills)
			// 		{
			// 		}
			// 		else
			// 		{
			// 			disallowedTerrain.push(i);
			// 		}

			// 		i = ++i;
			// 	}

			// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 16 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile, 0.0, 0.2);

			// 	if (tile == null)
			// 	{
			// 		return false;
			// 	}

			// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
			// 	{
			// 		return false;
			// 	}

			// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);
			// 	local party = _action.getFaction().spawnEntity(tile, "Ifrits", false, ::Const.World.Spawn.SandGolems, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
			// 	party.getSprite("banner").setBrush("banner_beasts_01");
			// 	party.setDescription("Creatures of living stone shaped by the blistering heat and fire of the burning sun of the south.");
			// 	party.setFootprintType(::Const.World.FootprintsType.SandGolems);
			// 	party.setSlowerAtNight(false);
			// 	party.setUsingGlobalVision(false);
			// 	party.setLooting(false);
			// 	local roam = ::new("scripts/ai/world/orders/roam_order");
			// 	roam.setNoTerrainAvailable();
			// 	roam.setTerrain(::Const.World.TerrainType.Desert, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Oasis, true);
			// 	roam.setTerrain(::Const.World.TerrainType.Hills, true);
			// 	party.getController().addOrder(roam);
			// 	return true;
			// };
			// this.m.Options.push(beast);
		}

		if (::Const.DLC.Lindwurm)
		{
			beast = function ( _action, _nearTile = null ) //Lindwurm
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

				local party = _action.getFaction().spawnEntity(tile, "Lindwurm", false, ::Const.World.Spawn.Lindwurm, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
				party.getSprite("banner").setBrush("banner_beasts_01");
				party.setDescription("A Lindwurm - a wingless bipedal dragon resembling a giant snake.");
				party.setFootprintType(::Const.World.FootprintsType.Lindwurms);
				party.setSlowerAtNight(false);
				party.setUsingGlobalVision(false);
				party.setLooting(false);
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setNoTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Forest, true);
				roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
				roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
				roam.setTerrain(::Const.World.TerrainType.Desert, true);
				roam.setTerrain(::Const.World.TerrainType.Steppe, true);
				roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
				local r = this.Math.rand(1, 20);

				if (r == 1)
				{
					roam.setTerrain(::Const.World.TerrainType.Hills, true);
					roam.setTerrain(::Const.World.TerrainType.Mountains, true);
				}
				else if (r == 2)
				{
					roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
					roam.setTerrain(::Const.World.TerrainType.Swamp, true);
				}
				else if (r == 3)
				{
					roam.setTerrain(::Const.World.TerrainType.Plains, true);
					roam.setTerrain(::Const.World.TerrainType.Farmland, true);
				}

				party.getController().addOrder(roam);
				return true;
			};
			this.m.Options.push(beast);
			this.m.BeastsHigh.push(beast);
		}

		// beast = function ( _action, _nearTile = null ) //Rock Unhold
		// {
		// 	if (this.World.getTime().Days < 25 && _nearTile == null)
		// 	{
		// 		return false;
		// 	}

		// 	local disallowedTerrain = [];

		// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
		// 	{
		// 		if (i == ::Const.World.TerrainType.Mountains)
		// 		{
		// 		}
		// 		else
		// 		{
		// 			disallowedTerrain.push(i);
		// 		}

		// 		i = ++i;
		// 	}

		// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

		// 	if (tile == null)
		// 	{
		// 		return false;
		// 	}

		// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
		// 	{
		// 		return false;
		// 	}

		// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

		// 	if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
		// 	{
		// 		distanceToNextSettlement = distanceToNextSettlement * 2;
		// 	}

		// 	local party = _action.getFaction().spawnEntity(tile, "Rock Unhold", false, ::Const.World.Spawn.LegendRockUnhold, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
		// 	party.getSprite("banner").setBrush("banner_beasts_01");
		// 	party.setDescription("A Rock Unhold");
		// 	party.setSlowerAtNight(false);
		// 	party.setUsingGlobalVision(false);
		// 	party.setLooting(false);
		// 	local roam = ::new("scripts/ai/world/orders/roam_order");
		// 	roam.setNoTerrainAvailable();
		// 	roam.setTerrain(::Const.World.TerrainType.Mountains, true);
		// 	local r = this.Math.rand(1, 20);

		// 	if (r == 1)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Steppe, true);
		// 	}
		// 	else if (r == 3)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Tundra, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 	}

		// 	party.getController().addOrder(roam);
		// 	return true;
		// };
		// this.m.Options.push(beast);
		// this.m.BeastsHigh.push(beast);
		// beast = function ( _action, _nearTile = null ) //Skin Ghoul
		// {
		// 	if (this.World.getTime().Days < 25 && _nearTile == null)
		// 	{
		// 		return false;
		// 	}

		// 	local disallowedTerrain = [];

		// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
		// 	{
		// 		if (i == ::Const.World.TerrainType.Swamp)
		// 		{
		// 		}
		// 		else
		// 		{
		// 			disallowedTerrain.push(i);
		// 		}

		// 		i = ++i;
		// 	}

		// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

		// 	if (tile == null)
		// 	{
		// 		return false;
		// 	}

		// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
		// 	{
		// 		return false;
		// 	}

		// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

		// 	if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
		// 	{
		// 		distanceToNextSettlement = distanceToNextSettlement * 2;
		// 	}

		// 	local party = _action.getFaction().spawnEntity(tile, "Skin Ghoul", false, ::Const.World.Spawn.LegendSkinGhouls, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
		// 	party.getSprite("banner").setBrush("banner_beasts_01");
		// 	party.setDescription("A Skin Ghoul");
		// 	party.setSlowerAtNight(false);
		// 	party.setUsingGlobalVision(false);
		// 	party.setLooting(false);
		// 	local roam = ::new("scripts/ai/world/orders/roam_order");
		// 	roam.setNoTerrainAvailable();
		// 	roam.setTerrain(::Const.World.TerrainType.Steppe, true);
		// 	roam.setTerrain(::Const.World.TerrainType.Plains, true);
		// 	local r = this.Math.rand(1, 20);

		// 	if (r == 1)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Farmland, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Urban, true);
		// 	}
		// 	else if (r == 3)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Badlands, true);
		// 	}

		// 	party.getController().addOrder(roam);
		// 	return true;
		// };
		// this.m.Options.push(beast);
		// this.m.BeastsHigh.push(beast);
		// beast = function ( _action, _nearTile = null ) //"White Wolf"
		// {
		// 	if (this.World.getTime().Days < 25 && _nearTile == null)
		// 	{
		// 		return false;
		// 	}

		// 	local disallowedTerrain = [];

		// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
		// 	{
		// 		if (i == ::Const.World.TerrainType.SnowyForest || i == ::Const.World.TerrainType.Snow)
		// 		{
		// 		}
		// 		else
		// 		{
		// 			disallowedTerrain.push(i);
		// 		}

		// 		i = ++i;
		// 	}

		// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

		// 	if (tile == null)
		// 	{
		// 		return false;
		// 	}

		// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
		// 	{
		// 		return false;
		// 	}

		// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

		// 	if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
		// 	{
		// 		distanceToNextSettlement = distanceToNextSettlement * 2;
		// 	}

		// 	local party = _action.getFaction().spawnEntity(tile, "White Wolf", false, ::Const.World.Spawn.LegendWhiteDirewolf, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
		// 	party.getSprite("banner").setBrush("banner_beasts_01");
		// 	party.setDescription("A White Wolf");
		// 	party.setSlowerAtNight(false);
		// 	party.setUsingGlobalVision(false);
		// 	party.setLooting(false);
		// 	local roam = ::new("scripts/ai/world/orders/roam_order");
		// 	roam.setNoTerrainAvailable();
		// 	roam.setTerrain(::Const.World.TerrainType.Snow, true);
		// 	roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
		// 	local r = this.Math.rand(1, 20);

		// 	if (r == 1)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Tundra, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Mountains, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Tundra, true);
		// 	}
		// 	else if (r == 3)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Tundra, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Mountains, true);
		// 	}
		// 	else if (r == 4)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Tundra, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Forest, true);
		// 		roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
		// 		roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
		// 	}
		// 	else if (r == 5)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Tundra, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Mountains, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Plains, true);
		// 	}
		// 	else if (r == 5)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Tundra, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Mountains, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Badlands, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Steppe, true);
		// 	}

		// 	party.getController().addOrder(roam);
		// 	return true;
		// };
		// this.m.Options.push(beast);
		// this.m.BeastsHigh.push(beast);
		// beast = function ( _action, _nearTile = null ) //"Redback Spider"
		// {
		// 	if (this.World.getTime().Days < 25 && _nearTile == null)
		// 	{
		// 		return false;
		// 	}

		// 	local disallowedTerrain = [];

		// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
		// 	{
		// 		if (i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest || i == ::Const.World.TerrainType.Forest)
		// 		{
		// 		}
		// 		else
		// 		{
		// 			disallowedTerrain.push(i);
		// 		}

		// 		i = ++i;
		// 	}

		// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

		// 	if (tile == null)
		// 	{
		// 		return false;
		// 	}

		// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
		// 	{
		// 		return false;
		// 	}

		// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

		// 	if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
		// 	{
		// 		distanceToNextSettlement = distanceToNextSettlement * 2;
		// 	}

		// 	local party = _action.getFaction().spawnEntity(tile, "Redback Spider", false, ::Const.World.Spawn.LegendRedbackSpider, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
		// 	party.getSprite("banner").setBrush("banner_beasts_01");
		// 	party.setDescription("A Redback Spider");
		// 	party.setSlowerAtNight(false);
		// 	party.setUsingGlobalVision(false);
		// 	party.setLooting(false);
		// 	local roam = ::new("scripts/ai/world/orders/roam_order");
		// 	roam.setNoTerrainAvailable();
		// 	roam.setTerrain(::Const.World.TerrainType.Forest, true);
		// 	roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
		// 	roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
		// 	local r = this.Math.rand(1, 20);

		// 	if (r == 1)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
		// 		roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Mountains, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 	}
		// 	else if (r == 3)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Desert, true);
		// 		roam.setTerrain(::Const.World.TerrainType.Badlands, true);
		// 	}

		// 	party.getController().addOrder(roam);
		// 	return true;
		// };
		// this.m.Options.push(beast);
		// this.m.BeastsHigh.push(beast);
		// beast = function ( _action, _nearTile = null ) //Stollwurm
		// {
		// 	if (this.World.getTime().Days < 25 && _nearTile == null)
		// 	{
		// 		return false;
		// 	}

		// 	local disallowedTerrain = [];

		// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
		// 	{
		// 		if (i == ::Const.World.TerrainType.Hills)
		// 		{
		// 		}
		// 		else
		// 		{
		// 			disallowedTerrain.push(i);
		// 		}

		// 		i = ++i;
		// 	}

		// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 18 - (_nearTile == null ? 0 : 10), 100, 1000, 3, 0, _nearTile);

		// 	if (tile == null)
		// 	{
		// 		return false;
		// 	}

		// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
		// 	{
		// 		return false;
		// 	}

		// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

		// 	if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
		// 	{
		// 		distanceToNextSettlement = distanceToNextSettlement * 2;
		// 	}

		// 	local party = _action.getFaction().spawnEntity(tile, "Stollwurm", false, ::Const.World.Spawn.LegendStollwurm, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
		// 	party.getSprite("banner").setBrush("banner_beasts_01");
		// 	party.setDescription("A Stollwurm - a wingless bipedal dragon resembling a giant snake made of rock.");
		// 	party.setSlowerAtNight(false);
		// 	party.setUsingGlobalVision(false);
		// 	party.setLooting(false);
		// 	local roam = ::new("scripts/ai/world/orders/roam_order");
		// 	roam.setNoTerrainAvailable();
		// 	roam.setTerrain(::Const.World.TerrainType.Hills, true);
		// 	roam.setTerrain(::Const.World.TerrainType.Mountains, true);
		// 	local r = this.Math.rand(1, 20);

		// 	if (r == 1)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Steppe, true);
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Desert, true);
		// 	}
		// 	else if (r == 3)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Badlands, true);
		// 	}
		// 	else if (r == 3)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Plains, true);
		// 	}

		// 	party.getController().addOrder(roam);
		// 	return true;
		// };
		// this.m.Options.push(beast);
		// this.m.BeastsHigh.push(beast);
		// beast = function ( _action, _nearTile = null ) //Greenwood Schrats
		// {
		// 	if (this.World.getTime().Days < 25 && _nearTile == null)
		// 	{
		// 		return false;
		// 	}

		// 	local disallowedTerrain = [];

		// 	for( local i = 0; i < ::Const.World.TerrainType.COUNT; i = i )
		// 	{
		// 		if (i == ::Const.World.TerrainType.Forest || i == ::Const.World.TerrainType.LeaveForest || i == ::Const.World.TerrainType.AutumnForest)
		// 		{
		// 		}
		// 		else
		// 		{
		// 			disallowedTerrain.push(i);
		// 		}

		// 		i = ++i;
		// 	}

		// 	local tile = _action.getTileToSpawnLocation(10, disallowedTerrain, 20 - (_nearTile == null ? 0 : 11), 100, 1000, 3, 0, _nearTile);

		// 	if (tile == null)
		// 	{
		// 		return false;
		// 	}

		// 	if (_action.getDistanceToNextAlly(tile) <= distanceToNextAlly / (_nearTile == null ? 1 : 2))
		// 	{
		// 		return false;
		// 	}

		// 	local distanceToNextSettlement = _action.getDistanceToSettlements(tile);

		// 	if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue())
		// 	{
		// 		distanceToNextSettlement = distanceToNextSettlement * 2;
		// 	}

		// 	local party = _action.getFaction().spawnEntity(tile, "Greenwood Schrats", false, ::Const.World.Spawn.LegendGreenwoodSchrat, this.Math.rand(80, 120) * _action.getScaledDifficultyMult() * this.Math.maxf(0.7, this.Math.minf(1.5, distanceToNextSettlement / 14.0)));
		// 	party.getSprite("banner").setBrush("banner_beasts_01");
		// 	party.setDescription("A creature of bark and wood, blending between trees and shambling slowly, its roots digging through the soil.");
		// 	party.setSlowerAtNight(false);
		// 	party.setUsingGlobalVision(false);
		// 	party.setLooting(false);
		// 	local roam = ::new("scripts/ai/world/orders/roam_order");
		// 	roam.setNoTerrainAvailable();
		// 	roam.setTerrain(::Const.World.TerrainType.Forest, true);
		// 	roam.setTerrain(::Const.World.TerrainType.LeaveForest, true);
		// 	roam.setTerrain(::Const.World.TerrainType.AutumnForest, true);
		// 	roam.setTerrain(::Const.World.TerrainType.SwampForest, true);
		// 	roam.setTerrain(::Const.World.TerrainType.SwampGreen, true);
		// 	local r = this.Math.rand(1, 20);

		// 	if (r == 1)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.SnowyForest, true);
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Swamp, true);
		// 	}
		// 	else if (r == 2)
		// 	{
		// 		roam.setTerrain(::Const.World.TerrainType.Farmland, true);
		// 	}

		// 	roam.setMinRange(1);
		// 	roam.setMaxRange(2);
		// 	party.getController().addOrder(roam);
		// 	return true;
		// };
		// this.m.Options.push(beast);
		// this.m.BeastsHigh.push(beast);
	}

});

