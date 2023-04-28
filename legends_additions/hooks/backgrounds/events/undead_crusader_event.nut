::mods_hookExactClass("events/events/crisis/undead_crusader_event", function (o)
{
	o.create = function()
	{
		this.m.ID = "event.crisis.undead_crusader";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]A man in a suit of armor stops you on the path. You put a hand to your sword and order him to announce his intentions, all the while keeping your eyes peeled for an ambush. The stranger takes a step forward and removes his helm.%SPEECH_ON%I am %crusader%, a fighter from a fiery land with no name. I stood upon the hills of evil counsel. I slew the monsters of Dev\'ungrad. I gave peace to the spirits at Shellstaya. When the ancients speak, I listen. And so here I am.%SPEECH_OFF%You take your hand off your sword and ask him of the ancients. He nods and speaks.%SPEECH_ON%The men before men, the ancients were suzerain over all things, having forged an empire that stretched to realms far beyond this one. All this chaos is mere fragments of their destruction. A man may die, but an empire does not. An empire decays, piece by piece, and takes with it all that it thinks it is owed.%SPEECH_OFF%The crusader puts his helmet back on and holds his sword up.%SPEECH_ON%The Empire of the Ancients stirs in its grave. I wish to help quiet it. I offer you my sword, mercenary.%SPEECH_OFF%",
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
				_event.m.Dude.setStartValuesEx([
					"crusader_background"
				]);

				_event.m.Dude.m.PerkPoints = 10;
				_event.m.Dude.m.LevelUps = 10;
				_event.m.Dude.m.Level = 11;
				_event.m.Dude.m.XP = ::Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(::Const.Attributes.COUNT, 0);
				talents[::Const.Attributes.MeleeSkill] = 3;
				talents[::Const.Attributes.MeleeDefense] = 3;
				talents[::Const.Attributes.Bravery] = 3;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

				_event.m.Dude.getSkills().add(::new("scripts/skills/traits/hate_undead_trait"));
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

});


