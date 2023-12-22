::mods_hookExactClass("skills/backgrounds/daytaler_background", function(o) {
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = ::Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"linen_tunic",
				::Math.rand(6, 7)
			]
		]));
		local helm = ::Const.World.Common.pickHelmet([
			[
				3,
				""
			],
			[
				1,
				"oriental/southern_head_wrap"
			]
		]);
		items.equip(helm);
	}

});

