::mods_hookExactClass("skills/backgrounds/houndmaster_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.BowTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.StaffTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.SwordTree );
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(::new("scripts/items/tools/throwing_net"));
		}

		if (this.Math.rand(1, 100) >= 50)
		{
			items.equip(::new("scripts/items/accessory/wardog_item"));
		}
		else
		{
			items.equip(::new("scripts/items/accessory/warhound_item"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
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

