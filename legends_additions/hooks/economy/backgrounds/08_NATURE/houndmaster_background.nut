::mods_hookExactClass("skills/backgrounds/houndmaster_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.AlpTree]
		];

		this.m.PerkTreeDynamic = {
			Class = [
				::Const.Perks.HoundmasterClassTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(this.new("scripts/items/accessory/wardog_item"));
		}
		else
		{
			items.equip(this.new("scripts/items/accessory/warhound_item"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				""
			]
		]));
	}

});

