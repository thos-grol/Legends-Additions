::mods_hookExactClass("skills/backgrounds/legend_ironmonger_background.nut", function(o) {
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
				1,
				"apron"
			],
			[
				1,
				"linen_tunic"
			],
			[
				1,
				"leather_tunic"
			]
		]));
	}

});

