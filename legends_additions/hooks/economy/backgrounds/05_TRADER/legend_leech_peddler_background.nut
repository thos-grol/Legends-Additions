::mods_hookExactClass("skills/backgrounds/legend_leech_peddler_background.nut", function(o) {
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
			items.equip(this.new(""));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"thick_dark_tunic"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				2,
				"feathered_hat"
			],
			[
				3,
				"headscarf"
			]
		]));
	}

});

