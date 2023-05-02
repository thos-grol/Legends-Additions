::mods_hookExactClass("entity/world/attached_location/mushroom_grove_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/pickled_mushrooms_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("cultist_background");
		_list.push("cultist_background");
		_list.push("flagellant_background");
		_list.push("wildman_background");
		_list.push("legend_herbalist_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/pickled_mushrooms_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "armor/apron"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_sickle"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_gather"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/legend_shovel"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/medicine_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "accessory/berserker_mushrooms_item"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "accessory/legend_apothecary_mushrooms_item"
			});

			if (this.Const.DLC.Wildmen)
			{
				_list.push({
					R = 30,
					P = 1.0,
					S = "weapons/legend_cat_o_nine_tails"
				});
			}

			if (_id == "building.weaponsmith")
			{
				_list.push({
					R = 30,
					P = 1.0,
					S = "weapons/named/legend_named_sickle"
				});
				_list.push({
					R = 30,
					P = 1.0,
					S = "weapons/named/legend_named_shovel"
				});
			}
		}
	}

});

