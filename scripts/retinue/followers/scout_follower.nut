this.scout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scout";
		this.m.Name = "The Scout";
		this.m.Description = "The Scout is an expert in finding mountain passes, navigating through treacherous swamps, and guiding anyone safely through the darkest of forests.";
		this.m.Image = "ui/campfire/scout_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"Makes the company travel 15% faster on any terrain",
			"Prevents sickness and accidents due to terrain"
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
		for( local i = 0; i < this.World.Assets.m.TerrainTypeSpeedMult.len(); i = ++i )
		{
			this.World.Assets.m.TerrainTypeSpeedMult[i] *= 1.15;
		}
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Won " + this.Math.min(5, this.World.Statistics.getFlags().getAsInt("BeastsDefeated")) + "/5 battles against beasts";

		if (this.World.Statistics.getFlags().getAsInt("BeastsDefeated") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

