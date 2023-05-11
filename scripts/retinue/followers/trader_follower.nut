this.trader_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.trader";
		this.m.Name = "The Trader";
		this.m.Description = "Southern traders are renowned for their bartering skills. Lucky you that you could convince one such master of haggling to join your company. And at such a bargain!";
		this.m.Image = "ui/campfire/trader_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Increases the amount of trade goods for sale by 1 for each location that produces them, like salt near salt mines, allowing you to trade at higher volumes"
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
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Sold " + this.Math.min(25, this.World.Statistics.getFlags().getAsInt("TradeGoodsSold")) + "/25 trade goods";

		if (this.World.Statistics.getFlags().getAsInt("TradeGoodsSold") >= 25)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

