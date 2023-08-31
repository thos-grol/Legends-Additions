::mods_hookExactClass("skills/backgrounds/legend_conscript_background", function(o) {

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ShieldTree,
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.MilitiaClassTree
			],
			Magic = []
		};
	}
	
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/oriental/polemace"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/oriental/swordlance"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/nomad_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
			items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"oriental/linothorax"
			],
			[
				1,
				"oriental/southern_mail_shirt"
			]
		]));
		local helm = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/southern_head_wrap"
			],
			[
				1,
				"oriental/wrapped_southern_helmet"
			],
			[
				1,
				"oriental/spiked_skull_cap_with_mail"
			]
		]);
		items.equip(helm);
	}

});

