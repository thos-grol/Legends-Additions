::mods_hookExactClass("skills/backgrounds/orc_slayer_background.nut", function(o) {
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
		items.equip(this.new("scripts/items/weapons/two_handed_hammer"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"mail_hauberk"
			]
		]));
	}

});

