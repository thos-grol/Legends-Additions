::mods_hookExactClass("entity/world/attached_location/goat_herd_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/dried_lamb_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("butcher_background");
		_list.push("daytaler_background");
		_list.push("farmhand_background");
		_list.push("farmhand_background");
		_list.push("farmhand_background");
		_list.push("shepherd_background");
		_list.push("shepherd_background");
		_list.push("shepherd_background");

		if (_gender)
		{
			_list.push("female_daytaler_background");
			_list.push("female_farmhand_background");
		}
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
				R = 20,
				P = 1.0,
				S = "weapons/bludgeon"
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
				R = 30,
				P = 1.0,
				S = "armor/leather_tunic"
			});
		}
	}

});

