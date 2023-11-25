::mods_hookExactClass("entity/world/attached_location/collectors_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.BeastPartsPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 1.25;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{

	}

});

