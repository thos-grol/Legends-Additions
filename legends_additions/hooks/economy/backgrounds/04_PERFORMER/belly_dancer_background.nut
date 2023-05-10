::mods_hookExactClass("skills/backgrounds/belly_dancer_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.ResilientTree],
			[0.25, ::Const.Perks.LargeTree],
			[0.25, ::Const.Perks.SturdyTree],
			[1.5, ::Const.Perks.TalentedTree],
			[2, ::Const.Perks.MediumArmorTree],
			[4, ::Const.Perks.LightArmorTree]
		];

		this.m.PerkTreeDynamic = {
			Traits = [
				::Const.Perks.FastTree
			],
			Class = [
				::Const.Perks.EntertainerClassTree
			],
			Defense = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.LightArmorTree],
					[50, ::Const.Perks.MediumArmorTree]
				])
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[
				3,
				"oriental/cloth_sash"
			],
			[
				1,
				""
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				4,
				"legend_jewelry"
			]
		]));
	}

});

