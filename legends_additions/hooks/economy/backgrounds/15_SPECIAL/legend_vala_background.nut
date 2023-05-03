::mods_hookExactClass("skills/backgrounds/legend_vala_background.nut", function(o) {
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
		talents[this.Const.Attributes.Bravery] = this.Math.rand(2, 3);
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_staff_vala"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"legend_vala_cloak"
			],
			[
				1,
				"legend_vala_dress"
			]
		]));
	}

});

