::mods_hookExactClass("entity/world/settlements/situations/ceremonial_season_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.IncensePriceMult *= 1.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

	}

});

