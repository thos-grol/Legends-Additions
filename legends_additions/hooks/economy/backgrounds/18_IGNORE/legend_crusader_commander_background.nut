::mods_hookExactClass("skills/backgrounds/legend_crusader_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.SturdyTree
			]
		);

		local trees = [
			::Const.Perks.AxeTree,
			::Const.Perks.CleaverTree,
			::Const.Perks.FlailTree,
			::Const.Perks.HammerTree,
			::Const.Perks.MaceTree,
			::Const.Perks.SwordTree
		];

		for (local i = 0; i < 4; ++i)
		{
			::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [trees.remove(::Math.rand(0, trees.len()-1))]);
		}

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.STRPhalanx,
				::Const.Perks.PerkDefs.LegendFavouredEnemyZombie,
				::Const.Perks.PerkDefs.LegendHairSplitter,
				::Const.Perks.PerkDefs.PTRExploitOpening,
				::Const.Perks.PerkDefs.HoldOut,
				::Const.Perks.PerkDefs.PTRSmallTarget
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.RallyTheTroops,
				::Const.Perks.PerkDefs.STRCoverAlly,
				::Const.Perks.PerkDefs.PTRDismemberment,
				::Const.Perks.PerkDefs.PTRExudeConfidence,
				::Const.Perks.PerkDefs.PTRSanguinary,
				::Const.Perks.PerkDefs.QuickHands
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendShieldsUp,
				::Const.Perks.PerkDefs.FortifiedMind,
				::Const.Perks.PerkDefs.Steadfast,
				::Const.Perks.PerkDefs.Rotation,
				::Const.Perks.PerkDefs.PTRFormidableApproach
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendFavouredEnemySkeleton,
				::Const.Perks.PerkDefs.STRLineBreaker,
				::Const.Perks.PerkDefs.LegendFavouredEnemyVampire,
				::Const.Perks.PerkDefs.SunderingStrikes,
				::Const.Perks.PerkDefs.PTRTheRushOfBattle,
				::Const.Perks.PerkDefs.LegendHoldTheLine,
				::Const.Perks.PerkDefs.LegendPrayerOfFaith,
				::Const.Perks.PerkDefs.PTRVigilant,
				::Const.Perks.PerkDefs.LegendPrayerOfLife

			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.DoubleStrike,
				::Const.Perks.PerkDefs.LegendSecondWind,
				::Const.Perks.PerkDefs.LegendBattleheart,
				::Const.Perks.PerkDefs.Berserk,
				::Const.Perks.PerkDefs.PTRPatternRecognition
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRVigorousAssault,
				::Const.Perks.PerkDefs.LegendMindOverBody,
				::Const.Perks.PerkDefs.LegendHolyFlame,
				::Const.Perks.PerkDefs.LegendClarity,
				::Const.Perks.PerkDefs.PTRSweepingStrikes
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.BattleFlow,
				::Const.Perks.PerkDefs.LastStand,
				::Const.Perks.PerkDefs.Inspire,
				::Const.Perks.PerkDefs.PTRProfessional,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.Rebound
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
