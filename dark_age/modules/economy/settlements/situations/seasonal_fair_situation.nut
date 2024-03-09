::mods_hookExactClass("entity/world/settlements/situations/seasonal_fair_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.PriceMult *= 1.25;
		_modifiers.RarityMult *= 1.25;
		_modifiers.FoodRarityMult *= 1.25;
		_modifiers.MedicalRarityMult *= 1.25;
		_modifiers.RecruitsMult *= 1.25;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		_draftList.push("juggler_background");
		_draftList.push("juggler_background");
		_draftList.push("juggler_background");

	}

});

