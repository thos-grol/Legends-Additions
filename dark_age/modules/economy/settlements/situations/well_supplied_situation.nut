::mods_hookExactClass("entity/world/settlements/situations/well_supplied_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.PriceMult *= 0.9;
		_modifiers.RarityMult *= 1.5;
	}

	o.onUpdateDraftList <- function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("historian_background");
		_draftList.push("adventurous_noble_background");

		if (_gender)
		{
			_draftList.push("female_adventurous_noble_background");
		}
	}

});

