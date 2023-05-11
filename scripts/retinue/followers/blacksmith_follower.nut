this.blacksmith_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.blacksmith";
		this.m.Name = "The Blacksmith";
		this.m.Description = "Mercenaries are good at getting arms and armor destroyed, but not at maintaining them. The Blacksmith will take care of this tedious task quickly and efficiently, and can mend even equipment otherwise thought lost.";
		this.m.Image = "ui/campfire/blacksmith_01";
		this.m.Cost = 3000;
		this.m.Effects = [
			"Repairs all armor, helmets, weapons and shields worn by your men even if they\'re broken or lost because your man died",
			"Increases repair speed by 33%"
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
		this.World.Assets.m.RepairSpeedMult *= 1.33;
		this.World.Assets.m.IsBlacksmithed = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Had " + this.Math.min(5, this.World.Statistics.getFlags().getAsInt("ItemsRepaired")) + "/5 items repaired at a town\'s smith";

		if (this.World.Statistics.getFlags().getAsInt("ItemsRepaired") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

