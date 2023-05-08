::mods_hookExactClass("entity/world/attached_location/fletchers_hut_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/ammo_item");
		_list.push("supplies/ammo_small_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("hunter_background");
		_list.push("bowyer_background");
		_list.push("poacher_background");

		if (_gender)
		{
			_list.push("female_bowyer_background");
			_list.push("female_bowyer_background");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.fletcher")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/hunting_bow"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/war_bow"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_sling"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "ammo/huge_quiver_of_arrows"
			});
		}
		else if (_id == "building.weaponsmith")
		{
		}
	}

});

