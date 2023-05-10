::mods_hookExactClass("skills/backgrounds/legend_alchemist_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ApothecaryProfessionTree
			],
			Enemy = [
				::Const.Perks.MysticTree
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
				3,
				"oriental/vizier_gear"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				2,
				""
			],
			[
				1,
				"oriental/vizier_headgear"
			],
			[
				1,
				"oriental/engineer_hat"
			]
		]));
	}

});

