::mods_hookExactClass("skills/backgrounds/crusader_background.nut", function(o) {
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
		items.equip(this.new("scripts/items/weapons/greatsword"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"mail_hauberk"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"full_helm"
			]
		]));
	}

});

