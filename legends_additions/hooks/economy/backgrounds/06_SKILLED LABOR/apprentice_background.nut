::mods_hookExactClass("skills/backgrounds/apprentice_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[3, ::Const.Perks.TalentedTree ]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[12, ::Const.Perks.ButcherProfessionTree],
					[12, ::Const.Perks.BlacksmithProfessionTree],
					[12, ::Const.Perks.TraderProfessionTree],
					[12, ::Const.Perks.ApothecaryProfessionTree],
					[12, ::Const.Perks.LaborerProfessionTree],
					[12, ::Const.Perks.ServiceProfessionTree],
					[28, ::Const.Perks.NoTree]
				])
			],
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
			],
			[
				1,
				"apron"
			]
		]));
	}

});
