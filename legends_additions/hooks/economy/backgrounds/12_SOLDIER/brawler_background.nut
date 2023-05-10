::mods_hookExactClass("skills/backgrounds/brawler_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.TalentedTree],
			[0.25, ::Const.Perks.OrganisedTree],
			[2, ::Const.Perks.SergeantClassTree],
			[2, ::Const.Perks.ViciousTree],
			[2, ::Const.Perks.UnstoppableTree],
			[1.5, ::Const.Perks.HeavyArmorTree]
		];

		this.m.PerkTreeDynamic = {};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			]
		]));
	}

});

