::mods_hookExactClass("skills/backgrounds/legend_conscript_background.nut", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
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
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/oriental/firelance"));
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

