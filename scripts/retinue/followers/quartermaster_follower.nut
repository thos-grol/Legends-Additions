this.quartermaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.quartermaster";
		this.m.Name = "The Quartermaster";
		this.m.Description = "With years of experience from traveling with caravans, the Quartermaster is able to squeeze and rotate any piece of gear, luggage or armor into the perfect spot to use space as efficiently as possible.";
		this.m.Image = "ui/campfire/quartermaster_01";
		this.m.Cost = 3000;
		this.m.Effects = [
			"Increases the amount of ammunition you can carry by 100",
			"Increases the amount of medical supplies and tools you can carry by 50 each"
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
		this.World.Assets.m.AmmoMaxAdditional = 100;
		this.World.Assets.m.MedicineMaxAdditional = 50;
		this.World.Assets.m.ArmorPartsMaxAdditional = 50;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Completed " + this.Math.min(5, this.World.Statistics.getFlags().getAsInt("EscortCaravanContractsDone")) + "/5 caravan escort contracts";

		if (this.World.Statistics.getFlags().getAsInt("EscortCaravanContractsDone") >= 5)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

