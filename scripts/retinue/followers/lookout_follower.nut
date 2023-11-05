this.lookout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.lookout";
		this.m.Name = "Outrider\'s Post";
		this.m.Description = "Having a quick Lookout with sharp eyes travel in advance of the company can prove invaluable in being aware of dangers and points of interests before others become aware of the company.";
		this.m.Image = "ui/campfire/legend_lookout_01";
		this.m.Cost = 100;
		this.m.Effects = [
			"Increases your sight radius by 50%",
			"Reveals extended information about footprints",
			"Reduces the movement penalty of difficult terrain by 15%",
			"Prevents sickness and accidents due to terrain",
		];
	}

	function isVisible()
	{
		return false;
	}

});

