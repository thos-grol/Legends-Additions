::mods_hookExactClass("skills/backgrounds/witchhunter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[3, ::Const.Perks.CalmTree],
			[2, ::Const.Perks.AgileTree],
			[3, ::Const.Perks.ViciousTree],
			[0, ::Const.Perks.DeviousTree],
			[2, ::Const.Perks.TalentedTree],
			[0, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.BowTree]
		];

		this.m.PerkTreeDynamic = {
			Class = [
				::Const.Perks.SergeantClassTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Weapon = [
				::Const.Perks.CrossbowTree
			]
			Styles = [
				::Const.Perks.RangedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		//TODO: background multipliers
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[0];
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/legend_wooden_stake"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"witchhunter_hat"
			]
		]));
	}

});
