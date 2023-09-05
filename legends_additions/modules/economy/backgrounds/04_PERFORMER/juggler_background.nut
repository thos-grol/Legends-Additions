//TODO: Add knife throw perk
::mods_hookExactClass("skills/backgrounds/juggler_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.FlailTree,
				this.Const.Perks.DaggerTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.FistsClassTree,
				this.Const.Perks.JugglerClassTree
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
			items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_ranged_wooden_flail"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
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
