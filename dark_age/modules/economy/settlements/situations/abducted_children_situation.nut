::mods_hookExactClass("entity/world/attached_location/abducted_children_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		// _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		// //_draftList.push("witchhunter_background"); //FEATURE_9: rework witchunter?
	}

});

