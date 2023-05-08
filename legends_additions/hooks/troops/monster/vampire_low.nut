::mods_hookExactClass("entity/tactical/enemies/vampire_low", function(o) {
	o.onInit = function()
	{
		this.vampire.onInit();
		this.setHitpoints(this.getHitpointsMax() * this.Math.rand(25, 65) * 0.01);
		this.getSkills().update();
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/ancient/khopesh"));
	}

});

