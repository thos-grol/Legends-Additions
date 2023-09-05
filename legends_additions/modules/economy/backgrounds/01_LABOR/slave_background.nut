::mods_hookExactClass("skills/backgrounds/slave_background", function(o) {
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
		items.equip(this.Const.World.Common.pickArmor([
			[
				3,
				"tattered_sackcloth"
			],
			[
				2,
				"leather_wraps"
			],
			[
				2,
				""
			]
		]));
	}

});
