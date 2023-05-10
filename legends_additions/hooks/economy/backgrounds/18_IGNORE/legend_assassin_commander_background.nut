::mods_hookExactClass("skills/backgrounds/legend_assassin_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.DaggerTree,
				::Const.Perks.SwordTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.UnstoppableTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.TrapperClassTree,
				::Const.Perks.MaceTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendSpecialistKnifeSkill,
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.Pathfinder,
				::Const.Perks.PerkDefs.LegendAlert,
				::Const.Perks.PerkDefs.LegendHairSplitter,
				::Const.Perks.PerkDefs.PTRDeepCuts,
				::Const.Perks.PerkDefs.Recover,
				::Const.Perks.PerkDefs.NineLives
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRBetweenTheEyes,
				::Const.Perks.PerkDefs.Footwork,
				::Const.Perks.PerkDefs.QuickHands,
				::Const.Perks.PerkDefs.LegendSpecialistKnifeDamage,
				::Const.Perks.PerkDefs.PTRSmallTarget,
				::Const.Perks.PerkDefs.PTRMenacing,
				::Const.Perks.PerkDefs.FortifiedMind
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner,
				::Const.Perks.PerkDefs.Sprint,
				::Const.Perks.PerkDefs.PTRVigilant,
				::Const.Perks.PerkDefs.PTRPatternRecognition,
				::Const.Perks.PerkDefs.Rotation,
				::Const.Perks.PerkDefs.Overwhelm
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTROffhandTraining,
				::Const.Perks.PerkDefs.LegendPoisonImmunity,
				::Const.Perks.PerkDefs.LegendHidden,
				::Const.Perks.PerkDefs.HeadHunter,
				::Const.Perks.PerkDefs.Duelist,
				::Const.Perks.PerkDefs.BoondockBlade,
				::Const.Perks.PerkDefs.PTRKnowTheirWeakness,
				::Const.Perks.PerkDefs.LegendBackflip
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRTraumaSurvivor,
				::Const.Perks.PerkDefs.PTRFreshAndFurious,
				::Const.Perks.PerkDefs.PTRVigorousAssault,
				::Const.Perks.PerkDefs.LegendClarity,
				::Const.Perks.PerkDefs.LegendTwirl
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Backstabber,
				::Const.Perks.PerkDefs.BattleFlow,
				::Const.Perks.PerkDefs.Rebound,
				::Const.Perks.PerkDefs.LegendAssassinate,
				::Const.Perks.PerkDefs.PTRPrimalFear,
				::Const.Perks.PerkDefs.LegendTumble
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRVanguardDeployment,
				::Const.Perks.PerkDefs.BFFencer,
				::Const.Perks.PerkDefs.PTRBully,
				::Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.PTRTunnelVision,
				::Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
