//FEATURE_1: Add knife throw perk
::mods_hookExactClass("skills/backgrounds/juggler_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.FlailTree,
				::Const.Perks.MaceTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.AgileTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.JugglerClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/legend_ranged_wooden_flail"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"jesters_hat"
			],
			[
				1,
				""
			]
		]));
	}

});
