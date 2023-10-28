this.agent_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.agent";
		this.m.Name = "Messenger\'s Rest";
		this.m.Description = "Through setting up a network of messengers, skilled agents can be employed to deliver information that you may find of use...after a short rest, of course.";
		this.m.Image = "ui/campfire/agent_01";
		this.m.Cost = 200;
		this.m.Effects = [
			"Reveals available contracts and active situations in the tooltip of settlements no matter where you are",
			"Increases subterfuge"
		];
	}

});

