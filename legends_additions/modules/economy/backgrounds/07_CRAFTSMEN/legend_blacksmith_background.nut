//disabled
::mods_hookExactClass("skills/backgrounds/legend_blacksmith_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [
				this.Const.Perks.HammerClassTree,
				this.Const.Perks.RepairClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_hammer"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"legend_blacksmith_apron"
			]
		]));
	}

});

