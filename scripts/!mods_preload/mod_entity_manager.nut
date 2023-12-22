this.getroottable().Const.LegendMod.hookEntityManager <- function ()
{
	::mods_hookNewObject("entity/world/entity_manager", function ( o )
	{
		o.manageAIMercenaries = function()
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
	});
	delete ::Const.LegendMod.hookEntityManager;
};

