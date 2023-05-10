::mods_hookExactClass("skills/backgrounds/legend_puppet_master_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				::Const.Perks.ResilientTree,
				::Const.Perks.TalentedTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.MediumArmorTree,
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.MaceTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.TwoHandedTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.CripplingStrikes,
				::Const.Perks.PerkDefs.LegendSpecialistScytheSkill,
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.PTRDeepImpact,
				::Const.Perks.PerkDefs.Taunt,
				::Const.Perks.PerkDefs.PTRRattle,
				::Const.Perks.PerkDefs.LegendPossession
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.CoupDeGrace,
				::Const.Perks.PerkDefs.LegendWither,
				::Const.Perks.PerkDefs.LegendPrepareBleed,
				::Const.Perks.PerkDefs.LegendPrepareGraze,
				::Const.Perks.PerkDefs.PTRMenacing
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
				::Const.Perks.PerkDefs.Debilitate,
				::Const.Perks.PerkDefs.Steadfast,
				::Const.Perks.PerkDefs.LegendRust,
				::Const.Perks.PerkDefs.LegendBloodbath
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendLacerate,
				::Const.Perks.PerkDefs.PTRDismemberment,
				::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
				::Const.Perks.PerkDefs.LegendFavouredEnemyNomad,
				::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner,
				::Const.Perks.PerkDefs.LegendMasteryStaves,
				::Const.Perks.PerkDefs.LegendEfficientPacking,
				::Const.Perks.PerkDefs.SunderingStrikes
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Underdog,
				::Const.Perks.PerkDefs.LegendInsects,
				::Const.Perks.PerkDefs.PTRUtilitarian,
				::Const.Perks.PerkDefs.LegendSlaughter,
				::Const.Perks.PerkDefs.LegendSkillfulStacking,
				::Const.Perks.PerkDefs.PTRBully
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.SunderingStrikes,
				::Const.Perks.PerkDefs.Berserk,
				::Const.Perks.PerkDefs.LegendSiphon,
				::Const.Perks.PerkDefs.Fearsome
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRTunnelVision,
				::Const.Perks.PerkDefs.LegendMuscularity,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.BattleFlow,
				::Const.Perks.PerkDefs.LegendMiasma,
				::Const.Perks.PerkDefs.LegendDeathtouch,
				::Const.Perks.PerkDefs.PTRRisingStar
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
