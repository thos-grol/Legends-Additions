::mods_hookExactClass("skills/backgrounds/legend_noble_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.NobleProfessionTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.TwoHandedTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.SergeantClassTree,
				::Const.Perks.TacticianClassTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.CalmTree,
				::Const.Perks.TrainedTree,
				::Const.Perks.TalentedTree,
				::Const.Perks.SwordTree,
				::Const.Perks.FlailTree,
				::Const.Perks.MediumArmorTree
			]
		);


		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Recover,
				::Const.Perks.PerkDefs.Pathfinder,
				::Const.Perks.PerkDefs.BagsAndBelts
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Anticipation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRPatternRecognition
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
				::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner,
				::Const.Perks.PerkDefs.LegendFavouredEnemyBandit,
				::Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRExudeConfidence,
				::Const.Perks.PerkDefs.Footwork,
				::Const.Perks.PerkDefs.PTRBetweenTheEyes
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRBully
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendRelax,
				::Const.Perks.PerkDefs.Rebound,
				::Const.Perks.PerkDefs.BattleFlow
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"noble_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"legend_noble_hat"
			],
			[
				1,
				"legend_noble_crown"
			],
			[
				1,
				"legend_noble_floppy_hat"
			],
			[
				1,
				"legend_noble_hood"
			]
		]));
		local r;
		r = this.Math.rand(1, 3);

		if (r <= 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
			items.equip(this.new("scripts/items/weapons/legend_parrying_dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/fencing_sword"));
			items.equip(this.new("scripts/items/weapons/legend_parrying_dagger"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_estoc"));
		}
	}

});

