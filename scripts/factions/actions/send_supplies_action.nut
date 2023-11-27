this.send_supplies_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function create()
	{
		this.m.ID = "send_supplies_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 3;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (!_faction.isReadyToSpawnUnit())
		{
			return;
		}

		local starts = [];
		local dests = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.isIsolatedFromRoads())
			{
				continue;
			}

			if (s.isMilitary())
			{
				dests.push(s);
			}
			else if (!(s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF()))
			{
				starts.push(s);
			}
		}

		if (starts.len() != 0 && dests.len() != 0)
		{
			this.m.Start = starts[this.Math.rand(0, starts.len() - 1)];
			this.m.Dest = dests[this.Math.rand(0, dests.len() - 1)];

			if (this.m.Start.isConnectedToByRoads(this.m.Dest))
			{
				this.m.Score = 5;
			}
			else
			{
				this.m.Start = null;
				this.m.Dest = null;
				return;
			}
		}
	}

	function onClear()
	{
		this.m.Start = null;
		this.m.Dest = null;
	}

	function getReputationToDifficultyLightMult()
	{
		return this.faction_action.getReputationToDifficultyLightMult() * (this.World.FactionManager.isCivilWar() ? 1.1 : 1.0);
	}

	function getResourcesForParty( _settlement, _faction )
	{
		if (_settlement == null)
		{
			return this.Math.rand(100, 200) * this.getReputationToDifficultyLightMult();
		}

		return (this.Math.rand(87, 135) + this.Math.round(0.11 * ::Math.max(1, _settlement.getResources()))) * this.getReputationToDifficultyLightMult();
	}

	function onExecute( _faction )
	{
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Supply Caravan", false, this.pickSpawnList(this.m.Start, _faction), this.getResourcesForParty(this.m.Start, _faction));
		party.getSprite("body").setBrush(this.Const.World.Spawn.NobleCaravan.Body);
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		this.addLoot(party);

		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			::Const.World.Common.WorldEconomy.setupTrade(party, this.m.Start, this.m.Dest);
		}
		else
		{
			this.addToPartyInventory(party);
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
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

	function pickSpawnList( _settlement, _faction )
	{
		switch(::Math.rand(1, 4))
		{
		case 1:
			return this.Const.World.Spawn.Mercenaries;

		case 2:
			return this.Const.World.Spawn.MixedNobleCaravan;
		}

		return this.Const.World.Spawn.NobleCaravan;
	}

	function addLoot( _party )
	{
		switch(::Math.rand(1, 3))
		{
		case 1:
			_party.getLoot().ArmorParts = this.Math.rand(15, 30);
			break;

		case 2:
			_party.getLoot().Medicine = this.Math.rand(20, 40);
			break;

		default:
			_party.getLoot().Ammo = this.Math.rand(75, 150);
		}

		_party.getLoot().Money = this.Math.floor(this.Math.rand(0, 100) * this.Math.rand(100, 200) * 0.01);
	}

	function addToPartyInventory( _party )
	{
		switch(::Math.rand(1, 4))
		{
		case 1:
			_party.addToInventory("supplies/bread_item");
			break;

		case 2:
			_party.addToInventory("supplies/roots_and_berries_item");
			break;

		case 3:
			_party.addToInventory("supplies/dried_fruits_item");
			break;

		default:
			_party.addToInventory("supplies/ground_grains_item");
		}
	}

	function afterSpawnCaravan( _party )
	{
	}

});

