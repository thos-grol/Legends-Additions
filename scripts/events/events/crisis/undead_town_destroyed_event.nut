this.undead_town_destroyed_event <- this.inherit("scripts/events/event", {
	m = {
		News = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_town_destroyed";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_99.png[/img]{You come across a donkey standing beside a cart full of burnt corpses. A man stands beside it looking, understandably, worse for the wear. He looks at you and shakes his head.%SPEECH_ON%Hope yer not heading to %city%.%SPEECH_OFF%Not one to tell strangers where you\'re heading, you simply ask him why. He shakes his head a second time.%SPEECH_ON%Walking dead got it. Disease spread through the town and those who were dying kept rising up again. Wasn\'t long until the whole place fell to those undying souls. Word has it that the city is now governed by necromancers, but who really knows. I sure as hell ain\'t gonna get close to find out.%SPEECH_OFF% | There\'s a pale greybeard squatting in the middle of the path. He hears you coming, but doesn\'t turn to look. Instead he simply speaks.%SPEECH_ON%Saw you in the vision. All of you. Sellswords on the path to righting the ills of this world, though ye might not know this purpose any better than a royal infant understands its kingly place. But you\'re too late.%SPEECH_OFF%His head snaps around. White eyes stare out from beneath bushy eyebrows. He\'s missing a nose and his lips sneer with sickly yellow creases.%SPEECH_ON%%city% is lost! The dead wander the streets, leashed by the ones you call necromancers.%SPEECH_OFF%Carefully, you tread forward and ask how he knows any of this. The pale man holds up a round bauble that ripples as though a god were holding the shape of a pond in his palm. Images twist in its reflections, coming and going, events with no start or end. He laughs.%SPEECH_ON%Who better to know the fate of the city than the man who orchestrated its demise?%SPEECH_OFF%Suddenly, the stranger\'s flesh shatters, revealing nothing but air beneath, and the blackened shards of his new form spread out into a cloud of bats. You draw out your sword, but the creatures wheel away, shrieking and chirping as they soar toward the horizon. | Two men are found off the side of the path. One is standing before an easel, in one hand a brush, in the other a palette of mixed colors. The other man is posing, hands to his head, holding an expression of absolute horror. The painter glances at you.%SPEECH_ON%Ah, sellswords. I suppose you\'re heading toward city, yeah?%SPEECH_OFF%You ask why he would say that. He nervously puts the brush down. You see his painting is of a darkened city with blue miasma rising out from behind its walls, a pale moon hovering oppressively overhead. A half-painted figure stands in the foreground, mirroring the look of the painter\'s model. Without moving an inch, the poser answers your question.%SPEECH_ON%%city%\'s been destroyed. Well, not destroyed, but overrun with those walking corpses. Word has it that pale men hold governance over it.%SPEECH_OFF%You ask if they know this for sure. The painter waves an arm to present his work.%SPEECH_ON%Had I not seen it with my own eyes, would this not be the work of a madman? Now, please, I must get back to work before the macabre memory fades.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Are we losing this war?",
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
		if (!this.World.State.getPlayer().getTile().HasRoad)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_undead_town_destroyed"))
		{
			this.m.Score = 2000;
		}
	}

	function onPrepare()
	{
		this.m.News = this.World.Statistics.popNews("crisis_undead_town_destroyed");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"city",
			this.m.News.get("City")
		]);
	}

	function onClear()
	{
		this.m.News = null;
	}

});

