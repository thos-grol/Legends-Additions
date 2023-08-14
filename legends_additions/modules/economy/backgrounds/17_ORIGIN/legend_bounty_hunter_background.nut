::mods_hookExactClass("skills/backgrounds/legend_bounty_hunter_background", function(o) {
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
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/battle_whip"));
			items.equip(this.new("scripts/items/shields/buckler_shield"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/oriental/heavy_southern_mace"));
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
			items.equip(this.new("scripts/items/tools/daze_bomb_item"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/swordlance"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/oriental/two_handed_saif"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/assassin_robe"
			],
			[
				1,
				"oriental/cloth_sash"
			],
			[
				1,
				"blade_dancer_armor_00"
			]
		]));
		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/assassin_face_mask"
			],
			[
				1,
				"theamson_barbute_helmet"
			],
			[
				1,
				"blade_dancer_helmet_00"
			]
		]);
		items.equip(helm);
	}

});
