::mods_hookExactClass("skills/backgrounds/juggler_background", function(o) {
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

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/throwing_axe"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/throwing_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_ranged_wooden_flail"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"jesters_hat"
			],
			[
				1,
				""
			]
		]));
	}

});
