::mods_hookExactClass("skills/backgrounds/shepherd_background", function(o) {
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

		if (this.Const.DLC.Wildmen)
		{
			if (this.Math.rand(1, 100) <= 66)
			{
				items.equip(this.new("scripts/items/weapons/legend_sling"));
			}
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
		r = this.Math.rand(0, 4);

		if (r <= 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_sling"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}

		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"straw_hat"
			]
		]));
	}

});

