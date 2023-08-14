::mods_hookExactClass("entity/world/attached_location/leather_tanner_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("apprentice_background");
		_list.push("retired_soldier_background");
		_list.push("butcher_background");
		_list.push("butcher_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 0.9,
				S = "armor/linen_tunic"
			});
			_list.push({
				R = 10,
				P = 0.9,
				S = "legend_armor/cloth/legend_apron"
			});
			_list.push({
				R = 10,
				P = 0.9,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 10,
				P = 0.9,
				S = "helmets/full_leather_cap"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_lamellar"
			});
			_list.push({
				R = 35,
				P = 1.0,
				S = "armor/mail_hauberk"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			});
			_list.push({
				R = 35,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "helmets/closed_flat_top_helmet"
			});
		}
	}

});

