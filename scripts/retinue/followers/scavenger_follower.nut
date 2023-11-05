this.scavenger_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scavenger";
		this.m.Name = "The Scavenger";
		this.m.Description = "An urchin you took pity on, the Scavenger pulls his weight by collecting bits and pieces from every battlefield.";
		this.m.Image = "ui/campfire/scavenger_01";
		this.m.Cost = 5;
		this.m.Effects = [
			"Recovers a part of all ammo you use during battle",
			"Recovers tools and supplies from every armor destroyed by you during battle"
		];
	}

	function onUpdate()
	{
		if ("IsRecoveringAmmo" in this.World.Assets.m) this.World.Assets.m.IsRecoveringAmmo = true;
		if ("IsRecoveringArmor" in this.World.Assets.m) this.World.Assets.m.IsRecoveringArmor = true;
	}

});

