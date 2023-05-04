::mods_hookExactClass("skills/backgrounds/legend_dervish_background", function(o) {
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
		local helm = this.Const.World.Common.pickHelmet([
			[
				2,
				"oriental/southern_head_wrap"
			],
			[
				1,
				"legend_noble_southern_hat"
			],
			[
				3,
				""
			]
		]);
		items.equip(helm);
	}

});

