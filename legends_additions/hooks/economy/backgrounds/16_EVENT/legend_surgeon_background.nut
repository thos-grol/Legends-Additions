::mods_hookExactClass("skills/backgrounds/legend_surgeon_background", function(o) {

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_saw"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/vizier_gear"
			],
			[
				2,
				"oriental/cloth_sash"
			],
			[
				3,
				"butcher_apron"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				2,
				""
			],
			[
				1,
				"oriental/vizier_headgear"
			],
			[
				1,
				"oriental/engineer_hat"
			]
		]));
	}

});
