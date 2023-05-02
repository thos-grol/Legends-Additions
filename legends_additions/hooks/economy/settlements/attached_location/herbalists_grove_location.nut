::mods_hookExactClass("entity/world/attached_location/herbalists_grove_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/medicine_item");
		_list.push("supplies/medicine_small_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("monk_background");
		_list.push("flagellant_background");
		_list.push("anatomist_background");
		_list.push("legend_herbalist_background");
		_list.push("legend_herbalist_background");
		_list.push("legend_herbalist_background");

		if (_gender)
		{
			_list.push("legend_nun_background");
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;

			if (this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
				r = this.Math.rand(0, 50);

				if (r == 1)
				{
					_list.push("legend_druid_background");
				}
			}
			else if (this.World.Assets.getOrigin().getID() == "scenario.legends_druid")
			{
				r = this.Math.rand(0, 9);

				if (r == 1)
				{
					_list.push("legend_druid_background");
				}
			}
			else
			{
				r = this.Math.rand(0, 90);

				if (r == 1)
				{
					_list.push("legend_druid_background");
				}
			}
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "accessory/bandage_item"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_heal"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_gather"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_enchant"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "accessory/antidote_item"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_sickle"
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
						R = 99,
						P = 1.0,
						S = "weapons/named/legend_named_sickle"
					});
					_list.push({
						R = 99,
						P = 1.0,
						S = "weapons/named/legend_named_shovel"
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

