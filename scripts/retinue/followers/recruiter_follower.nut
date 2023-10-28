this.recruiter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.recruiter";
		this.m.Name = "Pre-filled Contracts";
		this.m.Description = "The recruiter will help the company scour for talents.";
		this.m.Image = "ui/campfire/recruiter_01";
		this.m.Cost = 200;
		this.m.Effects = [
			"Makes between 2 and 4 additional men available to recruit in every settlement"
		];
	}

	function onUpdate()
	{
		if ("RosterSizeAdditionalMin" in this.World.Assets.m)
		{
			this.World.Assets.m.RosterSizeAdditionalMin += 3;
		}

		if ("RosterSizeAdditionalMax" in this.World.Assets.m)
		{
			this.World.Assets.m.RosterSizeAdditionalMax += 5;
		}

		// if ("HiringCostMult" in this.World.Assets.m)
		// {
		// 	this.World.Assets.m.HiringCostMult *= 0.9;
		// }

		// if ("TryoutPriceMult" in this.World.Assets.m)
		// {
		// 	this.World.Assets.m.TryoutPriceMult *= 0.5;
		// }
	}

});

