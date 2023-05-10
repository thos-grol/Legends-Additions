::mods_hookExactClass("skills/backgrounds/legend_companion_ranged_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.25, ::Const.Perks.OrganisedTree],
			[0, ::Const.Perks.HeavyArmorTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[10, ::Const.Perks.ApothecaryProfessionTree],
					[10, ::Const.Perks.JugglerProfessionTree],
					[10, ::Const.Perks.LaborerProfessionTree],
					[10, ::Const.Perks.MilitiaProfessionTree],
					[10, ::Const.Perks.NobleProfessionTree],
					[5, ::Const.Perks.MinstrelProfessionTree],
					[5, ::Const.Perks.TraderProfessionTree],
					[40, ::Const.Perks.NoTree]
				])
			],
			Weapon = [
				::MSU.Class.WeightedContainer([
					[10, ::Const.Perks.BowTree],
					[10, ::Const.Perks.CrossbowTree]
				]),
				::MSU.Class.WeightedContainer([
					[10, ::Const.Perks.SlingTree],
					[0, ::Const.Perks.ThrowingTree]
				])
			],
			Defense = [
				::Const.Perks.LightArmorTree
			]
			Styles = [
				::Const.Perks.RangedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
