this.brigand_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.brigand";
		this.m.Name = "The Brigand";
		this.m.Description = "The Brigand may be old and weak now, but at one point his name was feared across the land. In exchange for a hot meal he happily shares with you what he learns from his contacts about caravans on the road.";
		this.m.Image = "ui/campfire/brigand_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"Makes you see the position of some caravans at all times and even if outside your sight radius"
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
		this.World.Assets.m.IsBrigand = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Raided " + this.Math.min(4, this.World.Statistics.getFlags().getAsInt("CaravansRaided")) + "/4 caravans";

		if (this.World.Statistics.getFlags().getAsInt("CaravansRaided") >= 4)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

