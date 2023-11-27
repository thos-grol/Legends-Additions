this.paymaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.paymaster";
		this.m.Name = "Pay Master";
		this.m.Description = "The Paymaster takes care of all the day-to-day financial and organizational aspects of running a mercenary company, like paying out wages.";
		this.m.Image = "ui/campfire/paymaster_01";
		this.m.Cost = 150;
		this.m.Effects = [
			"Reduces the daily wage of each man by 20%",
			"Reduces the chance of desertion by 50%",
			"Prevents men demanding more pay in events"
		];
	}

	function onUpdate()
	{
		if ("DailyWageMult" in this.World.Assets.m)
		{
			this.World.Assets.m.DailyWageMult *= 0.80;
		}
	}

});

