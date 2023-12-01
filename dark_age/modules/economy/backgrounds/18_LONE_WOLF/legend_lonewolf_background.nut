::mods_hookExactClass("skills/backgrounds/legend_lonewolf_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeDynamicMins.Traits = 4;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.BowTree,
				::Const.Perks.ShieldTree,
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.IndestructibleTree,
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
