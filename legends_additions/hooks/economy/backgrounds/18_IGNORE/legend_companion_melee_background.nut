::mods_hookExactClass("skills/backgrounds/legend_companion_melee_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.25, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.HeavyArmorTree],
			[0, ::Const.Perks.BowTree],
			[0.4, ::Const.Perks.CrossbowTree],
			[0, ::Const.Perks.SlingTree],
			[0, ::Const.Perks.RangedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[10, ::Const.Perks.BlacksmithProfessionTree],
					[10, ::Const.Perks.LaborerProfessionTree],
					[10, ::Const.Perks.MilitiaProfessionTree],
					[10, ::Const.Perks.RaiderProfessionTree],
					[10, ::Const.Perks.SoldierProfessionTree],
					[5, ::Const.Perks.AssassinProfessionTree],
					[5, ::Const.Perks.JugglerProfessionTree],
					[5, ::Const.Perks.NobleProfessionTree],
					[5, ::Const.Perks.WildlingProfessionTree],
					[3, ::Const.Perks.CultistProfessionTree],
					[2, ::Const.Perks.HolyManProfessionTree],
					[1, ::Const.Perks.ApothecaryProfessionTree],
					[1, ::Const.Perks.ButcherProfessionTree],
					[1, ::Const.Perks.MinstrelProfessionTree],
					[1, ::Const.Perks.LumberjackProfessionTree],
					[1, ::Const.Perks.TraderProfessionTree],
					[20, ::Const.Perks.NoTree]
				])
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
