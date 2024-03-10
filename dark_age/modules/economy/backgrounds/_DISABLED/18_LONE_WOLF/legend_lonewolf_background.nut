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

	o.onChangeAttributes = function()
	{
		local c = {
			Hitpoints = [
				20,
				20
			],
			Bravery = [
				25,
				25
			],
			Stamina = [
				20,
				20
			],
			MeleeSkill = [
				14,
				14
			],
			RangedSkill = [
				16,
				16
			],
			MeleeDefense = [
				10,
				10
			],
			RangedDefense = [
				10,
				10
			],
			Initiative = [
				15,
				15
			]
		};
		return c;
	}

});
