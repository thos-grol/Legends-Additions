this.alchemist_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.alchemist";
		this.m.Name = "Alchemist";
		this.m.Description = "An Alchemist is knowledgeable in crafting all kinds of mysterious contraptions and concoctions from exotic ingredients.";
		this.m.Image = "ui/campfire/alchemist_01";
		this.m.Cost = 1250;
		this.m.Effects = [
			"About every 2 weeks, he will craft you potion items... for a price (event)",
			"Refills alchemy items at the end of the day and potion items at the end of the week (every 7 days)."
		];
	}

	function isValid()
	{
		return ::Const.DLC.Unhold;
	}

	function onNewDay()
	{
		//FEATURE_1: for items in stash and bro inventories:
			//refill items
	}

});

