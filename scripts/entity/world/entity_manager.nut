this.entity_manager <- {
	m = {
		Settlements = [],
		NextSituationID = 1,
		Locations = [],
		RoadAmbushTiles = [],
		Mercenaries = [],
		FreeCompanies = [],
		NonDefaultFreeCompanies = [],
		LastMercUpdateTime = 0,
		LastFreeCompanyUpdateTime = 0,
		LastSnowSpawnTime = this.Time.getVirtualTimeF() + 5.0,
		LastWaveSpawnTime = this.Time.getVirtualTimeF() + 5.0
	},
	function addLocation( _l )
	{
		this.m.Locations.push(_l);
	}

	function removeLocation( _l )
	{
		foreach( i, r in this.m.Locations )
		{
			if (r.getID() == _l.getID())
			{
				this.m.Locations.remove(i);
				break;
			}
		}
	}

	function getLocations()
	{
		return this.m.Locations;
	}

	function addSettlement( _s )
	{
		this.m.Settlements.push(_s);
	}

	function removeSettlement( _s )
	{
		foreach( i, r in this.m.Settlements )
		{
			if (r.getID() == _s.getID())
			{
				this.m.Settlements.remove(i);
				break;
			}
		}
	}

	function getSettlements()
	{
		return this.m.Settlements;
	}

	function getNextSituationID()
	{
		return this.m.NextSituationID++;
	}

	function getAmbushSpots()
	{
		return this.m.RoadAmbushTiles;
	}

	function getMercenaries()
	{
		return this.m.Mercenaries;
	}

	function create()
	{
	}

	function update()
	{
		this.manageAIFreeCompanies();
		this.manageAIMercenaries();
	}

	function clear()
	{
		this.m.Settlements = [];
		this.m.Locations = [];
		this.m.RoadAmbushTiles = [];
		this.m.Mercenaries = [];
		this.m.FreeCompanies = [];
		this.m.NonDefaultFreeCompanies = [];
		this.m.LastMercUpdateTime = 0.0;
		this.m.LastFreeCompanyUpdateTime = 0.0;
		this.m.LastSnowSpawnTime = 0.0;
	}

	function getUniqueLocationName( _names )
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			]
		];
		local tries = 0;

		do
		{
			local name = _names[this.Math.rand(0, _names.len() - 1)];
			name = this.buildTextFromTemplate(name, vars);
			tries = ++tries;
			tries = tries;

			if (tries > 1000)
			{
				this.logError("unable to find unique name: " + name);
				return name;
			}

			local tryAgain = false;

			foreach( v in this.m.Locations )
			{
				if (name == v.getName())
				{
					tryAgain = true;
					break;
				}
			}

			if (tryAgain)
			{
			}
			else
			{
				return name;
			}
		}
		while (true);
	}

	function buildRoadAmbushSpots()
	{
		this.m.RoadAmbushTiles = [];
		local sizeX = this.World.getMapSize().X;
		local sizeY = this.World.getMapSize().Y;

		for( local x = 0; x < sizeX; x = x )
		{
			for( local y = 0; y < sizeY; y = y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.HasRoad)
				{
				}
				else if (this.Const.World.TerrainTypeVisibilityMult[tile.Type] >= 1.0)
				{
				}
				else if (this.Const.World.TerrainTypeVisionRadiusMult[tile.Type] < 1.0)
				{
				}
				else if (this.Const.World.TerrainTypeSpeedMult[tile.Type] < 0.5)
				{
				}
				else
				{
					local isNextToRoad = false;

					for( local i = 0; i != 6; i = i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.HasRoad)
							{
								isNextToRoad = true;
								break;
							}

							for( local j = 0; j != 6; j = j )
							{
								if (!nextTile.hasNextTile(j))
								{
								}
								else
								{
									local veryNextTile = nextTile.getNextTile(j);

									if (veryNextTile.HasRoad && veryNextTile.ID != tile.ID)
									{
										isNextToRoad = true;
										break;
									}
								}

								j = ++j;
							}

							if (isNextToRoad)
							{
								break;
							}
						}

						i = ++i;
					}

					if (!isNextToRoad)
					{
					}
					else
					{
						local isTooClose = false;

						foreach( s in this.m.Settlements )
						{
							local d = tile.getDistanceTo(s.getTile());

							if (d <= this.Const.World.AI.Behavior.AmbushMinDistToSettlements)
							{
								isTooClose = true;
								break;
							}

							foreach( a in s.getAttachedLocations() )
							{
								if (d <= this.Const.World.AI.Behavior.AmbushMinDistToSettlements - 2)
								{
									isTooClose = true;
									break;
								}
							}

							if (isTooClose)
							{
								break;
							}
						}

						if (isTooClose)
						{
						}
						else
						{
							this.m.RoadAmbushTiles.push({
								Tile = tile,
								Distance = 0
							});
						}
					}
				}

				y = ++y;
			}

			x = ++x;
		}
	}

	function updateSettlementHeat()
	{
		local settlements = this.getSettlements();
		local sizeX = this.World.getMapSize().X;
		local sizeY = this.World.getMapSize().Y;

		for( local x = 0; x < sizeX; x = x )
		{
			for( local y = 0; y < sizeY; y = y )
			{
				this.World.getTileSquare(x, y).HeatFromSettlements = 0;
				y = ++y;
			}

			x = ++x;
		}

		for( local x = 0; x < sizeX; x = x )
		{
			for( local y = 0; y < sizeY; y = y )
			{
				local tile = this.World.getTileSquare(x, y);

				foreach( s in settlements )
				{
					if (!s.isAlive() || !s.isActive())
					{
						continue;
					}

					local d = s.getTile().getDistanceTo(tile);

					if (d > 6)
					{
						continue;
					}

					tile.HeatFromSettlements = tile.HeatFromSettlements + (6 - d);
				}

				y = ++y;
			}

			x = ++x;
		}
	}

	function spawnWaves()
	{
		local numWaves = (this.Time.getVirtualTimeF() - this.m.LastWaveSpawnTime) * 300;
		this.m.LastWaveSpawnTime = this.Time.getVirtualTimeF();

		while (numWaves-- >= 0)
		{
			local x = this.Math.rand(3, this.World.getMapSize().X - 3);
			local y = this.Math.rand(3, this.World.getMapSize().Y - 3);
			local tile = this.World.getTileSquare(x, y);

			if (tile.Type != this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			local other = false;

			for( local i = 0; i != 6; i = i )
			{
				if (tile.getNextTile(i).Type != this.Const.World.TerrainType.Ocean)
				{
					other = true;
					break;
				}

				i = ++i;
			}

			if (other)
			{
				continue;
			}

			this.World.spawnWaveSprite("waves_0" + this.Math.rand(1, 4), tile.Pos, this.createVec(-15, -15), 1.25);
		}
	}

	function onWorldEntityDestroyed( _entity, _isLocation )
	{
		if (!this.Tactical.isVisible())
		{
			return;
		}

		if (this.World.State.getPlayer().isAlliedWith(_entity))
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();

		if (playerTile.getDistanceTo(_entity.getTile()) > 2)
		{
			return;
		}

		if (_isLocation)
		{
			if (_entity.getTypeID() == "location.black_monolith")
			{
				this.updateAchievement("RestInPieces", 1, 1);
			}

			this.World.Statistics.getFlags().set("LastLocationDestroyedName", _entity.getName());
			this.World.Statistics.getFlags().set("LastLocationDestroyedFaction", _entity.getFaction());
			this.World.Statistics.getFlags().set("LastLocationDestroyedForContract", _entity.getSprite("selection").Visible);

			if (this.World.FactionManager.isGreaterEvil())
			{
				local f = this.World.FactionManager.getFaction(_entity.getFaction());

				if (this.World.FactionManager.isCivilWar() && f != null && f.getType() == this.Const.FactionType.NobleHouse)
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnLocationDestroyed);
				}
				else if (this.World.FactionManager.isGreenskinInvasion() && f != null && (f.getType() == this.Const.FactionType.Orcs || f.getType() == this.Const.FactionType.Goblins))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnLocationDestroyed);
				}
				else if (this.World.FactionManager.isUndeadScourge() && f != null && (f.getType() == this.Const.FactionType.Undead || f.getType() == this.Const.FactionType.Zombies))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnLocationDestroyed);
				}
			}

			if (this.World.Flags.get("IsGoblinCityOutposts"))
			{
				if (_entity.getTypeID() == "location.goblin_camp" || _entity.getTypeID() == "location.goblin_hideout" || _entity.getTypeID() == "location.goblin_outpost" || _entity.getTypeID() == "location.goblin_ruins" || _entity.getTypeID() == "location.goblin_settlement")
				{
					this.World.Flags.increment("GoblinCityCount", 1);
				}
			}

			this.World.Contracts.onLocationDestroyed(_entity);
			this.World.Ambitions.onLocationDestroyed(_entity);
		}
		else
		{
			if (this.World.FactionManager.getFaction(_entity.getFaction()).getType() == this.Const.FactionType.NobleHouse)
			{
				this.updateAchievement("NotSoNoble", 1, 1);
			}

			if (_entity.getFlags().get("IsMercenaries"))
			{
				this.updateAchievement("KingOfTheHill", 1, 1);
			}

			if (this.World.FactionManager.isGreaterEvil())
			{
				local f = this.World.FactionManager.getFaction(_entity.getFaction());

				if (this.World.FactionManager.isCivilWar() && f != null && f.getType() == this.Const.FactionType.NobleHouse)
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
				else if (this.World.FactionManager.isGreenskinInvasion() && f != null && (f.getType() == this.Const.FactionType.Orcs || f.getType() == this.Const.FactionType.Goblins))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
				else if (this.World.FactionManager.isUndeadScourge() && f != null && (f.getType() == this.Const.FactionType.Undead || f.getType() == this.Const.FactionType.Zombies))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
				else if (this.World.FactionManager.isHolyWar() && f != null && (f.getType() == this.Const.FactionType.NobleHouse || f.getType() == this.Const.FactionType.OrientalCityState))
				{
					this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				}
			}

			if (this.World.Flags.get("IsGoblinCityScouts"))
			{
				if (this.World.FactionManager.getFaction(_entity.getFaction()).getType() == this.Const.FactionType.Goblins)
				{
					this.World.Flags.increment("GoblinCityCount", 1);
				}
			}

			this.World.Contracts.onPartyDestroyed(_entity);
			this.World.Ambitions.onPartyDestroyed(_entity);
		}
	}

	function manageAIFreeCompanies()
	{
		local garbage = [];

		foreach( i, fc in this.m.FreeCompanies )
		{
			if (fc.isNull() || !fc.isAlive())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.FreeCompanies.remove(g);
		}

		if (this.m.LastFreeCompanyUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastFreeCompanyUpdateTime = this.Time.getVirtualTimeF();
		local days = this.World.getTime().Days;
		local companies = 0;

		if (companies == 0)
		{
			return;
		}

		if (this.m.FreeCompanies.len() < companies)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local candidates = [];

			foreach( s in this.World.EntityManager.getSettlements() )
			{
				if (s.isIsolated())
				{
					continue;
				}

				if (s.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidates.push(s);
			}

			local themeSelect;
			local themeTable;
			local selectedND = false;

			if (this.Math.rand(0, 199) == 0 && days > 100)
			{
				do
				{
					themeSelect = this.Math.rand(0, this.Const.FreeCompanyOneTimeList.len() - 1);
				}
				while (this.m.NonDefaultFreeCompanies.find(themeSelect) && !(this.m.NonDefaultFreeCompanies.len() == this.Const.FreeCompanyOneTimeList.len()));

				if (this.m.NonDefaultFreeCompanies.len() == this.Const.FreeCompanyOneTimeList.len() - 1)
				{
				}
				else
				{
					this.m.NonDefaultFreeCompanies.push(themeSelect);
					selectedND = true;
				}
			}

			if (selectedND)
			{
				themeTable = this.Const.FreeCompanyOneTimeList[themeSelect];
			}
			else
			{
				themeTable = this.Const.FreeCompanyCoordinationList[this.Math.rand(0, this.Const.FreeCompanyCoordinationList.len() - 1)];
			}

			local start = candidates[this.Math.rand(0, candidates.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", start.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
			local description = "Description" in themeTable ? themeTable.Description : "A free company, out for their own share of crowns.";
			party.setDescription(description);
			local footprints = "FootprintsType" in themeTable ? themeTable.FootprintsType : "Mercenaries";
			party.setFootprintType(this.Const.World.FootprintsType[footprints]);
			party.getFlags().set("IsFreeCompany", true);
			party.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.FreeCompany).getID());
			local spawntype = "Spawn" in themeTable ? themeTable.Spawn : "FreeCompany";
			local r = this.World.State.getPlayer().getStrength();

			if (days > 100)
			{
				r = r + 50;
			}
			else if (days > 75)
			{
				r = r + 30;
			}
			else if (days > 50)
			{
				r = r + 10;
			}

			local r = this.Math.rand(r * 0.8, r * 1.5);

			if (days < 25)
			{
				this.Const.World.Common.assignTroops(party, this.Const.World.Spawn.FreeCompanyLow, r * 0.9);
			}
			else
			{
				this.Const.World.Common.assignTroops(party, this.Const.World.Spawn[spawntype], r);
			}

			if ("UnitOutfits" in themeTable)
			{
				foreach( troop in party.getTroops() )
				{
					foreach( uo in themeTable.UnitOutfits )
					{
						if (troop.ID == uo.Type)
						{
							troop.Outfits <- clone uo.Outfits;
						}
					}
				}
			}

			party.getLoot().Money = this.Math.rand(400, 800);
			party.getLoot().ArmorParts = this.Math.rand(10, 30);
			party.getLoot().Medicine = this.Math.rand(5, 15);
			party.getLoot().Ammo = this.Math.rand(10, 50);
			local items = "LootTable" in themeTable ? themeTable.LootTable : this.Const.FreeCompanyDefaultLootTable;

			for( local i = 0; i < 2; i = i )
			{
				party.addToInventory(items[this.Math.rand(0, items.len() - 1)]);
				i = ++i;
			}

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_mercenary_0" + this.Math.rand(1, 2));
			local nameList = clone themeTable.Names;

			while (true)
			{
				if (nameList.len() == 0)
				{
					nameList = clone this.Const.Strings.FreeCompanyNames;
					break;
				}

				local idx = this.Math.rand(0, themeTable.Names.len() - 1);
				local name = nameList[idx];

				if (name == this.World.Assets.getName())
				{
					nameList.remove(idx);
					continue;
				}

				local abort = false;

				foreach( p in this.m.FreeCompanies )
				{
					if (p.getName() == name)
					{
						nameList.remove(idx);
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.setName(name);
				break;
			}

			while (true)
			{
				local banner = this.Const.PlayerBanners[this.Math.rand(0, this.Const.PlayerBanners.len() - 1)];

				if (banner == this.World.Assets.getBanner())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.FreeCompanies )
				{
					if (p.getBanner() == banner)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.getSprite("banner").setBrush(banner);
				break;
			}

			this.m.FreeCompanies.push(this.WeakTableRef(party));
		}

		foreach( fc in this.m.FreeCompanies )
		{
			fc.updatePlayerRelation();

			if (!fc.getController().hasOrders())
			{
				local candidates = [];

				foreach( s in this.m.Settlements )
				{
					if (!s.isAlive() || s.isIsolated())
					{
						continue;
					}

					if (!s.isAlliedWith(fc))
					{
						continue;
					}

					if (s.getTile().ID == fc.getTile().ID)
					{
						continue;
					}

					candidates.push(s);
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local dest = candidates[this.Math.rand(0, candidates.len() - 1)];
				local c = fc.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(dest.getTile());
				move.setRoadsOnly(false);
				c.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(this.Math.rand(10, 60) * 1.0);
				c.addOrder(wait2);
				local fco = this.new("scripts/ai/world/orders/free_company_order");
				fco.setSettlement(dest);
				c.addOrder(fco);
			}
		}
	}

	function manageAIMercenaries()
	{
		local garbage = [];

		foreach( i, merc in this.m.Mercenaries )
		{
			if (merc.isNull() || !merc.isAlive())
			{
				garbage.push(i);
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.Mercenaries.remove(g);
		}

		if (this.m.LastMercUpdateTime + 3.0 > this.Time.getVirtualTimeF())
		{
			return;
		}

		this.m.LastMercUpdateTime = this.Time.getVirtualTimeF();

		if (this.m.Mercenaries.len() < 3 || this.World.FactionManager.isCivilWar() && this.m.Mercenaries.len() < 4)
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local candidates = [];

			foreach( s in this.World.EntityManager.getSettlements() )
			{
				if (s.isIsolated())
				{
					continue;
				}

				if (s.getTile().getDistanceTo(playerTile) <= 10)
				{
					continue;
				}

				candidates.push(s);
			}

			local start = candidates[::Math.rand(0, candidates.len() - 1)];
			local party = this.World.spawnEntity("scripts/entity/world/party", start.getTile().Coords);
			party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
			party.setDescription("A free mercenary company travelling the lands and lending their swords to the highest bidder.");
			party.setFootprintType(::Const.World.FootprintsType.Mercenaries);
			party.getFlags().set("IsMercenaries", true);

			if (start.getFactions().len() == 1)
			{
				party.setFaction(start.getOwner().getID());
			}
			else
			{
				party.setFaction(start.getFactionOfType(::Const.FactionType.Settlement).getID());
			}

			local r = ::Math.min(330, 150 + this.World.getTime().Days);
			::Const.World.Common.assignTroops(party, ::Const.World.Spawn.Mercenaries, ::Math.rand(r * 0.8, r));
			party.getLoot().Money = ::Math.rand(50, 200);
			party.getLoot().ArmorParts = ::Math.rand(0, 10);
			party.getLoot().Medicine = ::Math.rand(0, 10);
			party.getLoot().Ammo = ::Math.rand(0, 10);

			//FEATURE_9: chance for merc treasure??
			//FEATURE_9: chance for heroes??

			party.getSprite("base").setBrush("world_base_07");
			party.getSprite("body").setBrush("figure_mercenary_0" + ::Math.rand(1, 2));

			while (true)
			{
				local name = ::Const.Strings.MercenaryCompanyNames[::Math.rand(0, ::Const.Strings.MercenaryCompanyNames.len() - 1)];

				if (name == this.World.Assets.getName())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getName() == name)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.setName(name);
				break;
			}

			while (true)
			{
				local banner = ::Const.PlayerBanners[::Math.rand(0, ::Const.PlayerBanners.len() - 1)];

				if (banner == this.World.Assets.getBanner())
				{
					continue;
				}

				local abort = false;

				foreach( p in this.m.Mercenaries )
				{
					if (p.getBanner() == banner)
					{
						abort = true;
						break;
					}
				}

				if (abort)
				{
					continue;
				}

				party.getSprite("banner").setBrush(banner);
				break;
			}

			this.m.Mercenaries.push(this.WeakTableRef(party));
		}

		foreach( merc in this.m.Mercenaries )
		{
			merc.updatePlayerRelation();

			if (!merc.getController().hasOrders())
			{
				local candidates = [];

				foreach( s in this.m.Settlements )
				{
					if (!s.isAlive() || s.isIsolated())
					{
						continue;
					}

					if (!s.isAlliedWith(merc))
					{
						continue;
					}

					if (s.getTile().ID == merc.getTile().ID)
					{
						continue;
					}

					candidates.push(s);
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local dest = candidates[::Math.rand(0, candidates.len() - 1)];
				local c = merc.getController();
				local wait1 = this.new("scripts/ai/world/orders/wait_order");
				wait1.setTime(::Math.rand(10, 60) * 1.0);
				c.addOrder(wait1);
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(dest.getTile());
				move.setRoadsOnly(false);
				c.addOrder(move);
				local wait2 = this.new("scripts/ai/world/orders/wait_order");
				wait2.setTime(::Math.rand(10, 60) * 1.0);
				c.addOrder(wait2);
				local mercenary = this.new("scripts/ai/world/orders/mercenary_order");
				mercenary.setSettlement(dest);
				c.addOrder(mercenary);
			}
		}
	}

	function onSerialize( _out )
	{
		_out.writeI32(this.m.NextSituationID);
		local numMercs = 0;

		foreach( merc in this.m.Mercenaries )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				numMercs = ++numMercs;
				numMercs = numMercs;
			}
		}

		_out.writeU8(numMercs);

		foreach( merc in this.m.Mercenaries )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				_out.writeU32(merc.getID());
			}
		}

		local numMercs = 0;

		foreach( merc in this.m.FreeCompanies )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				numMercs = ++numMercs;
				numMercs = numMercs;
			}
		}

		_out.writeU8(numMercs);

		foreach( merc in this.m.FreeCompanies )
		{
			if (merc != null && !merc.isNull() && merc.isAlive())
			{
				_out.writeU32(merc.getID());
			}
		}

		_out.writeU8(this.m.NonDefaultFreeCompanies.len());

		foreach( fc in this.m.NonDefaultFreeCompanies )
		{
			_out.writeU8(fc);
		}
	}

	function onDeserialize( _in )
	{
		this.m.NextSituationID = _in.readI32();
		local numMercs = _in.readU8();

		for( local i = 0; i != numMercs; i = i )
		{
			local merc = this.World.getEntityByID(_in.readU32());

			if (merc != null)
			{
				this.m.Mercenaries.push(this.WeakTableRef(merc));
			}

			i = ++i;
		}

		if (_in.getMetaData().getVersion() >= 70)
		{
			local numMercs = _in.readU8();

			for( local i = 0; i != numMercs; i = i )
			{
				local merc = this.World.getEntityByID(_in.readU32());

				if (merc != null)
				{
					this.m.FreeCompanies.push(this.WeakTableRef(merc));
				}

				i = ++i;
			}
		}

		if (_in.getMetaData().getVersion() >= 72)
		{
			local numFC = _in.readU8();

			for( local i = 0; i != numFC; i = i )
			{
				this.m.NonDefaultFreeCompanies.push(_in.readU8());
				i = ++i;
			}
		}

		this.buildRoadAmbushSpots();
	}

};

