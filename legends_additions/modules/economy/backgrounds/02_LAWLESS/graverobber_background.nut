::mods_hookExactClass("skills/backgrounds/graverobber_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.MaceTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.DeviousTree
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
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/ancient/broken_ancient_sword"));
		}

		items.equip(::Const.World.Common.pickArmor([
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
		items.equip(::Const.World.Common.pickHelmet([
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

