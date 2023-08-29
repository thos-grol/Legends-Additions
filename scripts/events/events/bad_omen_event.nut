this.bad_omen_event <- this.inherit("scripts/events/event", {
	m = {
		Superstitious = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.bad_omen";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_12.png[/img]Cries whip through the party like the howls of the wind. There is not an enemy in sight so you\'ve no idea what is causing this. You walk the ranks to find %superstitious% practically sobbing on the ground. He is clutching his chest with one hand while the other points to the sky, the finger shaking in pointed fear. %otherguy% explains that the man saw a great blaze of fire cross by the stars. Apparently this pathetic fool takes it for an omen and, of course, it isn\'t a good one. Whatever it is, it isn\'t going to get you where you need to be so you order the men to march. | [img]gfx/ui/events/event_12.png[/img] Shadows begin to fold in and on themselves in strange ways. You turn around to see the sun darkening, a great rim of black moving over it. Soon there is no sun at all. %superstitious% cries out that the end times are coming, but before his wailing can find a grip on the rest of your men, the great shade unveils the sun once more and there is light again as though nothing happened at all. You tell the pathetic fool to get to his feet. You\'ve places to march and tears sure as hell won\'t get you there. | [img]gfx/ui/events/event_11.png[/img] %superstitious% is poking his sword into a warren when he suddenly cries out. He leaps away from the rabbit hole and screams that there is a two headed bunny within. Apparently this is a bad omen of things to come. All you can think is that two heads just means more meat for the stew. | [img]gfx/ui/events/event_11.png[/img]You pass beneath a tree whose branches are occupied by both a black cat and an albino crow. %superstitious% cries at the sight of it, saying that this is surely a sign of the end times. Why yes, of course it is. These things are never a sign of good things, right? Yeesh. | [img]gfx/ui/events/event_11.png[/img] You come across a deer skull. At first it means nothing to you, but %superstitious% picks it up with earnest. Muted dust pours out of the cavity as he turns it this way and that. Hands trembling, he throws the head out of his hands. It clatters hollow against the ground, tumbling over onto where the horns should be. The scared man claims that a soothsayer once told him that he would come across a skull such as this.\n\nThere are many skulls out here, you argue, because things have a tendency to die. Your words do nothing for the man as he slowly, and nervously, shuffles back into the marching rank. | [img]gfx/ui/events/event_11.png[/img] Marching along, a few of the men take up a game of finding shapes in the clouds. They banter back and forth about dogs and fat women and even of home, but the fun takes a wild turn when %superstitious% sees one odd-shaped cloud that brings him to his knees. He cries out that it is a bad omen, this cloud, and that doom will soon be upon the company. Thankfully, the fear does not grip the rest of the company who, instead of trembling, soon start bickering over whether or not the cloud is truly representative of %randombrother%\'s impressive endowment.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{Pull yourself together! | And I thought only children had such silly fears.}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Superstitious.getImagePath());
				local effect = this.new("scripts/skills/effects_world/afraid_effect");
				_event.m.Superstitious.getSkills().add(effect);
				_event.m.Superstitious.worsenMood(1.0, "Has seen a bad omen");
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Superstitious.getName() + " is afraid"
				});

				if (_event.m.Superstitious.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Superstitious.getMoodState()],
						text = _event.m.Superstitious.getName() + this.Const.MoodStateEvent[_event.m.Superstitious.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2 || !this.World.getTime().IsDaytime)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if ((bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.mad")) && !bro.getSkills().hasSkill("effects.afraid"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Superstitious = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Superstitious.getID())
			{
				this.m.OtherGuy = bro;
				break;
			}
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"superstitious",
			this.m.Superstitious.getName()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.Superstitious = null;
		this.m.OtherGuy = null;
	}

});

