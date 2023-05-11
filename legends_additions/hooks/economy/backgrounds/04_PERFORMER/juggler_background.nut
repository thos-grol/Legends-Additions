::mods_hookExactClass("skills/backgrounds/juggler_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.TalentedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.JugglerProfessionTree
			],
			Traits = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.AgileTree],
					[50, ::Const.Perks.FastTree]
				])
			],
			Class = [
				::Const.Perks.EntertainerClassTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
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
