this.drill_sergeant_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.drill_sergeant";
		this.m.Name = "The Drill Sergeant";
		this.m.Description = "The Drill Sergeant was a mercenary once, but an injury ended his career prematurely. Now he drills discipline into your men and yells a lot to make sure that everyone learns from their mistakes.";
		this.m.Image = "ui/campfire/drill_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Makes your men gain 20% more experience at level 1, with 2% less at each further level",
			"Makes men in reserve never lose mood from not taking part in battles"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Retired a man with a permanent injury that isn\'t indebted"
			}
		];
	}

	function onUpdate()
	{
		this.World.Assets.m.IsDisciplined = true;
	}

	function onEvaluate()
	{
		if (this.World.Statistics.getFlags().getAsInt("BrosWithPermanentInjuryDismissed") > 0)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

