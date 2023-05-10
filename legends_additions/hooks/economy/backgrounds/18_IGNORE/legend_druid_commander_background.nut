::mods_hookExactClass("skills/backgrounds/legend_druid_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.HoundmasterClassTree,
				::Const.Perks.AgileTree,
				::Const.Perks.ResilientTree,
				::Const.Perks.CalmTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.MediumArmorTree,
				::Const.Perks.MaceTree,
				::Const.Perks.TwoHandedTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.NineLives,
				::Const.Perks.PerkDefs.Recover,
				::Const.Perks.PerkDefs.LegendAlert,
				::Const.Perks.PerkDefs.LegendBlendIn,
				::Const.Perks.PerkDefs.LegendPoisonImmunity,
				::Const.Perks.PerkDefs.LegendWither,
				::Const.Perks.PerkDefs.LegendSummonHound,
				::Const.Perks.PerkDefs.PTRFruitsOfLabor,
				::Const.Perks.PerkDefs.Student
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendScryTrance,
				::Const.Perks.PerkDefs.QuickHands,
				::Const.Perks.PerkDefs.LegendNightvision,
				::Const.Perks.PerkDefs.LegendGatherer,
				::Const.Perks.PerkDefs.Gifted
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendRoots,
				::Const.Perks.PerkDefs.LegendHerbcraft,
				::Const.Perks.PerkDefs.ShieldExpert,
				::Const.Perks.PerkDefs.Rotation,
				::Const.Perks.PerkDefs.Sprint
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendSpecPoison,
				::Const.Perks.PerkDefs.LegendSummonWolf,
				::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner,
				::Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
				::Const.Perks.PerkDefs.PTRBearDown,
				::Const.Perks.PerkDefs.PTRDiscoveredTalent,
				::Const.Perks.PerkDefs.PTRTunnelVision,
				::Const.Perks.PerkDefs.PTRDynamicDuo,
				::Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
				::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendHidden,
				::Const.Perks.PerkDefs.PTRHaleAndHearty,
				::Const.Perks.PerkDefs.Footwork,
				::Const.Perks.PerkDefs.LegendWoodworking,
				::Const.Perks.PerkDefs.LegendInsects,
				::Const.Perks.PerkDefs.LegendPotionBrewer,
				::Const.Perks.PerkDefs.LegendReadOmensTrance
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendClarity,
				::Const.Perks.PerkDefs.LegendUntouchable,
				::Const.Perks.PerkDefs.PTRVigorousAssault,
				::Const.Perks.PerkDefs.LegendSummonStorm,
				::Const.Perks.PerkDefs.LegendDrumsOfLife,
				::Const.Perks.PerkDefs.LegendDistantVisions
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Rebound,
				::Const.Perks.PerkDefs.PTRRisingStar,
				::Const.Perks.PerkDefs.LegendQuartermaster,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.LegendSummonBear,
				::Const.Perks.PerkDefs.LegendMiasma,
				::Const.Perks.PerkDefs.LegendDrumsOfWar
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
