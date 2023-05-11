this.scavenger_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scavenger";
		this.m.Name = "The Scavenger";
		this.m.Description = "Whether the son of one of your men or an urchin you took pity on, the Scavenger pulls his weight by collecting bits and pieces from every battlefield.";
		this.m.Image = "ui/campfire/scavenger_01";
		this.m.Cost = 3000;
		this.m.Effects = [
			"Recovers a part of all ammo you use during battle",
			"Recovers tools and supplies from every armor destroyed by you during battle"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have a heart"
			}
		];
	}

	function onUpdate()
	{
		this.World.Assets.m.IsRecoveringAmmo = true;
		this.World.Assets.m.IsRecoveringArmor = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].IsSatisfied = true;
	}

});

