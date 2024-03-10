::mods_hookExactClass("entity/world/attached_location/fortified_outpost_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		if (!this.isActive()) return;

		_list.push("retired_soldier_background");
		_list.push("deserter_background");
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
				R = 65,
				P = 1.0,
				S = "helmets/flat_top_helmet"
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
				R = 70,
				P = 0.9,
				S = "weapons/dagger"
			});
			_list.push({
				R = 70,
				P = 0.9,
				S = "weapons/pike"
			});

			_list.push({
				R = 65,
				P = 0.9,
				S = "shields/legend_tower_shield"
			});
			_list.push({
				R = 30,
				P = 0.9,
				S = "shields/wooden_shield"
			});

			_list.push({
				R = 75,
				P = 0.9,
				S = "weapons/two_handed_wooden_flail"
			});

		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 75,
				P = 1.0,
				S = "weapons/longsword"
			});
			_list.push({
				R = 55,
				P = 1.0,
				S = "weapons/polehammer"
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
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/gambeson"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "legend_armor/chain/legend_armor_mail_shirt"
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

	o.getNewResources = function()
	{
		return 0;
	}

});

