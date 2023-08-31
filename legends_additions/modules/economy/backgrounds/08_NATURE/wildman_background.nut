::mods_hookExactClass("skills/backgrounds/wildman_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.SturdyTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(1, 3);
		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/orc_metal_club"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/greenskins/orc_wooden_club"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"legend_rabble_fur"
			]
		]));
	}

});
