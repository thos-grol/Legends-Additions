::mods_hookExactClass("entity/world/attached_location/fortified_outpost_location.nut", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("legend_blacksmith_background");
		_list.push("legend_ironmonger_background");
		_list.push("retired_soldier_background");
		_list.push("deserter_background");
		_list.push("sellsword_background");
		_list.push("hedge_knight_background");
		_list.push("paladin_background");

		if (this.Math.rand(0, 9) == 1)
		{
			_list.push("legend_master_archer_background");
		}

		if (this.Math.rand(0, 9) == 1)
		{
			_list.push("legend_noble_shield");
		}

		if (this.Math.rand(0, 9) == 1)
		{
			_list.push("legend_noble_2h");
		}

		if (this.Math.rand(0, 9) == 1)
		{
			_list.push("legend_noble_ranged");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 60,
				P = 1.0,
				S = "accessory/wardog_item"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "accessory/armored_wardog_item"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_tunic"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/padded_surcoat"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/gambeson"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "armor/basic_mail_shirt"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "armor/mail_shirt"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/aketon_cap"
			});
			_list.push({
				R = 15,
				P = 1.0,
				S = "helmets/full_aketon_cap"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "helmets/nasal_helmet"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/kettle_hat"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "helmets/flat_top_helmet"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/dagger"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/billhook"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/pike"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/military_cleaver"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/boar_spear"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/military_pick"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			});
			_list.push({
				R = 55,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/leather_lamellar"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "armor/mail_hauberk"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/crossbow"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_train"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/light_crossbow"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "ammo/quiver_of_bolts"
			});

			if (this.Const.DLC.Unhold)
			{
				_list.extend([
					{
						R = 75,
						P = 1.0,
						S = "weapons/longsword"
					},
					{
						R = 75,
						P = 1.0,
						S = "weapons/two_handed_wooden_flail"
					},
					{
						R = 55,
						P = 1.0,
						S = "weapons/polehammer"
					},
					{
						R = 55,
						P = 1.0,
						S = "weapons/throwing_spear"
					}
				]);
			}
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/military_pick"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_infantry_axe"
			});
		}
		else if (_id == "building.armorsmith")
		{
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
					R = 45,
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
		}
	}

	o.getNewResources = function()
	{
		return 0;
	}

});

