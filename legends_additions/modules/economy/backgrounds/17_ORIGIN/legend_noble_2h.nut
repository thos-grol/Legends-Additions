::mods_hookExactClass("skills/backgrounds/legend_noble_2h", function(o) {
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
		items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_surcoat"
			],
			[
				2,
				"basic_mail_shirt"
			],
			[
				1,
				"gambeson"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"legend_enclave_vanilla_armet_01"
			],
			[
				10,
				"legend_enclave_vanilla_skullcap_01"
			],
			[
				50,
				"greatsword_hat"
			]
		]));
	}

});

