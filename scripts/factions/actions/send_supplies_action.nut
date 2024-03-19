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
			this.m.Start = starts[::Math.rand(0, starts.len() - 1)];
			this.m.Dest = dests[::Math.rand(0, dests.len() - 1)];

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
		if (_settlement == null) return ::Math.rand(100, 200);
		if (_faction.hasTrait(::Const.FactionTrait.OrientalCityState))
		{
			return ::Math.round(1.5 * (::Math.rand(90, 137) + ::Math.round(0.12 * ::Math.max(1, _settlement.getResources()))));
		}
		return ::Math.round(1.5 * (::Math.rand(60, 110) + ::Math.round(0.1 * ::Math.max(1, _settlement.getResources()))));
	}

	function onExecute( _faction )
	{
		local modifier = ::Math.rand(50, 200);
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Supply Caravan", false, this.pickSpawnList(this.m.Start, _faction, modifier), this.getResourcesForParty(this.m.Start, _faction));
		party.getSprite("body").setBrush(::Const.World.Spawn.NobleCaravan.Body);
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A caravan with armed escorts transporting provisions, supplies and equipment between settlements.");
		party.setFootprintType(::Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getFlags().set("Modifier", modifier);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		this.addLoot(party);

		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			::Const.World.Common.WorldEconomy.Trade.setupTrade(party, this.m.Start, this.m.Dest);
		}
		else
		{
			this.addToPartyInventory(party);
		}

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
		if (_modifier >= 150) return ::Const.World.Spawn.NobleCaravan;
		if (::Math.rand(1,100) <= 50) return ::Const.World.Spawn.MixedNobleCaravan;
		return ::Const.World.Spawn.MixedNobleCaravan;
	}

	function addLoot( _party )
	{
		switch(::Math.rand(1, 3))
		{
		case 1:
			_party.getLoot().ArmorParts = ::Math.rand(0, 30);
			break;

		case 2:
			_party.getLoot().Medicine = ::Math.rand(0, 30);
			break;

		default:
			_party.getLoot().Ammo = ::Math.rand(0, 30);
		}

		_party.getLoot().Money = ::Math.floor(::Math.rand(50, 200));
	}

	function addToPartyInventory( _party )
	{
		// switch(::Math.rand(1, 4))
		// {
		// 	case 1:
		// 		_party.addToInventory("supplies/bread_item");
		// 		break;

		// 	case 2:
		// 		_party.addToInventory("supplies/roots_and_berries_item");
		// 		break;

		// 	case 3:
		// 		_party.addToInventory("supplies/dried_fruits_item");
		// 		break;

		// 	default:
		// 		_party.addToInventory("supplies/ground_grains_item");
		// }
	}

	function afterSpawnCaravan( _party )
	{
	}

});

