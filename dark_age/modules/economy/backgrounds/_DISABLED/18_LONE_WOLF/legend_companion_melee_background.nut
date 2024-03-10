::mods_hookExactClass("skills/backgrounds/legend_companion_melee_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeDynamicMins.Traits = 3;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree,
				::Const.Perks.AxeTree,
			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

});
