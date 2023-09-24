::mods_hookExactClass("entity/world/attached_location/workshop_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/armor_parts_item");
		_list.push("supplies/armor_parts_small_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		if (!this.isActive()) return;
		//_list.push("legend_blacksmith_background");
		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		_list.push("daytaler_background");
		_list.push("daytaler_background");
		_list.push("daytaler_background");
		_list.push("daytaler_background");
		_list.push();
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
			case "building.marketplace":
				_list.push({
					R = 20,
					P = 1.0,
					S = "supplies/armor_parts_item"
				});
				_list.push({
					R = 20,
					P = 1.0,
					S = "supplies/armor_parts_item"
				});
				break;

			case "building.weaponsmith":
				_list.push({
					R = 95,
					P = 1.0,
					S = "weapons/named/legend_named_blacksmith_hammer"
				});
				break;
		}
	}

});
