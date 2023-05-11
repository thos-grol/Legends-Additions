::mods_hookExactClass("skills/backgrounds/female_daytaler_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.25, ::Const.Perks.TalentedTree],
			[0.5, ::Const.Perks.TrainedTree],
			[1.25, ::Const.Perks.OrganisedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[51, ::Const.Perks.LaborerProfessionTree],
					[7, ::Const.Perks.ButcherProfessionTree],
					[7, ::Const.Perks.BlacksmithProfessionTree],
					[7, ::Const.Perks.MinerProfessionTree],
					[7, ::Const.Perks.FarmerProfessionTree],
					[7, ::Const.Perks.HunterProfessionTree],
					[7, ::Const.Perks.DiggerProfessionTree],
					[7, ::Const.Perks.LumberjackProfessionTree]
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
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		

		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"legend_maid_apron"
			],
			[
				1,
				"legend_maid_dress"
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
				"headscarf"
			],
			[
				4,
				""
			]
		]));
	}

});

