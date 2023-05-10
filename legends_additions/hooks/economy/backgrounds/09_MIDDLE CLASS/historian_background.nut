::mods_hookExactClass("skills/backgrounds/historian_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.66, ::Const.Perks.OrganisedTree],
			[0.25, ::Const.Perks.TrapperClassTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.PhilosophyMagicTree
			],
			Traits = [
				::Const.Perks.TalentedTree,
				::Const.Perks.CalmTree
			],
			Class = [
				::Const.Perks.TacticianClassTree
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
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			],
			[
				3,
				""
			]
		]));
	}

});
