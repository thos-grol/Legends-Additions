::mods_hookExactClass("skills/backgrounds/kings_guard_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.GreatSwordTree,
				::Const.Perks.AxeTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
		
	}

});
