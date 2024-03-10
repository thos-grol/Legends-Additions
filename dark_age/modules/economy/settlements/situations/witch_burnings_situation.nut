::mods_hookExactClass("entity/world/settlements/situations/witch_burnings_situation", function(o) {
	o.onRemoved = function( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 1.35;
		_modifiers.FoodPriceMult *= 1.15;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("historian_background");
	}

});

