this.send_caravan_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "send_caravan_action";
		this.m.Cooldown = 300.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime) return;
		if (_faction.isEnemyNearby()) return;
		if (_faction.getUnits().len() >= 1) return;

		local mySettlements = _faction.getSettlements();
		local allSettlements = this.World.EntityManager.getSettlements();
		local destinations;

		if (!this.World.FactionManager.isGreaterEvil()) destinations = allSettlements;
		else
		{
			destinations = [];

			foreach( s in allSettlements )
			{
				if (s.getOwner() == null || s.getOwner().isAlliedWith(_faction.getID()))
				{
					destinations.push(s);
				}
			}
		}

		local settlements = this.getRandomConnectedSettlements(2, mySettlements, destinations, true);

		if (settlements.len() < 2) return;
		this.m.Start = settlements[0];
		this.m.Dest = settlements[1];
		this.m.Score = 5;
	}

	function onClear()
	{
		this.m.Start = null;
		this.m.Dest = null;
	}

	function getReputationToDifficultyLightMult()
	{
		return 2.0 * (this.World.FactionManager.isCivilWar() ? 1.1 : 1.0);
	}

	function getResourcesForParty( _settlement, _faction, _modifier )
	{
		if (_settlement == null) return ::Math.rand(100, 200);
		if (_faction.hasTrait(::Const.FactionTrait.OrientalCityState))
		{
			return ::Math.round( _modifier * 0.01 * 1.5 * (::Math.rand(90, 137) + ::Math.round(0.12 * ::Math.max(1, _settlement.getResources()))));
		}
		return ::Math.round( _modifier * 0.01 * 1.5 * (::Math.rand(60, 110) + ::Math.round(0.12 * ::Math.max(1, _settlement.getResources()))));
	}

	function onExecute( _faction )
	{
		local modifier = ::Math.rand(50, 200);
		local tier = ::Math.rand(1,2);
		if (modifier > 75) tier++;
		if (modifier > 150) tier++;
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.pickSpawnList(this.m.Start, _faction, modifier), this.getResourcesForParty(this.m.Start, _faction, modifier));

		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A trading caravan from " + this.m.Start.getName() + " that is transporting all manner of goods between settlements.");
		party.setFootprintType(::Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getFlags().set("tier", tier);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		this.addLoot(party);
		::Const.World.Common.WorldEconomy.Trade.setupTrade(party, this.m.Start, this.m.Dest);
		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);
		local unload = this.new("scripts/ai/world/orders/unload_order");
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(unload);
		c.addOrder(despawn);
		this.afterSpawnCaravan(party);
	}

	function pickSpawnList( _settlement, _faction, _modifier )
	{
		if (_faction.hasTrait(::Const.FactionTrait.OrientalCityState))
		{
			if (_modifier <= 75) return ::Const.World.Spawn.CaravanSouthern;
			if (_modifier <= 150) return ::Const.World.Spawn.CaravanSouthernMedium;
			return ::Const.World.Spawn.CaravanSouthernHard;
			//TODO: possible hero merc companies escorting caravan
		}

		if (_modifier <= 75) return ::Const.World.Spawn.Caravan;
		if (_modifier <= 150) return ::Const.World.Spawn.CaravanMedium;
		return ::Const.World.Spawn.CaravanHard;

			//TODO: possible hero merc companies escorting caravan

	}

	function addLoot( _party )
	{
		if (::Math.rand(1, 2) <= 1) _party.getLoot().ArmorParts = ::Math.rand(0, 5);
		if (::Math.rand(1, 2) <= 1) _party.getLoot().Medicine = ::Math.rand(0, 3);
		if (::Math.rand(1, 2) <= 1) _party.getLoot().Ammo = ::Math.rand(0, 10);
		_party.getLoot().Money = ::Math.rand(25, 75);
	}

	function addToPartyInventory( _party )
	{
	}

	function afterSpawnCaravan( _party )
	{
	}

});

