::mods_hookExactClass("skills/backgrounds/witchhunter_background", function(o) {
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
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/legend_wooden_stake"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"witchhunter_hat"
			]
		]));
	}

});
