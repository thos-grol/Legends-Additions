::mods_hookExactClass("skills/backgrounds/legend_qiyan_background", function(o) {
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
		local armor = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/cloth_sash"
			]
		]);
		items.equip(armor);
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"legend_headband_coin"
			],
			[
				1,
				"legend_headress_coin"
			],
			[
				1,
				"legend_earings"
			],
			[
				5,
				"legend_southern_veil"
			],
			[
				1,
				"legend_southern_veil_coin"
			],
			[
				1,
				"legend_southern_cloth_headress"
			]
		]));
	}

});

