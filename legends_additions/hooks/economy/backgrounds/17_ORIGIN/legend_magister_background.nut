::mods_hookExactClass("skills/backgrounds/legend_magister_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 1;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_reinforced_flail"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 4)
		{
			if (this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/battle_whip"));
			}
			else if (!this.Const.DLC.Wildmen)
			{
				items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
		}
		else if (r >= 5)
		{
			items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}

		items.equip(this.Const.World.Common.pickArmor([
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
				"monk_robe"
			],
			[
				1,
				"cultist_leather_robe"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"cultist_hood"
			],
			[
				1,
				"hood"
			],
			[
				1,
				"cultist_leather_hood"
			]
		]));
	}

});

