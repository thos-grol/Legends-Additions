::mods_hookExactClass("skills/backgrounds/legend_inventor_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.InventorMagicTree
			],
			Traits = [
				::Const.Perks.OrganisedTree,
				::Const.Perks.TalentedTree
			],
			Class = [
				::Const.Perks.MenderClassTree
			]
			Magic = [
				::Const.Perks.InventorMagicTree,
				::Const.Perks.PhilosophyMagicTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"apron"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"mouth_piece"
			],
			[
				1,
				"headscarf"
			]
		]));
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
	}

});
