::mods_hookExactClass("skills/backgrounds/female_bowyer_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.TalentedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.HunterProfessionTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.NoTree],
					[50, ::Const.Perks.MenderClassTree]
				])
			],
			Defense = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.LightArmorTree],
					[50, ::Const.Perks.MediumArmorTree]
				])
			],
			Weapon = [
				::Const.Perks.BowTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"legend_maid_apron"
			],
			[
				1,
				"apron"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			],
			[
				2,
				""
			]
		]);
		items.equip(item);
	}

});

