::mods_hookExactClass("skills/backgrounds/female_minstrel_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.MinstrelProfessionTree
			],
			Class = [
				::Const.Perks.EntertainerClassTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local armor = this.Const.World.Common.pickArmor([
			[
				1,
				"linen_tunic",
				this.Math.rand(3, 4)
			]
		]);
		items.equip(armor);
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"feathered_hat"
			],
			[
				1,
				""
			]
		]);
		items.equip(item);
		local r = this.Math.rand(0, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/lute"));
		}

		if (r >= 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_drum"));
		}
	}

});

