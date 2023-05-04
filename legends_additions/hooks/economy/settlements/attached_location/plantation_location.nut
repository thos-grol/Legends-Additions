::mods_hookExactClass("entity/world/attached_location/plantation_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/spices_item");
		_list.push("supplies/medicine_small_item");
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
			_list.push("legend_qiyan_background");
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
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/dates_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_heal"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_gather"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
		}
	}

	o.getNewResources = function()
	{
		return 2;
	}

});

