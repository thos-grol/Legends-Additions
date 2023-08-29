this.arena_tournament_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.arena_tournament";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_97.png[/img]A couple of children dash across your path, one holding up a toy shield, the other staking into it with a very real pitchfork. You grab the farm equipment and yank it away to which the child cries out that they\'re only having fun. The older of the two explains that they\'re merely excited for the coming gladiator tournament. They say that %town% is hosting a series of arena matches and the reward is something big. Very interesting. Using the pitchfork, you scoot the children off the road and then hurl the tool to the other side. | [img]gfx/ui/events/event_97.png[/img]You find two boys trying to wrangle a dog into a net. The dog playfully jukes left to right, but eventually they ensnare it. The mutt, almost immediately resigned to its fate, lays down. You think they\'ll butcher and eat the animal, but the boys merely let it go to start the game again. When asked, they explain that some gladiators in %town% use nets in combat. But more interestingly, they also state a large series of gladiator games are going on and that apparently there\'s a big prize for the winner of it. | [img]gfx/ui/events/event_92.png[/img]A messenger wearing buskin boots comes down the road and throws you a scroll and breathlessly sprints by all in the span of seconds. You unfurl the paper to find an announcement: %town% is hosting a tournament of gladiator games. The winner of a series of combats will earn a prize, alongside adoration and fame, of course. | [img]gfx/ui/events/event_34.png[/img]You find a man squatting beside the road. He\'s half-naked and, judging by the here-and-there state of his clothes, he did not undress himself. He explains that he was traveling to %town% to partake in the gladiator games, but a group of rogues robbed him. Not interested in his woes, you inquire about these games. He explains that it\'s a series of fights like a tournament and the winner gets a big prize. The man shakes his head.%SPEECH_ON%Suppose the only prize I got was getting my arse kicked. Hey, you look like you could use some help, what say I...%SPEECH_OFF%You walk off, mulling over whether or not to seek out %town% and its festive arena.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Interesting.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.SquareCoords.Y >= this.World.getMapSize().Y * 0.6)
		{
			return;
		}

		local town;
		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.isSouthern() && t.hasSituation("situation.arena_tournament"))
			{
				town = t;
				break;
			}
		}

		if (town == null)
		{
			return;
		}

		this.m.Town = town;
		this.m.Score = 50;
	}

	function onPrepare()
	{
		this.m.Town.getSituationByID("situation.arena_tournament").setValidForDays(5);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"town",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

