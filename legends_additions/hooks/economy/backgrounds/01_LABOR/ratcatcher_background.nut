::mods_hookExactClass("skills/backgrounds/ratcatcher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[5, ::Const.Perks.FastTree],
			[5, ::Const.Perks.AgileTree],
			[2, ::Const.Perks.ViciousTree]
		];

		this.m.PerkTreeDynamic = {
			Class = [
				::Const.Perks.TrapperClassTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"sackcloth"
			]
		]));
	}

});

