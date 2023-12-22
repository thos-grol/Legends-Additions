::mods_hookExactClass("skills/backgrounds/nomad_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree,
				::Const.Perks.SpearTree,
				::Const.Perks.ShieldTree,
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
		r = ::Math.rand(2, 4);

		if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/oriental/nomad_mace"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 4)
		{
			items.equip(::new("scripts/items/weapons/militia_spear"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/nomad_robe"
			],
			[
				1,
				"oriental/thick_nomad_robe"
			],
			[
				1,
				"oriental/stitched_nomad_armor"
			],
			[
				1,
				"oriental/leather_nomad_robe"
			]
		]));
		local helm = ::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/nomad_head_wrap"
			],
			[
				1,
				"oriental/nomad_leather_cap"
			],
			[
				1,
				"oriental/nomad_light_helmet"
			]
		]);
		items.equip(helm);
	}

	o.onAdded = function()
	{
		this.character_background.onAdded();
	}

});

::mods_hookExactClass("skills/backgrounds/nomad_ranged_background", function(o) {
	o.onAdded = function()
	{
		this.character_background.onAdded();
	}
});

