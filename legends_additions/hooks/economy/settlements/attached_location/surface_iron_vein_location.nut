::mods_hookExactClass("entity/world/attached_location/surface_iron_vein_location.nut", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("legend_ironmonger_background");
		_list.push("retired_soldier_background");
	}

	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/iron_ingots_item");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/pickaxe"
			});
			_list.push({
				R = 15,
				P = 1.0,
				S = "weapons/reinforced_wooden_flail"
			});
			_list.push({
				R = 25,
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
						R = 55,
						P = 1.0,
						S = "weapons/falchion"
					});
					_list.push({
						R = 60,
						P = 1.0,
						S = "weapons/morning_star"
					});
					_list.push({
						R = 60,
						P = 1.0,
						S = "weapons/legend_tipstaff"
					});
					_list.push({
						R = 70,
						P = 1.0,
						S = "weapons/arming_sword"
					});
					_list.push({
						R = 70,
						P = 1.0,
						S = "weapons/military_cleaver"
					});
					_list.push({
						R = 60,
						P = 1.0,
						S = "weapons/winged_mace"
					});
					_list.push({
						R = 60,
						P = 1.0,
						S = "weapons/pike"
					});
					_list.push({
						R = 70,
						P = 1.0,
						S = "weapons/longaxe"
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

