::mods_hookExactClass("entity/world/settlements/buildings/taxidermist_building", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_list.push("anatomist_background");
	}

});
