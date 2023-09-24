::mods_hookExactClass("skills/backgrounds/minstrel_background", function(o) {
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
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic",
				this.Math.rand(3, 4)
			]
		]));
		local r;
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			]
		]));
		local r = this.Math.rand(0, 4);

		if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/lute"));
		}

		if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/legend_drum"));
		}
	}

});

