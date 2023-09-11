::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.AxeTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ShieldTree,
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.TrainedTree
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
		r = this.Math.rand(2, 3);

		if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"barbarians/thick_furs_armor"
			],
			[
				1,
				"barbarians/reinforced_animal_hide_armor"
			],
			[
				1,
				"barbarians/hide_and_bone_armor"
			],
			[
				1,
				"barbarians/scrap_metal_armor"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/bear_headpiece"
			],
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/leather_helmet"
			]
		]));
	}

});
