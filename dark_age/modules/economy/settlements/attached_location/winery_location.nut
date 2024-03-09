::mods_hookExactClass("entity/world/attached_location/winery_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/wine_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive()) return;

		_list.push("brawler_background");
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
				break;
		}
	}

});
