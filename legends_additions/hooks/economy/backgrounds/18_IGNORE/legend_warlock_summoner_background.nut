::mods_hookExactClass("skills/backgrounds/legend_warlock_summoner_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree, [
				::Const.Perks.TalentedTree,
				::Const.Perks.ChefClassTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.MediumArmorTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.MaceTree,
				::Const.Perks.TwoHandedTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.CripplingStrikes,
				::Const.Perks.PerkDefs.LegendSpawnZombieLow,
				::Const.Perks.PerkDefs.NineLives,
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.Recover,
				::Const.Perks.PerkDefs.LegendSpecialistScytheSkill
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.CoupDeGrace,
				::Const.Perks.PerkDefs.Backstabber,
				::Const.Perks.PerkDefs.LegendPrepareBleed,
				::Const.Perks.PerkDefs.LegendPrepareGraze,
				::Const.Perks.PerkDefs.QuickHands
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.HoldOut,
				::Const.Perks.PerkDefs.Debilitate,
				::Const.Perks.PerkDefs.LegendEfficientPacking,
				::Const.Perks.PerkDefs.Rotation,
				::Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
				::Const.Perks.PerkDefs.LegendBloodbath
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRDismemberment,
				::Const.Perks.PerkDefs.ShieldExpert,
				::Const.Perks.PerkDefs.PTRVigilant,
				::Const.Perks.PerkDefs.LegendSpecPoison,
				::Const.Perks.PerkDefs.LegendLacerate,
				::Const.Perks.PerkDefs.LegendSpawnZombieMed,
				::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
				::Const.Perks.PerkDefs.LegendFavouredEnemyBandit,
				::Const.Perks.PerkDefs.LegendFavouredEnemyNoble
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendBlendIn,
				::Const.Perks.PerkDefs.Underdog,
				::Const.Perks.PerkDefs.LegendSkillfulStacking,
				::Const.Perks.PerkDefs.LegendReclamation,
				::Const.Perks.PerkDefs.LegendSlaughter
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Duelist,
				::Const.Perks.PerkDefs.LegendHidden
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Fearsome,
				::Const.Perks.PerkDefs.PTRTunnelVision,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.LegendSpawnZombieHigh,
				::Const.Perks.PerkDefs.LegendExtendendAura,
				::Const.Perks.PerkDefs.PTRRisingStar
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
