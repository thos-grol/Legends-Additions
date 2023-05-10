::mods_hookExactClass("skills/backgrounds/legend_vala_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		::PTR.HooksHelper.addPerkTreesToCustomPerkTree(this.m.CustomPerkTree,
			 [
			 	 ::Const.Perks.ValaSpiritMagicTree,
				 ::Const.Perks.ValaChantMagicTree,
				 ::Const.Perks.ValaTranceMagicTree,
				 ::Const.Perks.CalmTree,
				 ::Const.Perks.TalentedTree,
				 ::Const.Perks.SergeantClassTree,
				 ::Const.Perks.LightArmorTree,
				 ::Const.Perks.TwoHandedTree,
				 ::Const.Perks.MaceTree,
			 ]
		);

		::PTR.HooksHelper.addPerksToCustomPerkTree(7, this.m.CustomPerkTree, [
				::Const.Perks.PerkDefs.PTRRisingStar
			]
		);
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = this.Math.rand(2, 3);
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_staff_vala"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"legend_vala_cloak"
			],
			[
				1,
				"legend_vala_dress"
			]
		]));
	}

});

