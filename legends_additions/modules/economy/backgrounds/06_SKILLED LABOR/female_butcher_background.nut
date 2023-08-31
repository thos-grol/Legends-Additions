::mods_hookExactClass("skills/backgrounds/female_butcher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CleaverTree
			],
			Defense = [],
			Traits = [
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ButcherClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"butcher_apron"
			],
			[
				1,
				"legend_maid_apron"
			]
		]));
	}

});

