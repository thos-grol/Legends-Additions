::mods_hookExactClass("skills/backgrounds/legend_philosopher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.66, ::Const.Perks.OrganisedTree],
			[0.25, ::Const.Perks.TrapperClassTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.PhilosophyMagicTree
			],
			Traits = [
				::Const.Perks.TalentedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
