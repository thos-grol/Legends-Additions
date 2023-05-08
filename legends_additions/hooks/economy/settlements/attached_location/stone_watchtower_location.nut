::mods_hookExactClass("entity/world/attached_location/stone_watchtower_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("legend_ironmonger_background");
		_list.push("retired_soldier_background");
		_list.push("deserter_background");
		_list.push("paladin_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
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
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "armor/basic_mail_shirt"
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
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/billhook"
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
				R = 50,
				P = 1.0,
				S = "weapons/legend_slingstaff"
			});
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/legend_sling"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_scout"
			});

			if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
			{
				_list.push({
					R = 45,
					P = 1.0,
					S = "legend_armor/tabard/legend_common_tabard"
				});
				_list.push({
					R = 30,
					P = 1.0,
					S = "legend_helmets/vanity/legend_helmet_faction_helmet"
				});
			}
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
			if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
			{
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

