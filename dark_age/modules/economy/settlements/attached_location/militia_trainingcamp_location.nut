::mods_hookExactClass("entity/world/attached_location/militia_trainingcamp_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("militia_background");
		_list.push("retired_soldier_background");
		_list.push("militia_background");
		_list.push("militia_background");
		_list.push("retired_soldier_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/linen_tunic"
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
				S = "legend_armor/chain/legend_armor_mail_shirt"
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
				S = "legend_helmets/helm/legend_helmet_norman_helm"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "shields/wooden_shield"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_scout"
			});
			_list.push({
				R = 65,
				P = 1.0,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/scramasax"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/boar_spear"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/dagger"
			});

			if (::Const.DLC.Unhold)
			{
				_list.extend([
					{
						R = 70,
						P = 1.0,
						S = "weapons/two_handed_wooden_hammer"
					},
					{
						R = 40,
						P = 1.0,
						S = "weapons/goedendag"
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
				R = 70,
				P = 1.0,
				S = "weapons/legend_infantry_axe"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/fighting_spear"
			});
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 30,
				P = 1.0,
				S = "legend_armor/chain/legend_armor_mail_shirt"
			});

			_list.push({
				R = 50,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_common"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "legend_armor/cloak/legend_armor_cloak_heavy"
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
	}

	o.getNewResources = function()
	{
		return 0;
	}

});

