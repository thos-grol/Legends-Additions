::mods_hookExactClass("skills/backgrounds/beast_hunter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.SpecialPerkMultipliers = [
			[5, ::Const.Perks.PerkDefs.LegendBigGameHunter]
		];

		this.m.PerkGroupMultipliers <- [
			[3, ::Const.Perks.ViciousTree],
			[0.33, ::Const.Perks.ShieldTree],
			[0.5, ::Const.Perks.FlailTree],
			[0.5, ::Const.Perks.HammerTree],
			[0.5, ::Const.Perks.MaceTree],
			[0.5, ::Const.Perks.StaffTree],
			[0.25, ::Const.Perks.SlingTree],
			[0, ::Const.Perks.ApothecaryProfessionTree],
			[0, ::Const.Perks.MinstrelProfessionTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[90, ::Const.Perks.NoTree],
					[10, ::Const.Perks.RandomTree]
				])
			],
			Enemy = [
				::Const.Perks.BeastsTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[90, ::Const.Perks.TrapperClassTree],
					[5, ::Const.Perks.ScoutClassTree],
					[5, ::Const.Perks.NoTree]
				])
			],
			Weapon = [
				::Const.Perks.SpearTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/spetum"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/javelin"));
		}

		if (this.Math.rand(1, 100) <= 50 && items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"leather_tunic"
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

