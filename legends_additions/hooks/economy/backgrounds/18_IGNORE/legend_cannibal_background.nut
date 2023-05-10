::mods_hookExactClass("skills/backgrounds/legend_cannibal_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ButcherProfessionTree
			],
			Traits = [
				::Const.Perks.ViciousTree
			],
			Class = [
				::Const.Perks.ChefClassTree
			],
			Styles = [
				::Const.Perks.OneHandedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
