this.drill_sergeant_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.drill_sergeant";
		this.m.Name = "Drill Sergeant";
		this.m.Description = "The Drill Sergeant was a mercenary once, but an injury ended his career prematurely. Now he drills discipline into your men and yells a lot to make sure that everyone learns from their mistakes.";
		this.m.Image = "ui/campfire/drill_01";
		this.m.Cost = 150;
		this.m.Effects = [
			"Every new day, brothers without the trained perk tree will have a 5% chance to gain it",
			"Unlocks the training drill event where non-combat backgrounds below level 11 can improve their stats 2 times"
		];
		// this.addRequirement("Won 10 battles", function ()
		// {
		// 	return ::World.Statistics.getFlags().getAsInt("BattlesWon") >= 50;
		// }, true, function ( _r )
		// {
		// 	_r.Count <- 50;
		// 	_r.UpdateText <- function ()
		// 	{
		// 		this.Text = "Won at least " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("BattlesWon")) + "/" + this.Count + " battles";
		// 	};
		// });
	}

	function onNewDay()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local numRecruits = 0;
		foreach( bro in brothers )
		{
			if (bro.getBackground().hasPerkGroup(::Const.Perks.TrainedTree)) continue;
			if (::Math.rand(1,100) > 5) continue;
			bro.getBackground().addPerkGroup(::Const.Perks.TrainedTree.Tree);
		}
	}

});

