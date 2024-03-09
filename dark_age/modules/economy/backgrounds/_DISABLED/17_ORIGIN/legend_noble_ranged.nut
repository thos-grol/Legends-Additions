::mods_hookExactClass("skills/backgrounds/legend_noble_ranged", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		if ("Weapon" in this.m.PerkTreeDynamic)
		{
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.ThrowingTree );
			::MSU.Array.removeByValue( this.m.PerkTreeDynamic.Weapon, ::Const.Perks.StaffTree );
		}
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			]
		]));
		items.equip(::new("scripts/items/weapons/light_crossbow"));
		items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(::new("scripts/items/weapons/knife"));
		items.equip(::Const.World.Common.pickArmor([
			[
				2,
				"padded_surcoat"
			],
			[
				1,
				"basic_mail_shirt"
			]
		]));
	}

});

