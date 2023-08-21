::mods_hookExactClass("entity/world/settlements/buildings/marketplace_oriental_building", function(o) {
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "armor/oriental/cloth_sash"
			},
			{
				R = 40,
				P = 1.0,
				S = "armor/oriental/nomad_robe"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/oriental/padded_vest"
			},
			{
				R = 30,
				P = 1.0,
				S = "helmets/oriental/wrapped_southern_helmet"
			},
			{
				R = 40,
				P = 1.0,
				S = "helmets/oriental/spiked_skull_cap_with_mail"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/oriental/southern_light_shield"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/medicine_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/ammo_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			}
		];

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.fishing_huts"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_fish_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.goat_herd"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_lamb_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.plantation"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dates_item"
			});
		}

		if (!this.m.Settlement.hasAttachedLocation("attached_location.wheat_farm"))
		{
			list.push({
				R = 30,
				P = 1.0,
				S = "supplies/bread_item"
			});
		}

		// if (this.m.Settlement.getSize() >= 3 || this.m.Settlement.isMilitary())
		// {
		// 	list.push({
		// 		R = 90,
		// 		P = 1.0,
		// 		S = "accessory/falcon_item"
		// 	});
		// }

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 90,
					P = 1.0,
					S = "weapons/two_handed_wooden_hammer"
				}
			]);
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, true);
	}

});

