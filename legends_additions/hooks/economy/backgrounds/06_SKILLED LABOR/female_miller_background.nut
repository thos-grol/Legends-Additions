::mods_hookExactClass("skills/backgrounds/female_miller_background.nut", function(o) {
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
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r >= 2)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"legend_maid_apron"
			],
			[
				1,
				"legend_maid_dress"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
	}

});

