::mods_hookExactClass("skills/backgrounds/fisherman_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.LargeTree],
			[0.75, ::Const.Perks.ResilientTree],
			[0.5, ::Const.Perks.SturdyTree],
			[1.5, ::Const.Perks.OrganisedTree],
			[1.5, ::Const.Perks.ChefClassTree],
			[1.25, ::Const.Perks.SpearTree],
			[0, ::Const.Perks.ThrowingTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[30, ::Const.Perks.ButcherProfessionTree],
					[30, ::Const.Perks.LaborerProfessionTree],
					[10, ::Const.Perks.TraderProfessionTree],
					[30, ::Const.Perks.NoTree]
				])
			],
			Class = [
				::Const.Perks.TrapperClassTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/throwing_spear"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"straw_hat"
			],
			[
				1,
				""
			]
		]));
	}

});

