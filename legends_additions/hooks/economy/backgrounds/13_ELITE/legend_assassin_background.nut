::mods_hookExactClass("skills/backgrounds/legend_assassin_background", function(o) {
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
				::Const.Perks.AgileTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.FastTree,
				::Const.Perks.UnstoppableTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.TrapperClassTree,
				::Const.Perks.MaceTree
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendSpecialistKnifeSkill,
				::Const.Perks.PerkDefs.BagsAndBelts,
				::Const.Perks.PerkDefs.Recover,
				::Const.Perks.PerkDefs.PTRSmallTarget,
				::Const.Perks.PerkDefs.PTRDeepCuts,
				::Const.Perks.PerkDefs.NineLives
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRBetweenTheEyes,
				::Const.Perks.PerkDefs.LegendSpecialistKnifeDamage,
				::Const.Perks.PerkDefs.LegendHairSplitter,
				::Const.Perks.PerkDefs.PTRTunnelVision
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendHidden,
				::Const.Perks.PerkDefs.PTRVigilant,
				::Const.Perks.PerkDefs.PTRPatternRecognition,
				::Const.Perks.PerkDefs.Rotation,
				::Const.Perks.PerkDefs.PTRTraumaSurvivor
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTROffhandTraining,
				::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner,
				::Const.Perks.PerkDefs.LegendPoisonImmunity,
				::Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
				::Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster,
				::Const.Perks.PerkDefs.BoondockBlade,
				::Const.Perks.PerkDefs.LegendBackflip
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.DoubleStrike,
				::Const.Perks.PerkDefs.HeadHunter,
				::Const.Perks.PerkDefs.PTRKnowTheirWeakness
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Duelist,
				::Const.Perks.PerkDefs.PTRPrimalFear,
				::Const.Perks.PerkDefs.LegendClarity,
				::Const.Perks.PerkDefs.LegendTwirl
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRVanguardDeployment,
				::Const.Perks.PerkDefs.BFFencer,
				::Const.Perks.PerkDefs.PerfectFocus,
				::Const.Perks.PerkDefs.LegendAssassinate,
				::Const.Perks.PerkDefs.LegendTumble
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 3;
		talents[this.Const.Attributes.Initiative] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"thick_dark_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));
	}

});
