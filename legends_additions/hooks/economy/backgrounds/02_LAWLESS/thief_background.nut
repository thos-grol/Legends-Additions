::mods_hookExactClass("skills/backgrounds/thief_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.LargeTree],
			[0.5, ::Const.Perks.SturdyTree],
			[0.75, ::Const.Perks.ResilientTree],
			[1.5, ::Const.Perks.FastTree],
			[1.5, ::Const.Perks.AgileTree],
			[1.25, ::Const.Perks.TalentedTree],
			[0.66, ::Const.Perks.ShieldTree],
			[2, ::Const.Perks.OneHandedTree],
			[3, ::Const.Perks.DaggerTree]
		];

		this.m.PerkTreeDynamic = {
			Traits = [
				::Const.Perks.DeviousTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				1,
				"headscarf"
			]
		]));
	}

});

