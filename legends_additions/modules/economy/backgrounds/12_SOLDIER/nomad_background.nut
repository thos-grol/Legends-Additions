::mods_hookExactClass("skills/backgrounds/nomad_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [],
			Magic = []
		};

		this.m.PerkTreeDynamicMins.Traits = 4;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(2, 4);

		if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/nomad_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}

		items.equip(this.Const.World.Common.pickArmor([
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
		local helm = this.Const.World.Common.pickHelmet([
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

});

