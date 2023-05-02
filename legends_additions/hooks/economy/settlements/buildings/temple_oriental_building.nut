::mods_hookExactClass("entity/world/settlements/buildings/temple_oriental_building.nut", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_list.push("cripple_southern_background");
		_list.push("legend_dervish_background");
	}

});

