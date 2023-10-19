::mods_hookExactClass("skills/backgrounds/monk_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.FlailTree,
				::Const.Perks.HammerTree
			],
			Defense = [],
			Traits = [
				::Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FaithClassTree
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
				"monk_robe"
			]
		]));
	}

});

