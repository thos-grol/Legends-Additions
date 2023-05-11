::mods_hookExactClass("skills/backgrounds/cripple_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.FastTree],
			[0.5, ::Const.Perks.AgileTree],
			[0.5, ::Const.Perks.SturdyTree],
			[2, ::Const.Perks.ResilientTree],
			[0, ::Const.Perks.EntertainerClassTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[99, ::Const.Perks.PauperProfessionTree],
					[0.25, ::Const.Perks.ApothecaryProfessionTree],
					[0.25, ::Const.Perks.JugglerProfessionTree],
					[0.25, ::Const.Perks.MinstrelProfessionTree],
					[0.25, ::Const.Perks.AssassinProfessionTree]
				])
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

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			]
		]));
		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"hood",
				38
			],
			[
				3,
				""
			]
		]);
		items.equip(helm);
	}

});
