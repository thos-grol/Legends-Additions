::mods_hookExactClass("entity/world/attached_location/goat_herd_oriental_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("daytaler_southern_background");
		_list.push("shepherd_southern_background");
		_list.push("shepherd_southern_background");
		_list.push("shepherd_southern_background");
		_list.push("shepherd_southern_background");
		_list.push("legend_muladi_background");
		_list.push("legend_muladi_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/dried_lamb_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/dried_lamb_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_staff"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/legend_tipstaff"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_slingstaff"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_hunter"
			});
		}
	}

});

