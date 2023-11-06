::mods_hookExactClass("skills/backgrounds/legend_lonewolf_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkTreeDynamicMins.Traits = 3;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.PolearmTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree
			],
			Class = [],
			Magic = []
		};
	}

});
