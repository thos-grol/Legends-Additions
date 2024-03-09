//disabled
::mods_hookExactClass("skills/backgrounds/legend_herbalist_background", function(o) {
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
				::Const.Perks.SickleClassTree,
				::Const.Perks.HealerClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"legend_herbalist_robe"
			]
		]));
		items.equip(::new("scripts/items/weapons/legend_sickle"));
	}

});

