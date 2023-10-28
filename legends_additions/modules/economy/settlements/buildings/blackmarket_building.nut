::mods_hookExactClass("entity/world/settlements/buildings/alchemist_building", function(o) {

    o.onUpdateShopList = function()
	{
		local list = [
			// {
			// 	R = 50,
			// 	P = 1.0,
			// 	S = "loot/gemstones_item"
			// },
			// {
			// 	R = 99,
			// 	P = 15.0,
			// 	S = "misc/legend_ancient_scroll_item"
			// },
			// {
			// 	R = 99,
			// 	P = 15.0,
			// 	S = "misc/legend_ancient_scroll_item"
			// },
			// {
			// 	R = 15,
			// 	P = 3.0,
			// 	S = "misc/miracle_drug_item"
			// },
			{
				R = 0,
				P = 5.0,
				S = "misc/happy_powder_item"
			}
		];

		if (this.Math.rand(1, 100) <= 50)
		{
			list.push({
				R = 0,
				P = 3.0,
				S = "weapons/light_crossbow"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "ammo/quiver_of_bolts"
			});
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			list.push({
				R = 0,
				P = 3.0,
				S = "weapons/crossbow"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "ammo/quiver_of_bolts"
			});
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			list.push({
				R = 0,
				P = 3.0,
				S = "weapons/heavy_crossbow"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "ammo/quiver_of_bolts"
			});
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			list.push({
				R = 0,
				P = 1.0,
				S = "weapons/oriental/handgonne"
			});
			list.push({
				R = 0,
				P = 1.0,
				S = "ammo/powder_bag"
			});
			list.push({
				R = 60,
				P = 2.0,
				S = "weapons/named/named_handgonne"
			});
		}

		foreach( i in ::Const.Items.NamedMeleeWeapons )
		{
			if (this.Math.rand(1, 100) <= 25)
			{
				list.push({
					R = 60,
					P = 3.0,
					S = i
				});
			}
		}

		foreach( i in ::Const.Items.NamedRangedWeapons )
		{
			if (this.Math.rand(1, 100) <= 25)
			{
				list.push({
					R = 60,
					P = 3.0,
					S = i
				});
			}
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.25, false);
	}

});