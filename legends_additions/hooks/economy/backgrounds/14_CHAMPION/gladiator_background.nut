::mods_hookExactClass("skills/backgrounds/gladiator_background.nut", function(o) {
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

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
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

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];
			items.equip(this.new("scripts/items/" + offhand[this.Math.rand(0, offhand.len() - 1)]));
		}

		local a = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			a.setUpgrade(this.new("scripts/items/" + (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() ? "legend_armor/armor_upgrades/legend_light_gladiator_upgrade" : "armor_upgrades/light_gladiator_upgrade")));
		}
		else if (r == 2)
		{
			a.setUpgrade(this.new("scripts/items/" + (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() ? "legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade" : "armor_upgrades/heavy_gladiator_upgrade")));
		}

		items.equip(a);
		items.equip(this.Const.World.Common.pickHelmet([
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

