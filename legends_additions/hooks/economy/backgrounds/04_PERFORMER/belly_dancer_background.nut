::mods_hookExactClass("skills/backgrounds/belly_dancer_background.nut", function(o) {
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
				3,
				"oriental/cloth_sash"
			],
			[
				1,
				""
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				4,
				"legend_jewelry"
			]
		]));
	}

});

