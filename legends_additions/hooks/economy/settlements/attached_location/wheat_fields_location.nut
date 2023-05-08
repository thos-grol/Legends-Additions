::mods_hookExactClass("entity/world/attached_location/wheat_fields_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/bread_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("farmhand_background");
		_list.push("farmhand_background");
		_list.push("farmhand_background");
		_list.push("daytaler_background");
		_list.push("daytaler_background");
		_list.push("miller_background");
		_list.push("miller_background");

		if (_gender)
		{
			_list.push("female_farmhand_background");
			_list.push("female_daytaler_background");
			_list.push("female_miller_background");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/bread_item"
			});
			_list.push({
				R = 1,
				P = 1.0,
				S = "supplies/ground_grains_item"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/straw_hat"
			});
		}
	}

	o.getNewResources = function()
	{
		return 2;
	}

});

