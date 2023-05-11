this.surgeon_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.surgeon";
		this.m.Name = "The Surgeon";
		this.m.Description = "The Surgeon is a walking tome of anatomical knowledge. A mercenary company seems the perfect place both to apply that knowledge in healing, but also to learn more about how the insides of men are made up.";
		this.m.Image = "ui/campfire/surgeon_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Makes every man without a permanent injury guaranteed to survive an otherwise fatal blow",
			"Makes every injury take one less day to heal"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function onUpdate()
	{
		this.World.Assets.m.IsSurvivalGuaranteed = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Treated " + this.Math.min(5, this.World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple")) + "/5 men with injuries at a temple";

		if (this.World.Statistics.getFlags().getAsInt("InjuriesTreatedAtTemple") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

