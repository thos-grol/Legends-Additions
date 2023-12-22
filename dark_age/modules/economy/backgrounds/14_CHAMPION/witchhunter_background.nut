//Disabled
::mods_hookExactClass("skills/backgrounds/witchhunter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.Modifiers.Crafting = ::Const.LegendMod.ResourceModifiers.Crafting[0];
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = ::Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			items.equip(::new("scripts/items/weapons/crossbow"));
		}

		items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
		r = ::Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(::new("scripts/items/weapons/legend_wooden_stake"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"witchhunter_hat"
			]
		]));
	}

});
