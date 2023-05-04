::mods_hookExactClass("skills/backgrounds/flagellant_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		}
		else if (r == 3)
		{
			if (this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
			else if (!this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/wooden_flail"));
			}
		}
		else if (r == 4)
		{
			if (this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_reinforced_flail"));
			}
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"sackcloth"
			],
			[
				1,
				"monk_robe"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				4,
				""
			]
		]));
	}

});

