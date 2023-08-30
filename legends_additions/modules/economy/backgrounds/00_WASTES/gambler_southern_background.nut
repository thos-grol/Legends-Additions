::mods_hookExactClass("skills/backgrounds/gambler_southern_background", function(o) {
	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				2,
				""
			]
		]));
	}

});

