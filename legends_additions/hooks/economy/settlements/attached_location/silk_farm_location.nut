::mods_hookExactClass("entity/world/attached_location/silk_farm_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/silk_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("daytaler_southern_background");
		_list.push("daytaler_southern_background");
		_list.push("legend_muladi_background");

		if (_gender)
		{
			_list.push("legend_qiyan_background");
			_list.push("legend_qiyan_background");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_scrap"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_repair"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/silk_item"
			});
		}
	}

	o.getNewResources = function()
	{
		return 2;
	}

});

