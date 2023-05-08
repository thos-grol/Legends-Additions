::mods_hookExactClass("entity/world/attached_location/surface_copper_vein_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/copper_ingots_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("caravan_hand_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/copper_ingots_item"
			});
			_list.push({
				R = 25,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			});
			_list.push({
				R = 25,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			break;

		default:
			if (_id == "building.specialized_trader")
			{
			}
		}
	}

});

