::mods_hookExactClass("entity/world/settlements/situations/cultist_procession_situation", function(o) {
	o.onRemoved = function( _settlement )
	{
		_settlement.resetRoster(true);
	}

	o.onUpdate = function( _modifiers )
	{
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

	}

});

