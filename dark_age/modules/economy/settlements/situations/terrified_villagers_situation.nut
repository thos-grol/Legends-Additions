::mods_hookExactClass("entity/world/settlements/situations/terrified_villagers_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RecruitsMult *= 0.8;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("gravedigger_background");
		_draftList.push("gravedigger_background");
		_draftList.push("gravedigger_background");
		_draftList.push("gravedigger_background");
		_draftList.push("graverobber_background");
		_draftList.push("graverobber_background");
	}

});

