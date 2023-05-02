::mods_hookExactClass("entity/world/settlements/buildings/marketplace_building.nut", function(o) {
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "weapons/bludgeon"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/militia_spear"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/legend_militia_glaive"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/legend_wooden_spear"
			},
			{
				R = 40,
				P = 1.0,
				S = "weapons/pitchfork"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/legend_shiv"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/hatchet"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/legend_shovel"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 15,
				P = 1.0,
				S = "weapons/legend_sling"
			},
			{
				R = 30,
				P = 1.0,
				S = "weapons/javelin"
			},
			{
				R = 30,
				P = 1.0,
				S = "ammo/quiver_of_arrows"
			},
			{
				R = 10,
				P = 1.0,
				S = "armor/sackcloth"
			},
			{
				R = 20,
				P = 1.0,
				S = "armor/linen_tunic"
			},
			{
				R = 25,
				P = 1.0,
				S = "armor/thick_tunic"
			},
			{
				R = 10,
				P = 1.0,
				S = "helmets/straw_hat"
			},
			{
				R = 20,
				P = 1.0,
				S = "helmets/hood"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/legend_drum"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/legend_cat_o_nine_tails"
			},
			{
				R = 80,
				P = 1.0,
				S = "weapons/lute"
			},
			{
				R = 15,
				P = 1.0,
				S = "shields/buckler_shield"
			},
			{
				R = 20,
				P = 1.0,
				S = "shields/wooden_shield"
			},
			{
				R = 25,
				P = 1.0,
				S = "accessory/legend_pack_small"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/ground_grains_item"
			},
			{
				R = 40,
				P = 1.0,
				S = "supplies/legend_fresh_fruit_item"
			},
			{
				R = 20,
				P = 1.0,
				S = "supplies/legend_fresh_meat_item"
			},
			{
				R = 30,
				P = 1.0,
				S = "supplies/roots_and_berries_item"
			},
			{
				R = 10,
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
				S = "supplies/ammo_small_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			},
			{
				R = 10,
				P = 1.0,
				S = "accessory/bandage_item"
			}
		];

		if (this.m.Settlement.getSize() >= 3)
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/medicine_item"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.fishing_huts"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_fish_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.beekeeper"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/mead_item"
			});
		}

		if (this.m.Settlement.getSize() >= 1 && !this.m.Settlement.hasAttachedLocation("attached_location.pig_farm"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/smoked_ham_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.hunters_cabin"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/cured_venison_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.goat_herd"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/goat_cheese_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.orchard"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_fruits_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.mushroom_grove"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/pickled_mushrooms_item"
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

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.gatherers_hut"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/roots_and_berries_item"
			});
		}

		if (this.m.Settlement.getSize() >= 2 && !this.m.Settlement.hasAttachedLocation("attached_location.brewery"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/beer_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.winery"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/wine_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3)
		{
			list.push({
				R = 60,
				P = 1.0,
				S = "supplies/cured_rations_item"
			});
		}

		if (this.m.Settlement.getSize() >= 3 || this.m.Settlement.isMilitary())
		{
			list.push({
				R = 90,
				P = 1.0,
				S = "accessory/falcon_item"
			});
		}

		if (this.Const.DLC.Unhold && ::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() && (this.m.Settlement.isMilitary() && this.m.Settlement.getSize() >= 3 || this.m.Settlement.getSize() >= 2))
		{
			list.push({
				R = 65,
				P = 1.0,
				S = "misc/paint_set_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_remover_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_black_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_orange_red_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_blue_item"
			});
			list.push({
				R = 75,
				P = 1.0,
				S = "misc/paint_white_green_yellow_item"
			});
		}

		if (this.Const.DLC.Unhold)
		{
			list.extend([
				{
					R = 90,
					P = 1.0,
					S = "weapons/two_handed_wooden_hammer"
				}
			]);

			if (this.m.Settlement.isMilitary())
			{
				list.extend([
					{
						R = 80,
						P = 1.0,
						S = "weapons/throwing_spear"
					}
				]);
			}
		}

		if (this.Const.DLC.Wildmen)
		{
			list.extend([
				{
					R = 50,
					P = 1.0,
					S = "weapons/warfork"
				}
			]);
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, true);
	}

});
