::mods_hookExactClass("skills/backgrounds/poacher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.SpecialPerkMultipliers = [
			[1.5, ::Const.Perks.PerkDefs.LegendBigGameHunter],
			[1.5, ::Const.Perks.PerkDefs.PTRMarksmanship]
		];
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.AgileTree],
			[0.5, ::Const.Perks.ResilientTree],
			[0.5, ::Const.Perks.LargeTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.HunterProfessionTree
			],
			Class = [
				::Const.Perks.ScoutClassTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Weapon = [
				::Const.Perks.BowTree
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
			else if (r <= 70)
			{
				items.equip(this.new("scripts/items/weapons/legend_sling"));
			}
			else if (r <= 85)
			{
				items.equip(this.new("scripts/items/weapons/legend_slingshot"));
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

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"ragged_surcoat"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));
	}

});

