::mods_hookExactClass("entity/world/settlements/buildings/temple_building", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_list.push("monk_background");
		_list.push("cripple_background");
		_list.push("paladin_background");
	}

});
