::mods_hookExactClass("skills/backgrounds/gravedigger_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.5, ::Const.Perks.SkeletonTree],
			[1.5, ::Const.Perks.ZombieTree],
			[1.5, ::Const.Perks.VampireTree],
			[2, ::Const.Perks.CalmTree],
			[2, ::Const.Perks.SergeantClassTree],
			[0.5, ::Const.Perks.TalentedTree],
			[1.5, ::Const.Perks.TwoHandedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.DiggerProfessionTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"tattered_sackcloth"
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
			],
			[
				1,
				""
			]
		]));
	}

});

