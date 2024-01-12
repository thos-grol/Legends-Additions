::mods_hookExactClass("skills/backgrounds/legend_lonewolf_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeDynamicMins.Traits = 4;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.AxeTree,
				::Const.Perks.HammerTree,
				::Const.Perks.BowTree,
				::Const.Perks.ShieldTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.FitTree,
				::Const.Perks.IndestructibleTree,
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
			],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

});
