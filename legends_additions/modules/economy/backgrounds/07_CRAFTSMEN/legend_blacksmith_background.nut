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
				::Const.Perks.HammerTree
			],
			Defense = [],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.HammerClassTree,
				::Const.Perks.RepairClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_hammer"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"legend_blacksmith_apron"
			]
		]));
	}

});

