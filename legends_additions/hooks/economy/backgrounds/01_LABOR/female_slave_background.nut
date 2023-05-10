::mods_hookExactClass("skills/backgrounds/female_slave_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.SouthernersTree],
			[1.5, ::Const.Perks.CalmTree],
			[2, ::Const.Perks.FlailTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.PauperProfessionTree
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
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"oriental/cloth_sash"
			],
			[
				2,
				""
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"legend_headband_coin"
			],
			[
				1,
				"legend_headress_coin"
			],
			[
				1,
				"legend_earings"
			],
			[
				5,
				"legend_southern_veil"
			],
			[
				1,
				"legend_southern_veil_coin"
			],
			[
				1,
				"legend_southern_cloth_headress"
			]
		]));
	}

});
