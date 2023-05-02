::mods_hookExactClass("entity/world/attached_location/workshop_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/armor_parts_item");
		_list.push("supplies/armor_parts_small_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_ironmonger_background");
		_list.push("legend_blacksmith_background");
		_list.push("legend_blacksmith_background");
		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		_list.push("peddler_background");
		_list.push("daytaler_background");

		if (_gender)
		{
			_list.push("female_daytaler_background");
		}
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
				R = 10,
				P = 1.0,
				S = "weapons/legend_saw"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/legend_hammer"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_craft"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
			break;

		default:
			switch(_id)
			{
			case "building.specialized_trader":
				break;

			default:
				switch(_id)
				{
				case "building.weaponsmith":
					_list.push({
						R = 95,
						P = 1.0,
						S = "weapons/named/legend_named_blacksmith_hammer"
					});
					break;

				default:
					if (_id == "building.armorsmith")
					{
					}
				}
			}
		}
	}

});
