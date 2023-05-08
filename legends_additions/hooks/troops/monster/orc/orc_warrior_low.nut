::mods_hookExactClass("entity/tactical/enemies/orc_warrior_low", function(o) {
	o.onInit = function()
	{
		this.orc_warrior.onInit();
		this.m.BaseProperties.DamageTotalMult -= 0.1;
		this.m.Skills.update();
	}

	o.onFinish = function()
	{
		this.actor.onFinish();
	}

	o.assignRandomEquipment = function()
	{
		local r;
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_axe"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/greenskins/orc_cleaver"));
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.new("scripts/items/shields/greenskins/orc_heavy_shield"));
		}

		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"greenskins/orc_warrior_light_armor"
			],
			[
				1,
				"greenskins/orc_warrior_medium_armor"
			]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"greenskins/orc_warrior_light_helmet"
			],
			[
				1,
				"greenskins/orc_warrior_medium_helmet"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

