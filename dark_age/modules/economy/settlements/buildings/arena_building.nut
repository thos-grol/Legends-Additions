::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o) {

	o.onClicked = function( _townScreen )
	{
		return;
	}


	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_list.push("gladiator_background");
		_list.push("gladiator_background");
		_list.push("gladiator_background");
		_list.push("gladiator_background");
	}

});
