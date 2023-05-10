::mods_hookExactClass("skills/backgrounds/legend_ranger_commander_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.BowTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.RangedTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.AgileTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.FastTree,
				::Const.Perks.BeastsTree,
				::Const.Perks.OrcsTree,
				::Const.Perks.ArchersTree,
				::Const.Perks.HoundmasterClassTree,
				::Const.Perks.CrossbowTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.FastAdaption,
				::Const.Perks.PerkDefs.LegendMarkTarget,
				::Const.Perks.PerkDefs.Adrenaline,
				::Const.Perks.PerkDefs.Recover,
				::Const.Perks.PerkDefs.LegendSummonHound,
				::Const.Perks.PerkDefs.PTRSmallTarget
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendOnslaught,
				::Const.Perks.PerkDefs.SpecSpear,
				::Const.Perks.PerkDefs.Rotation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendHairSplitter,
				::Const.Perks.PerkDefs.PTRPatience,
				::Const.Perks.PerkDefs.LegendSummonFalcon,
				::Const.Perks.PerkDefs.LegendAmmoBinding
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Berserk,
				::Const.Perks.PerkDefs.LegendSummonWolf,
				::Const.Perks.PerkDefs.LegendAmmoBundles
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendCascade,
				::Const.Perks.PerkDefs.PTRUnstoppable,
				::Const.Perks.PerkDefs.PTRKnowTheirWeakness,
				::Const.Perks.PerkDefs.LegendHidden
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.LegendBigGameHunter,
				::Const.Perks.PerkDefs.KillingFrenzy,
				::Const.Perks.PerkDefs.HeadHunter,
				::Const.Perks.PerkDefs.PTRDeathFromAfar
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

});
