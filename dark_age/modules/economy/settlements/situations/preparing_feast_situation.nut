::mods_hookExactClass("entity/world/attached_location/preparing_feast_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.25;
		_modifiers.FoodPriceMult *= 2.0;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
		_draftList.push("servant_background");
		_draftList.push("servant_background");
		_draftList.push("servant_background");
		_draftList.push("eunuch_background");
	}

});

