this.paymaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.paymaster";
		this.m.Name = "Pennypincher\'s Tools";
		this.m.Description = "Few have the patience to count and fewer still the willpower to weigh and count coins as part of their contract. But the Paymaster is a figure of respect to all those around them.";
		this.m.Image = "ui/campfire/legend_paymaster_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Reduces the daily wage of each man by 15%",
			"Reduces the chance of desertion by 50%",
			"Prevents men demanding more pay in events"
		];
		this.addSkillRequirement("Have a mercenary who has taken the Paymaster perk. Guaranteed on Peddlers, Eunuchs and Servants", [
			"perk.legend_barter_paymaster",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	function onUpdate()
	{
		if ("DailyWageMult" in this.World.Assets.m)
		{
			this.World.Assets.m.DailyWageMult *= 0.85;
		}
	}

});

