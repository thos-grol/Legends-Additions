::mods_hookExactClass("entity/world/settlements/situations/hunting_season_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 2.0;
		_modifiers.FoodPriceMult *= 0.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
	}

});

