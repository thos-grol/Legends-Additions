::mods_hookExactClass("entity/world/attached_location/wool_spinner_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/cloth_rolls_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		if (!this.isActive()) return;
		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		//_list.push("tailor_background");
		_list.push("shepherd_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
			case "building.marketplace":
				_list.push({
					R = 0,
					P = 1.0,
					S = "trade/cloth_rolls_item"
				});	
				_list.push({
					R = 10,
					P = 1.0,
					S = "armor/linen_tunic"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "helmets/hood"
				});
				break;

			case "building.armorsmith":
				_list.push({
					R = 45,
					P = 1.0,
					S = "legend_armor/tabard/legend_common_tabard"
				});
				_list.push({
					R = 99,
					P = 2.0,
					S = "legend_armor/named/legend_armor_named_tabard"
				});
				_list.push({
					R = 30,
					P = 1.0,
					S = "legend_armor/cloth/legend_gambeson"
				});
				_list.push({
					R = 90,
					P = 1.0,
					S = "legend_armor/cloth/legend_robes_magic"
				});
				break;
		}
	}

});

