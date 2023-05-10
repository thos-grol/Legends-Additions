::mods_hookExactClass("skills/backgrounds/graverobber_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.5, ::Const.Perks.SkeletonTree],
			[1.5, ::Const.Perks.ZombieTree],
			[1.5, ::Const.Perks.VampireTree],
			[2, ::Const.Perks.CalmTree],
			[2, ::Const.Perks.DeviousTree],
			[2, ::Const.Perks.SergeantClassTree]
		];

		this.m.PerkTreeDynamic = {};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"leather_wraps"
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
				"open_leather_cap"
			],
			[
				1,
				"headscarf"
			],
			[
				1,
				"ancient/ancient_household_helmet"
			]
		]));
	}

});

