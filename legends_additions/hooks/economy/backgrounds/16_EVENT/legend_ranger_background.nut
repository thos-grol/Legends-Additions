::mods_hookExactClass("skills/backgrounds/legend_ranger_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 3;
		talents[this.Const.Attributes.Fatigue] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		stash.add(this.new("scripts/items/supplies/cured_venison_item"));
		stash.add(this.new("scripts/items/accessory/wardog_item"));
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/bludgeon"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"leather_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));
	}

});

