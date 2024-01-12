::mods_hookExactClass("entity/world/settlements/buildings/fletcher_building", function(o) {
	o.onUpdateShopList = function()
	{
		local list = [
			{
				R = 10,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/short_bow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/hunting_bow"
			},
			{
				R = 10,
				P = 1.0,
				S = "weapons/hunting_bow"
			},
			{
				R = 20,
				P = 1.0,
				S = "weapons/war_bow"
			},
			{
				R = 70,
				P = 1.0,
				S = "weapons/legend_slingstaff"
			},
			{
				R = 0,
				P = 1.0,
				S = "ammo/quiver_of_arrows"
			},
			{
				R = 0,
				P = 1.0,
				S = "supplies/ammo_item"
			}
		];

		foreach( i in ::Const.Items.NamedRangedWeapons )
		{
			if (::Math.rand(1, 100) <= 50)
			{
				list.push({
					R = 99,
					P = 2.0,
					S = i
				});
			}
		}

		this.m.Settlement.onUpdateShopList(this.m.ID, list);
		this.fillStash(list, this.m.Stash, 1.0, false);
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{


	}

});
