::mods_hookExactClass("skills/backgrounds/miller_background", function(o) {
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
			Defense = [],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/legend_shovel"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
	}

});

