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
		_list.push("witchhunter_background");

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
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/short_bow"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_saw"
			});
			_list.push({
				R = 0,
				P = 0.8,
				S = "ammo/quiver_of_arrows"
			});
			_list.push({
				R = 0,
				P = 0.8,
				S = "supplies/ammo_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_armor_piercing_arrows"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "ammo/legend_broad_head_arrows"
			});
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
				R = 20,
				P = 1.0,
				S = "weapons/legend_sling"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "ammo/huge_quiver_of_arrows"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_armor_piercing_arrows"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "ammo/legend_large_broad_head_arrows"
			});
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/war_bow"
			});
		}
	}

});

