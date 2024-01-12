this.defend_settlement_bandits_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "defend_settlements_bandits_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 5;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.defend_settlement_bandits_contract)) return;
		if (_faction.getSettlements()[0].isIsolated()) return;
		if (this.World.Assets.getBusinessReputation() < 250) return;
		if (::Math.rand(1, 100) > 15) return;

		local locations = _faction.getSettlements()[0].getAttachedLocations();
		local targets = 0;

		foreach( l in locations )
		{
			if (l.isActive() && l.isMilitary())
			{
				return;
			}

			if (l.isUsable())
			{
				targets = ++targets;
				targets = targets;
			}
		}

		if (targets < 2)
		{
			return;
		}

		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();

		if (tooFar)
		{
			local bandits = this.World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getSettlements();

			foreach( b in bandits )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 20)
				{
					tooFar = false;
					break;
				}
			}
		}

		if (tooFar)
		{
			local zombies = this.World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getSettlements();

			foreach( b in zombies )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 20)
				{
					tooFar = false;
					break;
				}
			}
		}

		if (tooFar)
		{
			return;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/defend_settlement_bandits_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

