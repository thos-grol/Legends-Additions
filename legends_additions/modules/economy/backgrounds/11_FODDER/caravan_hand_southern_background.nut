::mods_hookExactClass("skills/backgrounds/caravan_hand_southern_background", function(o) {
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/oriental/light_southern_mace"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/cloth_sash"
			],
			[
				1,
				"oriental/padded_vest"
			],
			[
				1,
				"oriental/nomad_robe"
			],
			[
				1,
				"oriental/thick_nomad_robe"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/southern_head_wrap"
			],
			[
				1,
				"oriental/nomad_head_wrap"
			],
			[
				1,
				"oriental/nomad_leather_cap"
			]
		]));
	}

});

