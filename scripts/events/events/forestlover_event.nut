this.forestlover_event <- this.inherit("scripts/events/event", {
	m = {
		Forestlover = null
	},
	function create()
	{
		this.m.ID = "event.forestlover";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img] {%forestlover% looks up at the forest canopy, a hand playfully strumming through the lightfalls. Looking up at you.%SPEECH_ON%I used to play through these forests as a kid.%SPEECH_OFF%You nod, then wonder aloud.%SPEECH_ON%I thought you were born outside %randomtown%?%SPEECH_OFF%%forestlover%\'s hand falls and he stares at the ground.%SPEECH_ON%Oh yeah, that\'s right. Well, we should get moving then, right?%SPEECH_OFF%Before you can say anything more, the red-faced mercenary marches on. | You find that %forestlover% appears to be in better spirits lately. As it turns out, these forests are familiar to the forester and a return to their greenery has the mercenary beaming with warm nostalgia. | Even though you\'ve marched through plenty of forests, this one\'s viridscapes has you impressed. No doubt %forestlover% is loving a return to the trees\' thick domain. | Trees, fat trunks and strong-limbed, rise above you. %forestlover% seems to be mesmerized by their towering. You find the mercenary smiling all the time lately, as though a return to the forest is a return to better times.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good for you.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Forestlover.getImagePath());
				_event.m.Forestlover.improveMood(1.0, "Enjoyed being in a forest");

				if (_event.m.Forestlover.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Forestlover.getMoodState()],
						text = _event.m.Forestlover.getName() + this.Const.MoodStateEvent[_event.m.Forestlover.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.legend_ranger" || bro.getBackground().getID() == "background.legend_herbalist" || bro.getBackground().getID() == "background.lumberjack")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Forestlover = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 10;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"forestlover",
			this.m.Forestlover.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Forestlover = null;
	}

});

