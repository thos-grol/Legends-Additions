::mods_hookExactClass("skills/backgrounds/female_farmhand_background", function(o) {
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
		local r = this.Math.rand(0, 6);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			if (this.isBackgroundType(this.Const.BackgroundType.Female))
			{
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"legend_maid_dress"
					]
				]));
			}
			else
			{
				local item = this.Const.World.Common.pickArmor([
					[
						1,
						"linen_tunic",
						this.Math.rand(6, 7)
					]
				]);
				items.equip(item);
			}
		}
		else if (r == 1)
		{
			if (this.isBackgroundType(this.Const.BackgroundType.Female))
			{
				items.equip(this.Const.World.Common.pickArmor([
					[
						1,
						"legend_maid_apron"
					]
				]));
			}
			else
			{
				local item = this.Const.World.Common.pickArmor([
					[
						1,
						"linen_tunic",
						this.Math.rand(6, 7)
					]
				]);
				items.equip(item);
			}
		}

		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"straw_hat"
			],
			[
				2,
				""
			]
		]));
	}

});

