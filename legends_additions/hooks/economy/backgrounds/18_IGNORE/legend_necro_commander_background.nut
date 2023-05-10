::mods_hookExactClass("skills/backgrounds/legend_necro_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.CleaverTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.MaceTree,
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.MediumArmorTree,
				::Const.Perks.ResilientTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.HoundmasterClassTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.TalentedTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.LegendSpawnZombieLow,
				::Const.Perks.PerkDefs.LegendSpawnSkeletonLow,
				::Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill,
				::Const.Perks.PerkDefs.LegendSpecialistScytheSkill
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendPrepareBleed,
				::Const.Perks.PerkDefs.LegendRust,
				::Const.Perks.PerkDefs.LegendMedPackages
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
				::Const.Perks.PerkDefs.LegendPrepareGraze,
				::Const.Perks.PerkDefs.LegendLacerate
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendExtendendAura,
				::Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage,
				::Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
				::Const.Perks.PerkDefs.LegendSpecPoison,
				::Const.Perks.PerkDefs.LegendSpawnZombieMed,
				::Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
				::Const.Perks.PerkDefs.LegendSpawnZombieMed
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendReclamation,
				::Const.Perks.PerkDefs.LegendBrinkOfDeath,
				::Const.Perks.PerkDefs.LegendConservation,
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendPossession,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.LegendChanneledPower

			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendSpawnSkeletonHigh,
				::Const.Perks.PerkDefs.LegendViolentDecomposition,
				::Const.Perks.PerkDefs.LegendSpawnZombieHigh
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
