::mods_hookExactClass("skills/backgrounds/messenger_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.5, ::Const.Perks.ResilientTree],
			[1.5, ::Const.Perks.LargeTree],
			[1.5, ::Const.Perks.FastTree],
			[6, ::Const.Perks.AgileTree],
			[2, ::Const.Perks.UnstoppableTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.LaborerProfessionTree],
					[50, ::Const.Perks.ServiceProfessionTree]
				])
			],
			Class = [
				::Const.Perks.ScoutClassTree
			],
			Weapon = [
				::Const.Perks.SlingTree
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
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"hood"
			],
			[
				1,
				"straw_hat"
			]
		]));
	}

});

