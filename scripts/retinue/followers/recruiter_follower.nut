this.recruiter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.recruiter";
		this.m.Name = "Pre-filled Contracts";
		this.m.Description = "The recruiter will help the company scour for talents.";
		this.m.Image = "ui/campfire/recruiter_01";
		this.m.Cost = 150;
		this.m.Effects = [
			"Every settlement has 4-6 additional recruits"
		];
	}

	function onUpdate()
	{
		if ("RosterSizeAdditionalMin" in this.World.Assets.m) 
			this.World.Assets.m.RosterSizeAdditionalMin += 4;

		if ("RosterSizeAdditionalMax" in this.World.Assets.m)
			this.World.Assets.m.RosterSizeAdditionalMax += 6;
	}

});

