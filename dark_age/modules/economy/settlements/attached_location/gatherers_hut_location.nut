::mods_hookExactClass("entity/world/attached_location/gatherers_hut_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		//_list.push("legend_herbalist_background");
		//_list.push("legend_herbalist_background");
		_list.push("daytaler_background");
		_list.push("daytaler_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/bludgeon"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_sickle"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
		}
	}

});

