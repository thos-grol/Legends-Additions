::mods_hookExactClass("entity/world/attached_location/fishing_huts_oriental_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		if (!this.isActive()) return;

		_list.push("fisherman_southern_background");
		_list.push("fisherman_southern_background");
		_list.push("fisherman_southern_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
	}

});

