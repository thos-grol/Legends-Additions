this.minstrel_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.minstrel";
		this.m.Name = "The Minstrel";
		this.m.Description = "A good song and story play a large part in creating the reputation of a company. The Minstrel is a master of these crafts and will help to spread the word about your deeds to all ears - willing to hear them or not.";
		this.m.Image = "ui/campfire/minstrel_01";
		this.m.Cost = 2000;
		this.m.Effects = [
			"Makes you earn 15% more renown with every action",
			"Makes tavern rumors more likely to contain useful information"
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
		this.World.Assets.m.BusinessReputationRate *= 1.15;
		this.World.Assets.m.IsNonFlavorRumorsOnly = true;
	}

	function onEvaluate()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local settlementsVisited = 0;
		local maxSettlements = settlements.len();

		foreach( s in settlements )
		{
			if (s.isVisited())
			{
				settlementsVisited = ++settlementsVisited;
			}
		}

		this.m.Requirements[0].Text = "Visited " + settlementsVisited + "/" + maxSettlements + " settlements";

		if (settlementsVisited >= maxSettlements)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

