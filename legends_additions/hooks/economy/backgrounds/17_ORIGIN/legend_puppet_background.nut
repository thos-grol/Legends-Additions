::mods_hookExactClass("skills/backgrounds/legend_puppet_background.nut", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 7);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new(""));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/shields/worn_heater_shield"));
		}
		else if (r == 6)
		{
			items.equip(this.new("scripts/items/shields/worn_kite_shield"));
		}
		else if (r == 7)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"decayed_coat_of_scales"
			],
			[
				1,
				"dark_southern_armor_00"
			],
			[
				2,
				""
			],
			[
				2,
				"decayed_reinforced_mail_hauberk"
			],
			[
				2,
				"cultist_leather_robe"
			],
			[
				3,
				"basic_mail_shirt"
			],
			[
				3,
				"gambeson"
			],
			[
				4,
				"apron"
			],
			[
				4,
				"butcher_apron"
			],
			[
				4,
				"leather_tunic"
			],
			[
				5,
				"leather_wraps"
			],
			[
				5,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"decayed_closed_flat_top_with_mail"
			],
			[
				1,
				"decayed_closed_flat_top_with_sack"
			],
			[
				2,
				"full_aketon_cap"
			],
			[
				2,
				"kettle_hat"
			],
			[
				3,
				"open_leather_cap"
			],
			[
				3,
				"full_leather_cap"
			],
			[
				4,
				""
			]
		]));
	}

});

