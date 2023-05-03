::mods_hookExactClass("skills/backgrounds/companion_1h_background.nut", function(o) {
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
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 1;
		talents[this.Const.Attributes.Bravery] = 1;
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"gambeson"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				1,
				"full_leather_cap"
			]
		]);
		items.equip(item);
	}

});

