::mods_hookExactClass("entity/world/settlements/buildings/marketplace_building", function(o) {
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 20,
				P = 1.0,
				S = "armor/linen_tunic"
			},
			{
				R = 20,
				P = 1.0,
				S = "helmets/hood"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/medicine_small_item"
			},
			{
				R = 50,
				P = 1.0,
				S = "supplies/medicine_small_item"
			},
		];

		if (this.m.Settlement.getSize() >= 3)
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/medicine_small_item"
			});
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/armor_parts_small_item"
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

		if (this.m.Settlement.getSize() >= 3 && !this.m.Settlement.hasAttachedLocation("attached_location.goat_herd"))
		{
			list.push({
				R = 50,
				P = 1.0,
				S = "supplies/dried_lamb_item"
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

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, true);
	}

});
