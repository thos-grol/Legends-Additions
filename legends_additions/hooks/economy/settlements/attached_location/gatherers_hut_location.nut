::mods_hookExactClass("entity/world/attached_location/gatherers_hut_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/roots_and_berries_item");
		_list.push("trade/legend_cooking_spices_trade_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("legend_herbalist_background");
		_list.push("legend_herbalist_background");
		_list.push("daytaler_background");
		_list.push("daytaler_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/roots_and_berries_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "misc/legend_mistletoe_item"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "supplies/legend_pudding_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/bludgeon"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_sickle"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_gather"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_heal"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/medicine_item"
			});
		}

		if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 99,
				P = 1.0,
				S = "weapons/named/legend_named_sickle"
			});
			_list.push({
				R = 99,
				P = 1.0,
				S = "weapons/named/legend_named_shovel"
			});
		}
	}

});

