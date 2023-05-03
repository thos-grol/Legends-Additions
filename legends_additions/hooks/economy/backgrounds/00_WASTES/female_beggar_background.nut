::mods_hookExactClass("skills/backgrounds/female_beggar_background.nut", function(o) {
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
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"legend_maid_dress"
			],
			[
				1,
				"legend_maid_apron"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				3,
				""
			],
			[
				1,
				"hood",
				38
			]
		]);
		items.equip(item);
	}

});

