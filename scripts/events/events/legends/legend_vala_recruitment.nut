this.legend_vala_recruitment <- this.inherit("scripts/events/event", {
	m = {
		Vala = null,
	},
	function create()
	{
		this.m.ID = "event.legend_vala_recruitment";
		this.m.Title = "From the bushes...";
		this.m.Cooldown = 60 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/legend_vala_recruitment.png[/img]The forests of the north are a primeval place, the span of a life is measured in months and the climate is a perpetual state of autumn or winter where the wildlife is as deadly as the weather. Walking through these forests is humbling — the trees here have outlived but the gods themselves, or so some would say.\nYour thoughts begin to wander further as the bridle path begins to feel endless and the trees curl inwards. The pressure builds in your head as you fall to the ground.\n The brush parts for a woman clad in furs holding a staff, focusing intently on you as you try to regain your balance. The noise stops and your mind clears. The woman speaks.\n%SPEECH_ON%Why are you here, outsider?%SPEECH_OFF% Her brow furrows and she hums, but her lips part again. %SPEECH_ON%I know what you are, and I know what you have done. Not just in this life — but the ones that have come before.%SPEECH_OFF%\nHer gaze lifts as she loses focus with you and looks down the path, deep in contemplation. The weight in your mind begins to lift as a tide ebbs before it comes crashing back. However, as she fixes her gaze with yours, the wave doesn\'t come crashing back. It is still there, at the back of your head — restrained like a warhound on a chain\n%SPEECH_ON%Something is changing outsider — something is coming that we can\'t stand alone and face. I do not care for your work, your motivations or hardships. I care about stopping the cataclysm of what is to come.%SPEECH_OFF% She purses her lips %SPEECH_ON%Shall we begin?%SPEECH_OFF%\nThe humming stops — the pain lifts as fast as it came. Despite what the people of the south say, the grip of the old gods remains firm here.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the %companyname%.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Vala);
						this.World.getTemporaryRoster().clear();
						_event.m.Vala.onHired();
						_event.m.Vala = null;
						return 0;
					}

				},
				{
					Text = "Keep your distance!",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Vala = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Vala = roster.create("scripts/entity/tactical/player");
				_event.m.Vala.setStartValuesEx([
					"legend_vala_background"
				]);
				_event.m.Vala.m.Talents = [];
				local talents = _event.m.Vala.getTalents();
				talents.resize(::Const.Attributes.COUNT, 0);
				talents[::Const.Attributes.Hitpoints] = 3;
				talents[::Const.Attributes.Bravery] = 3;
				talents[::Const.Attributes.Initiative] = 3;
				_event.m.Vala.m.Attributes = [];
				_event.m.Vala.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

				this.Characters.push(_event.m.Vala.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		if (playerTile.SquareCoords.Y < this.World.getMapSize().Y * 0.7) return;

		local brothers = this.World.getPlayerRoster().getAll();
		local totalbrothers = 0;
		local brotherlevels = 0;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.legend_vala")
			{
				return;
			}

			if (bro.getBackground().getID() == "background.legend_commander_vala")
			{
				return;
			}

			totalbrothers = totalbrothers + 1;
			brotherlevels = brotherlevels + bro.getLevel();
		}

		if (brotherlevels < 30) return;

		this.m.Score = 65535;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Vala = null;
	}

});

