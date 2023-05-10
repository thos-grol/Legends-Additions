::mods_hookExactClass("skills/backgrounds/legend_nun_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.25, ::Const.Perks.UnstoppableTree],
			[3, ::Const.Perks.OrganisedTree],
			[0.25, ::Const.Perks.ViciousTree],
			[2, ::Const.Perks.TalentedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.HolyManProfessionTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.SergeantClassTree],
					[50, ::Const.Perks.HealerClassTree]
				])

			],
			Weapon = [
				::Const.Perks.MaceTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"legend_nun_habit"
			]
		]));
		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"legend_nun_robe_dark"
			],
			[
				1,
				"legend_nun_robe_light"
			]
		]));
	}

});

