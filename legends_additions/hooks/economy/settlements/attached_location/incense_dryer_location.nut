::mods_hookExactClass("entity/world/attached_location/incense_dryer_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/incense_item");
		_list.push("supplies/armor_parts_small_item");
		_list.push("supplies/medicine_small_item");
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
		_list.push("legend_dervish_background");
		_list.push("legend_alchemist_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/incense_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_enchant"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_craft"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
		}
	}

});

