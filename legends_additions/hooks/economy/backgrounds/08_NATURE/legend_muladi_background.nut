::mods_hookExactClass("skills/backgrounds/legend_muladi_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.ResilientTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.HunterProfessionTree
			],
			Traits = [
				::Const.Perks.AgileTree
			],
			Class = [
				::Const.Perks.ScoutClassTree
			],
			Weapon = [
				::MSU.Class.WeightedContainer([
					[25, ::Const.Perks.BowTree],
					[25, ::Const.Perks.CrossbowTree],
					[25, ::Const.Perks.SlingTree],
					[25, ::Const.Perks.ThrowingTree]
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

		if (this.Const.DLC.Wildmen)
		{
			r = this.Math.rand(1, 100);

			if (r <= 50)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r <= 80)
			{
				items.equip(this.new("scripts/items/weapons/legend_sling"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
				items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
		}
		else
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				items.equip(this.new("scripts/items/weapons/short_bow"));
			}
			else
			{
				items.equip(this.new("scripts/items/weapons/wonky_bow"));
			}

			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/militia_spear"));
		}

		items.equip(this.new("scripts/items/accessory/wardog_item"));
		items.equip(this.Const.World.Common.pickArmor([
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
		local helm = this.Const.World.Common.pickHelmet([
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

