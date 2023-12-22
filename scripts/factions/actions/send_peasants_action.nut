this.send_peasants_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "send_peasants_action";
		this.m.Cooldown = 200.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.FactionManager.isGreaterEvil())
		{
			return;
		}

		if (_faction.isEnemyNearby())
		{
			return;
		}

		if (_faction.getUnits().len() >= 1)
		{
			return;
		}

		local mySettlements = _faction.getSettlements();
		local allSettlements = this.World.EntityManager.getSettlements();
		local destinations;

		if (!this.World.FactionManager.isGreaterEvil())
		{
			destinations = allSettlements;
		}
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

		if (settlements.len() < 2)
		{
			return;
		}

		this.m.Start = settlements[0];
		this.m.Dest = settlements[1];

		if (this.World.FactionManager.isGreaterEvil())
		{
			this.m.Score = 1;
		}
		else
		{
			this.m.Score = 5;
		}
	}

	function onClear()
	{
		this.m.Start = null;
		this.m.Dest = null;
	}

	function onExecute( _faction )
	{
		local party;

		if (_faction.getType() == ::Const.FactionType.OrientalCityState)
		{
			party = _faction.spawnEntity(this.m.Start.getTile(), "Citizens", false, ::Const.World.Spawn.PeasantsSouthern, ::Math.rand(30, 60));
			party.getSprite("body").setBrush("figure_civilian_06");
			party.setDescription("Farmers, craftsmen, pilgrims or other citizens of the great city states on their way between settlements.");
		}
		else
		{
			party = _faction.spawnEntity(this.m.Start.getTile(), "Peasants", false, ::Const.World.Spawn.Peasants, ::Math.rand(30, 60));
			party.getSprite("body").setBrush("figure_civilian_0" + ::Math.rand(1, 5));
			party.setDescription("Farmers, craftsmen, pilgrims or other peasants on their way between settlements.");
		}

		party.setFootprintType(::Const.World.FootprintsType.Peasants);
		party.getSprite("banner").Visible = false;
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = ::Math.rand(0, 50);

		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			local resources = ::Math.max(1, ::Math.round(0.01 * this.m.Start.getResources()));
			this.m.Start.setResources(this.m.Start.getResources() - resources);
			party.setResources(resources);
		}

		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);
		local unload = this.new("scripts/ai/world/orders/unload_order");
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(unload);
		c.addOrder(despawn);
	}

});

