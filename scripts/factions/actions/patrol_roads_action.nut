this.patrol_roads_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Settlements = null
	},
	function create()
	{
		this.m.ID = "patrol_roads_action";
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

		local settlements = _faction.getSettlements();

		if (settlements.len() < 3)
		{
			return;
		}

		if (!_faction.isReadyToSpawnUnit())
		{
			return;
		}

		local settlements = this.getRandomConnectedSettlements(3, settlements);

		if (settlements.len() < 3)
		{
			return;
		}

		this.m.Settlements = settlements;
		this.m.Score = 10;
	}

	function onClear()
	{
		this.m.Settlements = null;
	}

	function onExecute( _faction )
	{
		local waypoints = [];

		for( local i = 0; i != 3; i = i )
		{
			local idx = ::Math.rand(0, this.m.Settlements.len() - 1);
			local wp = this.m.Settlements[idx];
			this.m.Settlements.remove(idx);
			waypoints.push(wp);
			i = ++i;
		}

		local party = this.getFaction().spawnEntity(waypoints[0].getTile(), waypoints[0].getName() + " Company", true, ::Const.World.Spawn.Noble, ::Math.rand(120, 250) * this.getReputationToDifficultyLightMult());
		party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
		party.setDescription("Professional soldiers in service to local lords.");
		party.setFootprintType(::Const.World.FootprintsType.Nobles);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().Money = ::Math.rand(0, 50);
		party.getLoot().ArmorParts = ::Math.rand(0, 25);
		party.getLoot().Medicine = ::Math.rand(0, 3);
		party.getLoot().Ammo = ::Math.rand(0, 30);
		local r = ::Math.rand(1, 4);

		if (r == 1)
		{
			party.addToInventory("supplies/bread_item");
		}
		else if (r == 2)
		{
			party.addToInventory("supplies/roots_and_berries_item");
		}
		else if (r == 3)
		{
			party.addToInventory("supplies/dried_fruits_item");
		}
		else if (r == 4)
		{
			party.addToInventory("supplies/ground_grains_item");
		}

		local c = party.getController();
		local move1 = this.new("scripts/ai/world/orders/move_order");
		move1.setRoadsOnly(true);
		move1.setDestination(waypoints[1].getTile());
		local wait1 = this.new("scripts/ai/world/orders/wait_order");
		local r = ::Math.rand(5, 40);
		wait1.setTime(r);
		local move2 = this.new("scripts/ai/world/orders/move_order");
		move2.setRoadsOnly(true);
		move2.setDestination(waypoints[2].getTile());
		local wait2 = this.new("scripts/ai/world/orders/wait_order");
		local r = ::Math.rand(5, 40);
		wait2.setTime(r);
		local move3 = this.new("scripts/ai/world/orders/move_order");
		move3.setRoadsOnly(true);
		move3.setDestination(waypoints[0].getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move1);
		c.addOrder(wait1);
		c.addOrder(move2);
		c.addOrder(wait2);
		c.addOrder(move3);
		c.addOrder(despawn);
		this.m.Cooldown = this.World.FactionManager.isGreaterEvil() ? 150.0 : 300.0;
		return true;
	}

});

