::mods_hookExactClass("entity/world/attached_location/blast_furnace_location", function(o) {
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		if (!this.isActive()) return;
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		_list.push("deserter_background");
		_list.push("disowned_noble_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
			case "building.marketplace":

				_list.push({
					R = 25,
					P = 1.0,
					S = "supplies/armor_parts_item"
				});
			break;

			case "building.armorsmith":
				_list.push({
					R = 35,
					P = 1.0,
					S = "armor/mail_hauberk"
				});
				_list.push({
					R = 40,
					P = 1.0,
					S = "armor/reinforced_mail_hauberk"
				});
				_list.push({
					R = 45,
					P = 1.0,
					S = "armor/lamellar_harness"
				});
				_list.push({
					R = 20,
					P = 1.0,
					S = "helmets/padded_nasal_helmet"
				});
				_list.push({
					R = 25,
					P = 1.0,
					S = "helmets/padded_kettle_hat"
				});
				_list.push({
					R = 30,
					P = 1.0,
					S = "helmets/padded_flat_top_helmet"
				});
				_list.push({
					R = 35,
					P = 1.0,
					S = "helmets/closed_flat_top_helmet"
				});
				_list.push({
					R = 35,
					P = 1.0,
					S = "helmets/closed_flat_top_with_mail"
				});
				_list.push({
					R = 30,
					P = 1.0,
					S = "shields/kite_shield"
				});
				_list.push({
					R = 45,
					P = 1.0,
					S = "armor/scale_armor"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "armor/heavy_lamellar_armor"
				});
				_list.push({
					R = 55,
					P = 1.0,
					S = "armor/coat_of_plates"
				});
				_list.push({
					R = 40,
					P = 1.0,
					S = "helmets/closed_flat_top_with_neckguard"
				});
				_list.push({
					R = 40,
					P = 1.0,
					S = "helmets/nasal_helmet_with_mail"
				});
				_list.push({
					R = 40,
					P = 1.0,
					S = "helmets/bascinet_with_mail"
				});
				_list.push({
					R = 40,
					P = 1.0,
					S = "helmets/kettle_hat_with_mail"
				});
				_list.push({
					R = 45,
					P = 1.0,
					S = "helmets/kettle_hat_with_closed_mail"
				});
				_list.push({
					R = 45,
					P = 1.0,
					S = "helmets/nasal_helmet_with_closed_mail"
				});
				_list.push({
					R = 45,
					P = 1.0,
					S = "helmets/flat_top_with_mail"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "helmets/full_helm"
				});
				_list.push({
					R = 90,
					P = 1.0,
					S = "helmets/legend_helm_breathed"
				});
				_list.push({
					R = 95,
					P = 1.0,
					S = "helmets/legend_helm_full"
				});
				_list.push({
					R = 90,
					P = 1.0,
					S = "helmets/legend_helm_point"
				});
				_list.push({
					R = 85,
					P = 1.0,
					S = "helmets/legend_helm_snub"
				});
				_list.push({
					R = 95,
					P = 1.0,
					S = "helmets/legend_helm_wings"
				});
				_list.push({
					R = 80,
					P = 1.0,
					S = "helmets/legend_helm_curved"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "helmets/great_jaw_helmet_00"
				});
				_list.push({
					R = 35,
					P = 1.0,
					S = "shields/heater_shield"
				});
			break;
		}
	}

});
