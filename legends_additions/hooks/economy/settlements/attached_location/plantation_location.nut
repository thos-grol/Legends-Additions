::mods_hookExactClass("entity/world/attached_location/plantation_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/spices_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("slave_southern_background");
		_list.push("slave_southern_background");

		if (_gender)
		{
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/spices_item"
			});	
		}
	}

	o.getNewResources = function()
	{
		return 2;
	}

});

