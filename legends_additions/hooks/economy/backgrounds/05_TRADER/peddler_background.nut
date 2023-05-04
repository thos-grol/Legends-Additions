::mods_hookExactClass("skills/backgrounds/peddler_background", function(o) {
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
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				2,
				""
			],
			[
				1,
				"feathered_hat"
			]
		]));
	}

});

