::mods_hookExactClass("skills/backgrounds/female_slave_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [],
			Magic = []
		};
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
