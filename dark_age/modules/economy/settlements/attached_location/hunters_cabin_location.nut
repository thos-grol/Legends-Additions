::mods_hookExactClass("entity/world/attached_location/hunters_cabin_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		// _list.push("supplies/legend_fresh_meat_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("butcher_background");
		_list.push("butcher_background");
		_list.push("hunter_background");
		_list.push("hunter_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			// _list.push({
			// 	R = 0,
			// 	P = 1.0,
			// 	S = "supplies/legend_fresh_meat_item"
			// });
		}
	}

});
