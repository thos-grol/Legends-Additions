::mods_hookExactClass("skills/backgrounds/legend_noble_event_background", function(o) {
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
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Bravery] = 3;
		talents[::Const.Attributes.MeleeSkill] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"noble_tunic"
			]
		]));
		items.equip(this.new("scripts/items/weapons/pike"));
		local stash = this.World.Assets.getStash();
		stash.add(this.new("scripts/items/supplies/wine_item"));
	}

});

