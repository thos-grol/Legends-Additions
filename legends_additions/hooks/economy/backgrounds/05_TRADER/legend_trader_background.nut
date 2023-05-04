::mods_hookExactClass("skills/backgrounds/legend_trader_background", function(o) {
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
		items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			]
		]));
	}

});

