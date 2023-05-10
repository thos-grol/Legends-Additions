::mods_hookExactClass("entity/world/attached_location/surface_iron_vein_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("legend_ironmonger_background");
		_list.push("retired_soldier_background");
	}

	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/iron_ingots_item");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
			case "building.marketplace":
				_list.push({
					R = 25,
					P = 0.9,
					S = "supplies/armor_parts_item"
				});
				_list.push({
					R = 25,
					P = 0.9,
					S = "trade/iron_ingots_item"
				});
				break;

		}
	}

});

