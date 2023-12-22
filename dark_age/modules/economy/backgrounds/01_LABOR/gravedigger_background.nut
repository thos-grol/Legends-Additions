::mods_hookExactClass("skills/backgrounds/gravedigger_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		//FEATURE_5: gravedigger is more morbid alignment, affects events - supernatural spooky
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.FitTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.ShovelClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = ::Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/legend_shovel"));
		}

		items.equip(::Const.World.Common.pickArmor([
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
		items.equip(::Const.World.Common.pickHelmet([
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

