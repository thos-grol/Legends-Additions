::mods_hookExactClass("skills/backgrounds/legend_taxidermist_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[5, ::Const.Perks.TrapperClassTree],
			[2, ::Const.Perks.HoundmasterClassTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ServiceProfessionTree
			],
			Enemy = [
				::Const.Perks.BeastsTree
			],
		 	Traits = [
				::Const.Perks.OrganisedTree
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
				"legend_blacksmith_apron"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"feathered_hat"
			]
		]));
	}

});

