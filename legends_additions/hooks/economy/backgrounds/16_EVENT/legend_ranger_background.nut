::mods_hookExactClass("skills/backgrounds/legend_ranger_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			[
				::Const.Perks.BowTree,
				
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
				::Const.Perks.PerkDefs.LegendHairSplitter,
				::Const.Perks.PerkDefs.LegendBigGameHunter,
				::Const.Perks.PerkDefs.KillingFrenzy,
				::Const.Perks.PerkDefs.HeadHunter,
				::Const.Perks.PerkDefs.PTRDeathFromAfar
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 3;
		talents[this.Const.Attributes.Fatigue] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		stash.add(this.new("scripts/items/supplies/cured_venison_item"));
		stash.add(this.new("scripts/items/accessory/wardog_item"));
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/bludgeon"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"leather_tunic"
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

