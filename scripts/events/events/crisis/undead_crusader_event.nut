this.undead_crusader_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_crusader";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]A figure stops you on the path. You put a hand to your sword and order him to announce his intentions, all the while keeping your eyes peeled for an ambush. The stranger takes a step forward and removes %their% helm.%SPEECH_ON%I am %crusader%, a fighter from a distant order. My order has been reduced to ruins. I slew the monsters of Dev\'ungrad. I gave peace to the spirits at Shellstaya. When the ancients speak, I listen. And so here I am.%SPEECH_OFF%You take your hand off your sword and ask them of the ancients. They nod and speak.%SPEECH_ON%The men before men, the ancients were suzerain over all things, having forged an empire that stretched to realms far beyond this one. All this chaos is mere fragments of their destruction. A man may die, but an empire does not. An empire decays, piece by piece, and takes with it all that it thinks it is owed.%SPEECH_OFF%The stranger puts %their% helmet back on and holds %their% sword up.%SPEECH_ON%The Empire of the Ancients stirs in its grave. I wish to help quiet it. I offer you my sword, mercenary.%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "You might as well join us.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "No, thanks, we\'re good.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");

				if (this.World.Assets.getOrigin().getID() == "scenario.legends_crusader")
				{
					_event.m.Dude.setStartValuesEx([
						"legend_youngblood_background"
					]);
					_event.m.Dude.getBaseProperties().Hitpoints += 5;
					_event.m.Dude.getBaseProperties().Fatigue += 7;
					_event.m.Dude.getBaseProperties().MeleeSkill += 10;
					_event.m.Dude.getBaseProperties().RangedSkill += 10;
					_event.m.Dude.getBackground().m.RawDescription = "With nowhere else to go, %name% resorted to seeking you out after the destruction of the monastery. With their home gone, the future from %them% and the order looks bleaker still.";
					_event.m.Dude.getBackground().buildDescription(true);
				}
				else
				{
					_event.m.Dude.setStartValuesEx([
						"legend_crusader_background"
					]);
					_event.m.Dude.getBackground().m.RawDescription = "With nowhere else to go, %name% resorted to seeking you out after the destruction of the monastery. With their home gone, the future from %them% and the order looks bleaker still.";
					_event.m.Dude.getBackground().buildDescription(true);
				}

				_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/hate_undead_trait"));
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
		{
			return;
		}

		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getBackground().getID() == "background.legend_commander_crusader")
			{
				return;
			}

			if (bro.getBackground().getID() == "background.legend_crusader")
			{
				return;
			}
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"crusader",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

