::mods_hookExactClass("skills/backgrounds/legend_trader_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.CustomPerkTree = ::PTR.HooksHelper.clearCustomPerkTree(this.m.CustomPerkTree);

	 	::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			 [
			 	 ::Const.Perks.CrossbowTree,
				 ::Const.Perks.SwordTree,
				 ::Const.Perks.SpearTree,
				 ::Const.Perks.OneHandedTree,
				 ::Const.Perks.TwoHandedTree,
				 ::Const.Perks.RangedTree,
				 ::Const.Perks.LightArmorTree,
				 ::Const.Perks.MediumArmorTree,
				 ::Const.Perks.ShieldTree,
				 ::Const.Perks.DeviousTree,
				 ::Const.Perks.TalentedTree,
				 ::Const.Perks.EntertainerClassTree,
				 ::Const.Perks.OrganisedTree,
				 ::Const.Perks.ClerkClassTree,
				 ::Const.Perks.TraderProfessionTree
			 ]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(1, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendAlert,
				::Const.Perks.PerkDefs.LegendCheerOn,
				::Const.Perks.PerkDefs.LegendMedIngredients,
				::Const.Perks.PerkDefs.LegendMealPreperation,
				::Const.Perks.PerkDefs.NineLives,
				::Const.Perks.PerkDefs.FastAdaption
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(2, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Anticipation
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(3, this.m.CustomPerkTree, [
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(4, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRVigilant,
				::Const.Perks.PerkDefs.LegendPeaceful,
				::Const.Perks.PerkDefs.LegendShieldsUp
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(5, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Footwork,
				::Const.Perks.PerkDefs.Underdog
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(6, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.LegendHoldTheLine
			]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.Rebound
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			]
		]));
	}

});

