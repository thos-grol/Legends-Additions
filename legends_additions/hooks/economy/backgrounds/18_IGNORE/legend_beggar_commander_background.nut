::mods_hookExactClass("skills/backgrounds/legend_beggar_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.SlingTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRBearDown,
				::Const.Perks.PerkDefs.PTRPushIt,
				::Const.Perks.PerkDefs.PTRRattle,
				::Const.Perks.PerkDefs.LegendSmackdown,
				::Const.Perks.PerkDefs.CripplingStrikes,
				::Const.Perks.PerkDefs.PTRSwordlike,
				::Const.Perks.PerkDefs.PTRVersatileWeapon,
				::Const.Perks.PerkDefs.PTRSmallTarget,
				::Const.Perks.PerkDefs.Pathfinder,
				::Const.Perks.PerkDefs.NineLives,
				::Const.Perks.PerkDefs.Recover,
				::Const.Perks.PerkDefs.BagsAndBelts

			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRPointyEnd,
				::Const.Perks.PerkDefs.PTRBloodyHarvest,
				::Const.Perks.PerkDefs.PTRDeepCuts,
				::Const.Perks.PerkDefs.Bullseye,
				::Const.Perks.PerkDefs.CoupDeGrace,
				::Const.Perks.PerkDefs.PTRHybridization,
				::Const.Perks.PerkDefs.LegendSmashingShields,
				::Const.Perks.PerkDefs.Backstabber,
				::Const.Perks.PerkDefs.Dodge,
				::Const.Perks.PerkDefs.HoldOut,
				::Const.Perks.PerkDefs.QuickHands,
				::Const.Perks.PerkDefs.LegendOnslaught
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTREntrenched,
				::Const.Perks.PerkDefs.PTRHeadSmasher,
				::Const.Perks.PerkDefs.PTRDismemberment,
				::Const.Perks.PerkDefs.STRPhalanx,
				::Const.Perks.PerkDefs.PTRDeepImpact,
				::Const.Perks.PerkDefs.SteelBrow,
				::Const.Perks.PerkDefs.LegendEfficientPacking,
				::Const.Perks.PerkDefs.PTRThroughTheGaps,
				::Const.Perks.PerkDefs.PTRSurvivalInstinct,
				::Const.Perks.PerkDefs.Anticipation,
				::Const.Perks.PerkDefs.Rotation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Debilitate,
				::Const.Perks.PerkDefs.PTRLeverage,
				::Const.Perks.PerkDefs.ShieldExpert,
				::Const.Perks.PerkDefs.SpecDagger,
				::Const.Perks.PerkDefs.PTRFormidableApproach,
				::Const.Perks.PerkDefs.Taunt,
				::Const.Perks.PerkDefs.PTRPunchingBag,
				::Const.Perks.PerkDefs.Steadfast,
				::Const.Perks.PerkDefs.SpecSpear,
				::Const.Perks.PerkDefs.SpecSword,
				::Const.Perks.PerkDefs.PTRPowerShot,
				::Const.Perks.PerkDefs.Relentless
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.SpecHammer,
				::Const.Perks.PerkDefs.SpecFlail,
				::Const.Perks.PerkDefs.SpecMace,
				::Const.Perks.PerkDefs.SpecPolearm,
				::Const.Perks.PerkDefs.LegendMasteryStaves,
				::Const.Perks.PerkDefs.SpecCrossbow,
				::Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
				::Const.Perks.PerkDefs.SpecThrowing,
				::Const.Perks.PerkDefs.SpecAxe,
				::Const.Perks.PerkDefs.SpecCleaver,
				::Const.Perks.PerkDefs.LegendSkillfulStacking
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTROffhandTraining,
				::Const.Perks.PerkDefs.PTRSweepingStrikes,
				::Const.Perks.PerkDefs.PTRSoftMetal,
				::Const.Perks.PerkDefs.Duelist,
				::Const.Perks.PerkDefs.PTRIronSights,
				::Const.Perks.PerkDefs.PTRConcussiveStrikes,
				::Const.Perks.PerkDefs.ReachAdvantage,
				::Const.Perks.PerkDefs.LegendWindReader,
				::Const.Perks.PerkDefs.PTRTraumaSurvivor,
				::Const.Perks.PerkDefs.Underdog,
				::Const.Perks.PerkDefs.SunderingStrikes,
				::Const.Perks.PerkDefs.Nimble
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PushTheAdvantage,
				::Const.Perks.PerkDefs.PTRUtilitarian,
				::Const.Perks.PerkDefs.LegendSpecSpearWall,
				::Const.Perks.PerkDefs.Footwork,
				::Const.Perks.PerkDefs.Ballistics,
				::Const.Perks.PerkDefs.PTRNailedIt,
				::Const.Perks.PerkDefs.HeadHunter,
				::Const.Perks.PerkDefs.Overwhelm,
				::Const.Perks.PerkDefs.PTRMarksmanship,
				::Const.Perks.PerkDefs.PTRMuscleMemory,
				::Const.Perks.PerkDefs.PTRStrengthInNumbers,
				::Const.Perks.PerkDefs.Fearsome
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
