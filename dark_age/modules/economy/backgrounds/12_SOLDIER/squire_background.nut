//Disabled
::mods_hookExactClass("skills/backgrounds/squire_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.AxeTree,
				::Const.Perks.HammerTree,
				::Const.Perks.BowTree,
				::Const.Perks.ShieldTree,
			],
			Defense = [],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.FitTree,
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = ::Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/shortsword"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/boar_spear"));
		}

		r = ::Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(::new("scripts/items/shields/wooden_shield"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_leather"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"padded_surcoat"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			]
		]));
	}

});

