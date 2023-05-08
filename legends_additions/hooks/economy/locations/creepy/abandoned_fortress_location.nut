::mods_hookExactClass("entity/world/locations/abandoned_fortress_location", function(o) {
	o.getDescription = function()
	{
		return "The remains of an old fortress. It looks entirely abandoned.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.Name = "Abandoned Fortress";
		this.m.TypeID = "location.abandoned_fortress";
		this.m.LocationType = this.Const.World.LocationType.Passive;
		this.m.IsDespawningDefenders = false;
		this.m.IsBattlesite = false;
		this.m.IsAttackable = false;
		this.m.Resources = 0;
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_fortress_ruins");
		body.setHorizontalFlipping(this.Math.rand(0, 1) == 1);
	}

});

