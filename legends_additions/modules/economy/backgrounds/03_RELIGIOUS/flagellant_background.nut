::mods_hookExactClass("skills/backgrounds/flagellant_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.CrossbowTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.StaffTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.SwordTree );
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		}
		else if (r == 3)
		{
			if (::Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
			else if (!::Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/wooden_flail"));
			}
		}
		else if (r == 4)
		{
			if (::Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!::Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_reinforced_flail"));
			}
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"sackcloth"
			],
			[
				1,
				"monk_robe"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				4,
				""
			]
		]));
	}

});

