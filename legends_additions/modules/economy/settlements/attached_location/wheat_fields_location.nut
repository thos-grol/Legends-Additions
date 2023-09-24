::mods_hookExactClass("entity/world/attached_location/wheat_fields_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/bread_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		if (!this.isActive()) return;

		_list.push("farmhand_background");
		_list.push("farmhand_background");
		_list.push("farmhand_background");
		
		_list.push("daytaler_background");
		_list.push();
		_list.push("miller_background");
		
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/bread_item"
			});
			_list.push({
				R = 1,
				P = 1.0,
				S = "supplies/ground_grains_item"
			});
		}
	}

	o.getNewResources = function()
	{
		return 2;
	}

});

