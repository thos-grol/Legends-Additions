::mods_hookExactClass("skills/backgrounds/gladiator_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		//FEATURE_1: remove test code

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree,
				::Const.Perks.FlailTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.SwordTree,
				// ::Const.Perks.PolearmTree,
				::Const.Perks.SpearTree,
				// ::Const.Perks.BowTree,
				::Const.Perks.AxeTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.BeastClassTree
			],
			Magic = []
		};
		//FEATURE_7: Idea? add arena wins trait to gladiator.
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/oriental/two_handed_scimitar",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/swordlance",
				"weapons/oriental/polemace",
				"weapons/fighting_axe",
				"weapons/fighting_spear"
			];

			if (::Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			local item = ::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
			this.addPerkGroup(::Z.Perks.tree(item));
			items.equip(item);
		}

		if (items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];

			local item = ::new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]);
			this.addPerkGroup(::Z.Perks.tree(item));
			items.equip(item);
		}

		local a = ::Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			a.setUpgrade(::new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		}
		else if (r == 2)
		{
			a.setUpgrade(::new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
		}

		items.equip(a);
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/gladiator_helmet",
				this.Math.rand(13, 15)
			],
			[
				1,
				""
			]
		]));
	}

});

