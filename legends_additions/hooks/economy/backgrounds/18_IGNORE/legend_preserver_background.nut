::mods_hookExactClass("skills/backgrounds/legend_preserver_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				::Const.Perks.AgileTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.MediumArmorTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.SlingTree,
				::Const.Perks.SwordTree,
				::Const.Perks.RangedTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendAlert,
				::Const.Perks.PerkDefs.Student,
				::Const.Perks.PerkDefs.CripplingStrikes,
				::Const.Perks.PerkDefs.LegendMedPackages,
				::Const.Perks.PerkDefs.QuickHands,
				::Const.Perks.PerkDefs.NineLives,
				::Const.Perks.PerkDefs.LegendSpecialistSickleSkill,
				::Const.Perks.PerkDefs.PTRDeepCuts
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.HoldOut,
				::Const.Perks.PerkDefs.Gifted,
				::Const.Perks.PerkDefs.CoupDeGrace,
				::Const.Perks.PerkDefs.LegendGatherer,
				::Const.Perks.PerkDefs.RallyTheTroops,
				::Const.Perks.PerkDefs.LegendPrepareBleed
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.FortifiedMind,
				::Const.Perks.PerkDefs.LegendSpecialistSickleDamage,
				::Const.Perks.PerkDefs.Debilitate,
				::Const.Perks.PerkDefs.LegendHerbcraft,
				::Const.Perks.PerkDefs.Lookout,
				::Const.Perks.PerkDefs.LegendPrepareGraze,
				::Const.Perks.PerkDefs.LegendBloodbath
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.ShieldExpert,
				::Const.Perks.PerkDefs.PTRDismemberment,
				::Const.Perks.PerkDefs.PTRDiscoveredTalent,
				::Const.Perks.PerkDefs.LegendSpecPoison,
				::Const.Perks.PerkDefs.LegendSpecBandage,
				::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
				::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
				::Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
				::Const.Perks.PerkDefs.LegendPoisonImmunity,
				::Const.Perks.PerkDefs.LegendPotionBrewer
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendMedIngredients,
				::Const.Perks.PerkDefs.LegendSlaughter,
				::Const.Perks.PerkDefs.Duelist,
				::Const.Perks.PerkDefs.PTRVigorousAssault,
				::Const.Perks.PerkDefs.LegendBlendIn,
				::Const.Perks.PerkDefs.LegendConservation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Overwhelm,
				::Const.Perks.PerkDefs.LegendMindOverBody,
				::Const.Perks.PerkDefs.LegendAssuredConquest,
				::Const.Perks.PerkDefs.PTRKnowTheirWeakness,
				::Const.Perks.PerkDefs.InspiringPresence,
				::Const.Perks.PerkDefs.LegendReclamation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Rebound,
				::Const.Perks.PerkDefs.PTRRisingStar,
				::Const.Perks.PerkDefs.Fearsome,
				::Const.Perks.PerkDefs.LegendFieldTriage,
				::Const.Perks.PerkDefs.Inspire,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.PTRTunnelVision			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
