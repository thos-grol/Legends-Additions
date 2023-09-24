::mods_hookExactClass("skills/backgrounds/vagabond_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.MaceTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_saw"));
		}
		

		r = this.Math.rand(0, 3);
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"leather_tunic"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"hood"
			],
			[
				1,
				"straw_hat"
			]
		]));
	}

});

