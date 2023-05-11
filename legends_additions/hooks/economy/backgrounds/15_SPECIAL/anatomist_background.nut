::mods_hookExactClass("skills/backgrounds/anatomist_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.LargeTree],
			[0.5, ::Const.Perks.SturdyTree],
			[3, ::Const.Perks.TalentedTree],
			[0, ::Const.Perks.EntertainerClassTree],
			[3, ::Const.Perks.HealerClassTree],
			[0, ::Const.Perks.HoundmasterClassTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.CrossbowTree],
			[0, ::Const.Perks.SlingTree],
			[0, ::Const.Perks.RangedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ApothecaryProfessionTree
			],
			Enemy = [
				::MSU.Class.WeightedContainer([
					[8, ::Const.Perks.DirewolfTree],
					[8, ::Const.Perks.GhoulTree],
					[9, ::Const.Perks.LindwurmTree],
					[8, ::Const.Perks.GoblinTree],
					[8, ::Const.Perks.OrcTree],
					[8, ::Const.Perks.UnholdTree],
					[8, ::Const.Perks.AlpTree],
					[9, ::Const.Perks.HexenTree],
					[9, ::Const.Perks.SchratTree],
					[8, ::Const.Perks.SkeletonTree],
					[9, ::Const.Perks.VampireTree],
					[8, ::Const.Perks.ZombieTree]
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
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"undertaker_apron"
			],
			[
				2,
				"wanderers_coat"
			],
			[
				1,
				"reinforced_leather_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				2,
				"undertaker_hat"
			],
			[
				2,
				"physician_mask"
			],
			[
				1,
				"masked_kettle_helmet"
			]
		]));
	}

});

