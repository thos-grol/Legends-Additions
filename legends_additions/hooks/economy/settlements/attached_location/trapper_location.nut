::mods_hookExactClass("entity/world/attached_location/trapper_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/furs_item");
		_list.push("trade/tin_ingots_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("peddler_background");
		_list.push("caravan_hand_background");
		_list.push("poacher_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/furs_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/hunting_bow"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_shiv"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_stake"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "tools/throwing_net"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_hunter"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/legend_chain"
			});
			break;

		default:
			if (_id == "building.specialized_trader")
			{
			}
		}
	}

});

