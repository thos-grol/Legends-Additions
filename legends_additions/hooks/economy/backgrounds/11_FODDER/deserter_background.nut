::mods_hookExactClass("skills/backgrounds/deserter_background.nut", function(o) {
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
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"gambeson"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				2,
				""
			]
		]));
	}

});
