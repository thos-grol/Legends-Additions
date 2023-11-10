//disabled
::mods_hookExactClass("skills/backgrounds/legend_muladi_background", function(o) {
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

		if (::Const.DLC.Wildmen)
		{
			r = this.Math.rand(1, 100);

			if (r <= 50)
			{
				items.equip(::new("scripts/items/weapons/short_bow"));
				items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r <= 80)
			{
				items.equip(::new("scripts/items/weapons/legend_sling"));
			}
			else
			{
				items.equip(::new("scripts/items/weapons/wonky_bow"));
				items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			}
		}
		else
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				items.equip(::new("scripts/items/weapons/short_bow"));
			}
			else
			{
				items.equip(::new("scripts/items/weapons/wonky_bow"));
			}

			items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.addToBag(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.addToBag(::new("scripts/items/weapons/militia_spear"));
		}

		items.equip(::new("scripts/items/accessory/wardog_item"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/nomad_robe"
			],
			[
				1,
				"oriental/thick_nomad_robe"
			],
			[
				1,
				"oriental/cloth_sash"
			]
		]));
		local helm = ::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/southern_head_wrap"
			],
			[
				1,
				"oriental/leather_head_wrap"
			],
			[
				1,
				"oriental/nomad_head_wrap"
			]
		]);
		items.equip(helm);
	}

});

