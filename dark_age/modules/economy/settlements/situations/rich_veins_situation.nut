::mods_hookExactClass("entity/world/settlements/situations/rich_veins_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.BuyPriceMult *= 1.1;
		_modifiers.MineralRarityMult = 1.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");



	}

});

