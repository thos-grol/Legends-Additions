::mods_hookExactClass("skills/backgrounds/legend_noble_background", function(o) {
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
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"noble_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"legend_noble_hat"
			],
			[
				1,
				"legend_noble_crown"
			],
			[
				1,
				"legend_noble_floppy_hat"
			],
			[
				1,
				"legend_noble_hood"
			]
		]));
		local r;
		r = this.Math.rand(1, 3);

		if (r <= 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
			items.equip(this.new("scripts/items/weapons/legend_parrying_dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/fencing_sword"));
			items.equip(this.new("scripts/items/weapons/legend_parrying_dagger"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_estoc"));
		}
	}

});

