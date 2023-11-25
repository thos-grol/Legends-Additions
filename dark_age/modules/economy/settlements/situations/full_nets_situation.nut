::mods_hookExactClass("entity/world/attached_location/full_nets_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 2.0;
		_modifiers.FoodPriceMult *= 0.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("fisherman_background");
		_draftList.push("fisherman_background");
		_draftList.push("fisherman_background");
		_draftList.push("fisherman_background");
		_draftList.push("fisherman_background");
		_draftList.push("fisherman_background");
	}

});

