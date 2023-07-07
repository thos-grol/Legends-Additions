this.update_settlement_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "update_settlement_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		this.m.Score = 999999;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local settlements = _faction.getSettlements();
		if (settlements[0].isIsolated()) return;

		updateHouseKeeping (_faction);

		//update contracts
		updateCaravan(_faction);
			//interact with nearby factions
				//update bandits
				//update beasts
				//update necro
				//cultist faction strength is a world flag, once flag reaches enough strength (from contracts), has a chance to roll and set cultist property on settlement. If settlement, cultist strength reaches critical mass, trigger cultist crisis.

		//OTHER military faction is supressing orcs undead etc
	}

	function updateHouseKeeping ( _faction )
	{

	}

	//contracts
	function updateCaravan( _faction )
	{
		if (this.Math.rand(1, 100) <= 85) return;

		local settlements = this.World.EntityManager.getSettlements();
		local mySettlement = _faction.getSettlements()[0];
		local candidates = 0;

		foreach( s in settlements )
		{
			if (s.getID() == mySettlement.getID()) continue;
			if (!s.isAlliedWith(_faction.getID())) continue;
			if (mySettlement.isIsolated() || s.isIsolated() || !mySettlement.isConnectedToByRoads(s) || mySettlement.isCoastal() && s.isCoastal()) continue;

			local d = s.getTile().getDistanceTo(mySettlement.getTile());

			if (d <= 12 || d > 100) continue;
			candidates = ++candidates;
			break;
		}

		if (candidates == 0) return;
		local contract = this.new("scripts/contracts/contracts/escort_caravan_contract");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setOrigin(_faction.getSettlements()[0]);
		contract.setup();
		this.World.Contracts.addContract(contract);
	}

	function updateBandits( _faction )
	{
		//check for nearby bandit faction
		if (_faction.getSettlements()[0].isIsolated()) return;
		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();
		if (tooFar)
		{
			local bandits = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getSettlements();
			foreach( b in bandits )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 20)
				{
					tooFar = false;
					break;
				}
			}
		}
		if (tooFar) return;

		local bandit_camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(this.m.Home.getTile());

		//local _faction_bandit =
		//If bandits are weaker open up contract to destroy bandit den
		if (bandit_camp.getFlags().get("Power") <= 20)
		{
			//Found their den, and weak enough to kill
			//Reputation requirement
			//if (this.World.Assets.getBusinessReputation() < 500) return;
			//Power requirement is 40 or lower
			local contract = this.new("scripts/contracts/contracts/drive_away_bandits_contract");
			contract.setFaction(_faction.getID());
			contract.setHome(_faction.getSettlements()[0]);
			contract.setEmployerID(_faction.getRandomCharacter().getID());
			this.World.Contracts.addContract(contract);
			return;
		}

		local locations = _faction.getSettlements()[0].getAttachedLocations();
		local targets = 0;
		foreach( l in locations )
		{
			if (l.isActive() && l.isMilitary()) return;
			if (l.isUsable()) targets = ++targets;
		}
		if (targets >= 2 && bandit_camp.getFlags().get("Power") > 40 && this.Math.rand(1, 100) <= 50)
		{
			//Raid settlement
			local contract = this.new("scripts/contracts/contracts/defend_settlement_bandits_contract");
			contract.setFaction(_faction.getID());
			contract.setHome(_faction.getSettlements()[0]);
			contract.setEmployerID(_faction.getRandomCharacter().getID());
			this.World.Contracts.addContract(contract);
			//if successful, celebrate
			//if unsuccessful, put situation raided, destroy attached locations, increase bandit camp power
			return;
		}

		//Bounty, men have been spotted near the city. Find them and return with the bandit leader's head.
		//New contract, kill bandit leader
		//Reputation requirement
		//if (this.World.Assets.getBusinessReputation() < 500) return;
		//if unsuccessful, increase bandit camp power

		bandit_camp.getFlags().set("Power", bandit_camp.getFlags().get("Power") + 10);
	}

});

