::mods_hookExactClass("skills/backgrounds/caravan_hand_background.nut", function(o) {
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
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"gambeson"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"leather_tunic"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"headscarf"
			],
			[
				1,
				"open_leather_cap"
			]
		]);
		items.equip(item);
	}

});

