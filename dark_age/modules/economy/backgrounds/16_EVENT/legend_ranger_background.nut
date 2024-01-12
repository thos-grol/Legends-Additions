::mods_hookExactClass("skills/backgrounds/legend_ranger_background", function(o) {
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
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.RangedSkill] = 3;
		talents[::Const.Attributes.Fatigue] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(::new("scripts/items/weapons/hunting_bow"));
		items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
		local stash = this.World.Assets.getStash();
		stash.add(::new("scripts/items/ammo/quiver_of_arrows"));
		stash.add(::new("scripts/items/supplies/cured_venison_item"));
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		r = ::Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(::new("scripts/items/weapons/knife"));
		}

		if (r == 1)
		{
			items.addToBag(::new("scripts/items/weapons/bludgeon"));
		}

		items.equip(::Const.World.Common.pickArmor([
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
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));
	}

});

