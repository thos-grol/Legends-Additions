::mods_hookExactClass("entity/world/attached_location/wool_spinner_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/cloth_rolls_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		_list.push("tailor_background");
		_list.push("tailor_background");
		_list.push("shepherd_background");

		if (_gender)
		{
			_list.push("female_tailor_background");
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r = this.Math.rand(0, 90);

			if (r == 1)
			{
				_list.push("legend_enchanter_background");
			}
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/linen_tunic"
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
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_heal"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_fletcher"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_enchant"
			});
			_list.push({
				R = 95,
				P = 1.0,
				S = "tents/tent_craft"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/cloth_rolls_item"
			});

			if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
			{
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_tunic_collar_thin"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_tunic_wrap"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_tunic_collar_deep"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_peasant_dress"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_robes"
				});
				_list.push({
					R = 10,
					P = 1.0,
					S = "legend_armor/cloth/legend_ancient_cloth_restored"
				});
				_list.push({
					R = 20,
					P = 1.0,
					S = "legend_armor/cloth/legend_thick_tunic"
				});
				_list.push({
					R = 40,
					P = 1.0,
					S = "legend_armor/cloth/legend_robes_nun"
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
				_list.push({
					R = 50,
					P = 1.0,
					S = "legend_armor/cloak/legend_armor_cloak_common"
				});
				_list.push({
					R = 45,
					P = 1.0,
					S = "legend_armor/cloak/legend_sash"
				});
				_list.push({
					R = 45,
					P = 1.0,
					S = "legend_armor/tabard/legend_common_tabard"
				});
			}

			break;

		default:
			switch(_id)
			{
			case "building.armorsmith":
				if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
				{
					_list.push({
						R = 50,
						P = 1.0,
						S = "legend_armor/cloak/legend_armor_cloak_common"
					});
					_list.push({
						R = 95,
						P = 1.0,
						S = "legend_armor/cloak/legend_armor_cloak_noble"
					});
					_list.push({
						R = 50,
						P = 1.0,
						S = "legend_armor/cloak/legend_armor_cloak_heavy"
					});
					_list.push({
						R = 99,
						P = 2.0,
						S = "legend_armor/named/legend_armor_cloak_rich"
					});
					_list.push({
						R = 45,
						P = 1.0,
						S = "legend_armor/cloak/legend_sash"
					});
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
				}

				break;

			default:
				if (_id == "building.specialized_trader")
				{
				}
			}
		}
	}

});

