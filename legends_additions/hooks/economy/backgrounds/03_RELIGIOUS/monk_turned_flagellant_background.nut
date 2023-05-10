::mods_hookExactClass("skills/backgrounds/monk_turned_flagellant_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.ResilientTree],
			[2, ::Const.Perks.SturdyTree],
			[3, ::Const.Perks.TalentedTree],
			[2, ::Const.Perks.ViciousTree],
			[3, ::Const.Perks.LightArmorTree],
			[0.33, ::Const.Perks.ShieldTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.HolyManProfessionTree
			],
			Class = [
				::Const.Perks.SergeantClassTree
			],
			Weapon = [
				::Const.Perks.CleaverTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
	}

});

