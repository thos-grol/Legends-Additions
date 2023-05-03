::mods_hookExactClass("skills/backgrounds/lumberjack_background.nut", function(o) {
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
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_saw"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"padded_surcoat"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic",
				6
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"hood"
			]
		]));
	}

});

