::mods_hookExactClass("skills/backgrounds/legend_necrosavant_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.2, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.FastTree],
			[3, ::Const.Perks.AgileTree],
			[3, ::Const.Perks.ViciousTree],
			[2, ::Const.Perks.UnstoppableTree],
			[2, ::Const.Perks.ResilientTree],
			[0.2, ::Const.Perks.ChefClassTree],
			[0, ::Const.Perks.ShieldTree],
			[0, ::Const.Perks.HeavyArmorTree],
			[3, ::Const.Perks.DaggerTree],
			[2, ::Const.Perks.SwordTree],
			[0.5, ::Const.Perks.AxeTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.VampireMagicTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.UnstoppableTree,
				::Const.Perks.ResilientTree
			],
			Class = [
				::Const.Perks.HealerClassTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			],
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
