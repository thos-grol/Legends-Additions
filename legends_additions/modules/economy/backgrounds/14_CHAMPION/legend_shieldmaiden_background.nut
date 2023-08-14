::mods_hookExactClass("skills/backgrounds/legend_shieldmaiden_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.CrossbowTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.StaffTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, this.Const.Perks.SwordTree );
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"gambeson"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"full_leather_cap"
			],
			[
				1,
				"full_aketon_cap"
			]
		]));
		r = this.Math.rand(0, 3);

		if (r <= 2)
		{
			items.equip(this.new("scripts/items/shields/heater_shield"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/shields/legend_tower_shield"));
		}

		r = this.Math.rand(0, 4);

		if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}
	}

});

