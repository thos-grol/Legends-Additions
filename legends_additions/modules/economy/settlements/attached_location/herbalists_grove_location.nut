::mods_hookExactClass("entity/world/attached_location/herbalists_grove_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/medicine_item");
		_list.push("supplies/medicine_small_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive()) return;

		_list.push("legend_herbalist_background");
		_list.push("legend_herbalist_background");
		_list.push("legend_herbalist_background");

		if (_gender)
		{
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
			case "building.marketplace":
				_list.push({
					R = 0,
					P = 1.0,
					S = "supplies/medicine_item"
				});
				_list.push({
					R = 0,
					P = 1.0,
					S = "supplies/medicine_small_item"
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
					R = 20,
					P = 1.0,
					S = "weapons/legend_sickle"
				});
				break;
		}
	}

});

