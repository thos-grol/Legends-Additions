::Const.Contracts.ContractCategoryMap.return_item_contract2 <- ::Const.Contracts.Categories.Economy;
this.return_item_action2 <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "return_item_action2";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.return_item_contract2)) return;
		if (_faction.getSettlements()[0].isIsolatedFromRoads()) return;

		if (this.Math.rand(1, 100) > 9) return;
		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/return_item_contract2");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

