::mods_hookExactClass("skills/backgrounds/legend_berserker_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.AxeTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.FlailTree,
				::Const.Perks.SwordTree,
				::Const.Perks.TwoHandedTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.ResilientTree,
				::Const.Perks.LargeTree,
				::Const.Perks.SturdyTree,
				::Const.Perks.UnstoppableTree,
				::Const.Perks.HammerTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.Pathfinder,
				::Const.Perks.PerkDefs.PTRFruitsOfLabor
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRSavageStrength,
				::Const.Perks.PerkDefs.PTRMenacing,
				::Const.Perks.PerkDefs.Anticipation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Sprint,
				::Const.Perks.PerkDefs.PTRBestialVigor
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRVigorousAssault,
				::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin,
				::Const.Perks.PerkDefs.PTRHaleAndHearty,
				::Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
				::Const.Perks.PerkDefs.LegendPoisonImmunity,
				::Const.Perks.PerkDefs.PTRTheRushOfBattle,
				::Const.Perks.PerkDefs.PTRBully
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
			::Const.Perks.PerkDefs.BattleFlow,
			::Const.Perks.PerkDefs.LegendFavouredEnemyUnhold
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRFreshAndFurious,
				::Const.Perks.PerkDefs.PTRKnowTheirWeakness
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRBlitzkrieg,
				::Const.Perks.PerkDefs.LegendBerserkerRage,
				::Const.Perks.PerkDefs.Rebound,
				::Const.Perks.PerkDefs.LegendUberNimble
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
