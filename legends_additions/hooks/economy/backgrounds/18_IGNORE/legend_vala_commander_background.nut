::mods_hookExactClass("skills/backgrounds/legend_vala_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
	 		[
		 		::Const.Perks.ValaSpiritMagicTree,
		 		::Const.Perks.ValaChantMagicTree,
		 		::Const.Perks.ValaTranceMagicTree,
		 		::Const.Perks.CalmTree,
		 		::Const.Perks.TalentedTree,
		 		::Const.Perks.SergeantClassTree,
		 		::Const.Perks.LightArmorTree,
		 		::Const.Perks.TwoHandedTree,
		 		::Const.Perks.StaffTree,
	 		]
	 	);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRRisingStar
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
