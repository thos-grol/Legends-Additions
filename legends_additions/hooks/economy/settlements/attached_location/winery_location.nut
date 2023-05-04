::mods_hookExactClass("entity/world/attached_location/winery_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/wine_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("monk_background");
		_list.push("brawler_background");
		_list.push("caravan_hand_background");

		if (_gender)
		{
			_list.push("legend_nun_background");
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
				S = "supplies/wine_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "supplies/roots_and_berries_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_sickle"
			});
			break;

		default:
			if (_id == "building.specialized_trader")
			{
			}
		}
	}

});
