::mods_hookExactClass("skills/backgrounds/legend_noble_shield", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.CrossbowTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.StaffTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.SwordTree );
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_surcoat"
			],
			[
				2,
				"basic_mail_shirt"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				10,
				"aketon_cap"
			],
			[
				10,
				"open_leather_cap"
			],
			[
				10,
				"kettle_hat"
			],
			[
				10,
				"padded_kettle_hat"
			],
			[
				10,
				"kettle_hat_with_mail"
			],
			[
				10,
				"mail_coif"
			],
			[
				1,
				"legend_enclave_vanilla_armet_02"
			],
			[
				1,
				"legend_enclave_vanilla_skullcap_01"
			]
		]));
	}

});

