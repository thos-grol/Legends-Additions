this.alchemist_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.alchemist";
		this.m.Name = "Alchemist";
		this.m.Description = "An Alchemist is knowledgeable in crafting all kinds of mysterious contraptions and concoctions from exotic ingredients.";
		this.m.Image = "ui/campfire/alchemist_01";
		this.m.Cost = 1000;
		this.m.Effects = [
			"Refills equipped alchemy items after paying wages.",
			"Unlocks potion crafting recipes. Check the crafting tent for details (WIP)",
		];
	}

	function isValid()
	{
		return true;
	}

});

