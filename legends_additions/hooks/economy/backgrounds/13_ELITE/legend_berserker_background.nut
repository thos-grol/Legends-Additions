::mods_hookExactClass("skills/backgrounds/legend_berserker_background", function(o) {
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
				::Const.Perks.PerkDefs.PTRFeralRage,
				::Const.Perks.PerkDefs.Rebound
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
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		stash.add(this.new("scripts/items/supplies/roots_and_berries_item"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"barbarians/hide_and_bone_armor"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_helmet"
			]
		]);
		local r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/warbrand"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_longsword"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/orc_axe_2h"));
		}

		this.getContainer().getActor().TherianthropeInfectionRandom();
	}

});
