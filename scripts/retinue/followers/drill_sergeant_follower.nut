this.drill_sergeant_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.drill_sergeant";
		this.m.Name = "The Drill Sergeant";
		this.m.Description = "The Drill Sergeant was a mercenary once, but an injury ended his career prematurely. Now he drills discipline into your men and yells a lot to make sure that everyone learns from their mistakes.";
		this.m.Image = "ui/campfire/drill_01";
		this.m.Cost = 100;
		this.m.Effects = [
			"Trains brothers so that they can pick up one new weapon tree. They must have the weapon equipped. At the end of the day, a brother will have a chance to gain experience in that tree",
			"Contraband weapons like crossbows and firearms do not count",
			"Will take effect at the start of the next day"
		];
		this.addRequirement("Won 10 battles", function ()
		{
			return ::World.Statistics.getFlags().getAsInt("BattlesWon") >= 10;
		}, true, function ( _r )
		{
			_r.Count <- 10;
			_r.UpdateText <- function ()
			{
				this.Text = "Won at least " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("BattlesWon")) + "/" + this.Count + " battles";
			};
		});
	}

	function onNewDay()
	{
		//FEATURE_0: write weapon gain system
		//FEATURE_0: add weapon training trait, using flags to store data
			//FEATURE_0: if retinue not active, then hide that trait.
	}

});

