::mods_hookExactClass("skills/backgrounds/pacified_flagellant_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[3, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.ResilientTree],
			[2, ::Const.Perks.SturdyTree],
			[2, ::Const.Perks.TalentedTree],
			[2, ::Const.Perks.LightArmorTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.HolyManProfessionTree
			],
			Class = [
				::Const.Perks.SergeantClassTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
	}

});

