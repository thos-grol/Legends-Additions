::mods_hookExactClass("skills/backgrounds/legend_lonewolf_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.LargeTree,
				::Const.Perks.ResilientTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.UnstoppableTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.HeavyArmorTree
			]
		);

		local trees = [
			::Const.Perks.AxeTree,
			::Const.Perks.CleaverTree,
			::Const.Perks.FlailTree,
			::Const.Perks.HammerTree,
			::Const.Perks.MaceTree,
			::Const.Perks.SpearTree,
			::Const.Perks.SwordTree
		];

		for (local i = 0; i < 3; ++i)
		{
			::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [trees.remove(::Math.rand(0, trees.len()-1))]);
		}

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Student,
				::Const.Perks.PerkDefs.STRPhalanx,
				::Const.Perks.PerkDefs.PTRProfessional,
				::Const.Perks.PerkDefs.PTRMenacing
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.FortifiedMind,
				::Const.Perks.PerkDefs.PTRExudeConfidence,
				::Const.Perks.PerkDefs.Rotation,
				::Const.Perks.PerkDefs.STRCoverAlly,
				::Const.Perks.PerkDefs.Gifted
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRBully,
				::Const.Perks.PerkDefs.PTRPatternRecognition,
				::Const.Perks.PerkDefs.PTRFormidableApproach
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Underdog,
				::Const.Perks.PerkDefs.PTRWearsItWell,
				::Const.Perks.PerkDefs.PTRPersonalArmor,
				::Const.Perks.PerkDefs.PTRVigilant,
				::Const.Perks.PerkDefs.STRLineBreaker
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.DoubleStrike
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRVigorousAssault,
				::Const.Perks.PerkDefs.PTRKnowTheirWeakness,
				::Const.Perks.PerkDefs.LegendClarity,
				::Const.Perks.PerkDefs.PTRSweepingStrikes
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Rebound,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.PTRManOfSteel
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
