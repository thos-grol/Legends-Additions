this.paymaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.paymaster";
		this.m.Name = "Pay Master";
		this.m.Description = "Few have the patience to count and fewer still the willpower to weigh and count coins as part of their contract. But the Paymaster is a figure of respect to all those around them.";
		this.m.Image = "ui/campfire/paymaster_01";
		this.m.Cost = 100;
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
			this.World.Assets.m.DailyWageMult *= 0.20;
		}
	}

});

