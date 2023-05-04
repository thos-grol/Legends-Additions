::mods_hookExactClass("skills/backgrounds/legend_pilgrim_background", function(o) {
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
		local weapons = [
			"weapons/legend_staff",
			"weapons/legend_tipstaff"
		];
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"gambeson"
			],
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"full_leather_cap"
			],
			[
				1,
				"straw_hat"
			]
		]));
	}

});
