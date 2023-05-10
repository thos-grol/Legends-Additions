::mods_hookExactClass("skills/backgrounds/miller_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.5, ::Const.Perks.LargeTree],
			[1.5, ::Const.Perks.ResilientTree],
			[1.5, ::Const.Perks.SturdyTree],
			[0.5, ::Const.Perks.TrainedTree],
			[1.5, ::Const.Perks.OrganisedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.LaborerProfessionTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
	}

});

