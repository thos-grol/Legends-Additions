::mods_hookExactClass("skills/backgrounds/female_miller_background", function(o) {
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
			Defense = [],
			Traits = [],
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
		r = this.Math.rand(0, 4);

		items.equip(this.new("scripts/items/weapons/wooden_stick"));

		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"legend_maid_apron"
			],
			[
				1,
				"legend_maid_dress"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
	}

});

