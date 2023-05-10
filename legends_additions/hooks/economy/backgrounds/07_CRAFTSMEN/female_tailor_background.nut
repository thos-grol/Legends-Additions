::mods_hookExactClass("skills/backgrounds/female_tailor_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.5, ::Const.Perks.TalentedTree],
			[1.5, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.MenderClassTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ServiceProfessionTree
			],
			Class = [
				::Const.Perks.MenderClassTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic"
			],
			[
				1,
				"legend_maid_dress"
			],
			[
				1,
				"legend_maid_apron"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			],
			[
				1,
				""
			]
		]));
	}

});

