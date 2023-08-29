this.barbarian_tells_story_event <- this.inherit("scripts/events/event", {
	m = {
		Barbarian = null
	},
	function create()
	{
		this.m.ID = "event.barbarian_tells_story";
		this.m.Title = "During camp...";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%barbarian% shares tales around the campfire of northern heroics and monsters. There can\'t be much said of the dialogue, given that brute isn\'t the most eloquent, but the story is well conveyed through miming and drawing in the ground. {One tale seems to be that of a huge warrior defeating a much larger warrior, or perhaps even defeating an ogre. It\'s hard to tell, but the barbarian makes a fascinating display of combat which the company applauds. | One tale is of two lovers, and with great use of waving hands, makes a riveting show of what it is to plough and be ploughed. And, apparently, what it is to be betrayed and stabbed in the back. You\'re not sure who is stabbing whom, nor when or in what sense, but the tale has the mercenaries on the edges of their seats and ends with applause. | One tale speaks to a friendly unhold. The company gasp at the very notion of it, but the barbarian slaps at wrists and wags a finger. This, you assume, is a way of telling you it\'s all true, every word or grunt. The idea of a friendly monster unsettles the mercenaries initially, but by the end of the story they clap and nod as though they wish it really were the truth.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Captivating.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Barbarian.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "Felt entertained");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.barbarian")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Barbarian = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"barbarian",
			this.m.Barbarian.getName()
		]);
	}

	function onClear()
	{
		this.m.Barbarian = null;
	}

});

