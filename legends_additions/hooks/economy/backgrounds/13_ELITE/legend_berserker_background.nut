::mods_hookExactClass("skills/backgrounds/legend_berserker_background.nut", function(o) {
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
		talents[this.Const.Attributes.MeleeSkill] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/roots_and_berries_item"));
		stash.add(this.new("scripts/items/weapons/throwing_axe"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"barbarians/hide_and_bone_armor"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_helmet"
			]
		]);
		local r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/warbrand"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_longsword"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/orc_axe_2h"));
		}

		this.getContainer().getActor().TherianthropeInfectionRandom();
	}

});
