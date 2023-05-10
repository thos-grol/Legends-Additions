::mods_hookExactClass("skills/backgrounds/killer_on_the_run_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[5, ::Const.Perks.ViciousTree],
			[2, ::Const.Perks.UnstoppableTree],
			[0.1, ::Const.Perks.CalmTree],
			[0.5, ::Const.Perks.SergeantClassTree],
			[0.5, ::Const.Perks.HealerClassTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[6, ::Const.Perks.MilitiaProfessionTree],
					[6, ::Const.Perks.ButcherProfessionTree],
					[6, ::Const.Perks.BlacksmithProfessionTree],
					[6, ::Const.Perks.MinerProfessionTree],
					[6, ::Const.Perks.FarmerProfessionTree],
					[6, ::Const.Perks.DiggerProfessionTree],
					[6, ::Const.Perks.LumberjackProfessionTree],
					[6, ::Const.Perks.LaborerProfessionTree],
					[6, ::Const.Perks.SoldierProfessionTree],
					[6, ::Const.Perks.ServiceProfessionTree],
					[0.25, ::Const.Perks.JugglerProfessionTree],
					[0.25, ::Const.Perks.MinstrelProfessionTree],
					[0.25, ::Const.Perks.AssassinProfessionTree],
					[0.25, ::Const.Perks.ApothecaryProfessionTree],
					[39, ::Const.Perks.NoTree]
				])
			],
			Enemy = [
				::Const.Perks.CivilizationTree
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
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

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
				"hood"
			]
		]));
	}

});
