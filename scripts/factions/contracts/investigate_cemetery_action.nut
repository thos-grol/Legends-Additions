this.investigate_cemetery_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Target = null
	},
	function create()
	{
		this.m.ID = "investigate_cemetery_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 9;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.investigate_cemetery_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		if (!this.World.FactionManager.isUndeadScourge() && this.World.getTime().Days > 3 && ::Math.rand(1, 100) > 75)
		{
			return;
		}

		local myTile = _faction.getSettlements()[0].getTile();
		this.m.Target = null;
		local undead = this.World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getSettlements();

		foreach( b in undead )
		{
			if (myTile.getDistanceTo(b.getTile()) < 15 && (b.getTypeID() == "location.undead_graveyard" || b.getTypeID() == "location.undead_crypt"))
			{
				this.m.Target = b;
				break;
			}
		}

		if (this.m.Target == null)
		{
			return;
		}

		this.m.Score = 1;

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition")
		{
			this.m.Score = 10;
		}
	}

	function onClear()
	{
		this.m.Target = null;
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/investigate_cemetery_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setDestination(this.m.Target);
		this.World.Contracts.addContract(contract);
	}

});

