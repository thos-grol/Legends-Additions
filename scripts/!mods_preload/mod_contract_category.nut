local gt = this.getroottable();
gt.Const.Contracts.Categories <- {
	Economy = "Economy",
	Battle = "Battle",
	Hunt = "Hunt",
	Legendary = "Legendary"
};
gt.Const.Contracts.CategoryLimits <- {
	Economy = [
		1,
		1,
		1
	],
	Battle = [
		1,
		1,
		1
	],
	Hunt = [
		1,
		1,
		1
	],
	Legendary = [
		1,
		1,
		1
	],
	Wildcard = [
		1,
		2,
		3
	]
};
gt.Const.Contracts.ContractCategoryMap <- {
	deliver_item_contract = this.Const.Contracts.Categories.Economy,
	deliver_money_contract = this.Const.Contracts.Categories.Economy,
	escort_caravan_contract = this.Const.Contracts.Categories.Economy,
	obtain_item_contract = this.Const.Contracts.Categories.Economy,
	restore_location_contract = this.Const.Contracts.Categories.Economy,
	return_item_contract = this.Const.Contracts.Categories.Economy,
	defend_settlement_bandits_contract = this.Const.Contracts.Categories.Battle,
	defend_settlement_greenskins_contract = this.Const.Contracts.Categories.Battle,
	discover_location_contract = this.Const.Contracts.Categories.Battle,
	drive_away_bandits_contract = this.Const.Contracts.Categories.Battle,
	drive_away_barbarians_contract = this.Const.Contracts.Categories.Battle,
	investigate_cemetery_contract = this.Const.Contracts.Categories.Battle,
	hunting_alps_contract = this.Const.Contracts.Categories.Hunt,
	hunting_hexen_contract = this.Const.Contracts.Categories.Hunt,
	hunting_lindwurms_contract = this.Const.Contracts.Categories.Hunt,
	hunting_schrats_contract = this.Const.Contracts.Categories.Hunt,
	hunting_unholds_contract = this.Const.Contracts.Categories.Hunt,
	hunting_webknechts_contract = this.Const.Contracts.Categories.Hunt,
	roaming_beasts_contract = this.Const.Contracts.Categories.Hunt,
	legend_bandit_army_contract = this.Const.Contracts.Categories.Legendary,
	legend_barbarian_prisoner_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_coven_leader_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_demon_alps_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_greenwood_schrats_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_redback_webknechts_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_rock_unholds_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_skin_ghouls_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_stollwurms_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_white_direwolf_contract = this.Const.Contracts.Categories.Legendary,

	return_item_contract2 <- ::Const.Contracts.Categories.Economy,
};
gt.Const.Contracts.ContractCategoryIconMap <- {
	Economy = "ui/icons/contract_type_economy",
	Battle = "ui/icons/contract_type_battle",
	Hunt = "ui/icons/contract_type_hunt",
	Legendary = ""
};
this.getroottable().Const.LegendMod.hookContractCategory <- function ()
{
	foreach( key, value in gt.Const.Contracts.ContractCategoryMap )
	{
		local script = "contracts/contracts/" + key;
		local cat = gt.Const.Contracts.ContractCategoryMap[key];
		::mods_hookNewObject(script, function ( o )
		{
			o.m.Category = cat;
		});
		  // [019]  OP_CLOSE          0      5    0    0
	}

	delete $[stack offset 0].Const.LegendMod.hookContractCategory;
};

