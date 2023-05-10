::mods_hookExactClass("skills/backgrounds/farmhand_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.TalentedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[8.33, ::Const.Perks.ButcherProfessionTree],
					[8.33, ::Const.Perks.BlacksmithProfessionTree],
					[8.33, ::Const.Perks.LaborerProfessionTree],
					[75, ::Const.Perks.FarmerProfessionTree]
				])
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
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

