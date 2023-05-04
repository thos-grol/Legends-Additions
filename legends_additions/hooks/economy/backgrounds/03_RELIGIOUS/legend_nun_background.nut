::mods_hookExactClass("skills/backgrounds/legend_nun_background", function(o) {
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
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"legend_nun_habit"
			]
		]));
		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"legend_nun_robe_dark"
			],
			[
				1,
				"legend_nun_robe_light"
			]
		]));
	}

});

