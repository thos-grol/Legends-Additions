::mods_hookExactClass("skills/backgrounds/minstrel_background", function(o) {
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
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic",
				this.Math.rand(3, 4)
			]
		]));
		local r;
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			]
		]));
		local r = this.Math.rand(0, 4);

		if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/lute"));
		}

		if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_drum"));
		}
	}

});

