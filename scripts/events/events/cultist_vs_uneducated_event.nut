this.cultist_vs_uneducated_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		Uneducated = null
	},
	function create()
	{
		this.m.ID = "event.cultist_vs_uneducated";
		this.m.Title = "During camp...";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]A few brothers come to you looking rather worried. They say %cultist% has been sitting with %uneducated% for a few hours now. When you ask what\'s the worry, they remind you that the cultist has a scarred forehead and speaks of incredibly strange things. Ah, right.\n\nYou go and see the two men. %uneducated% looks up at you, smiling, and says the cultist actually has a lot to teach him. Grimacing, you wonder if you should put a stop to these... lessons.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Do as you wish, as long as you don\'t forget what I hired you to do.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Stop this nonsense.",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]You nod and turn away. The rest of the brothers shake their heads. By next morning, %uneducated% is found with a fresh wound on his forehead, the blood of conversion. When you ask how he is doing, he only says a few words.%SPEECH_ON%Davkul is coming.%SPEECH_OFF%Well, great.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Suit yourself.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation decreases slightly"
				});
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
				_event.m.Uneducated.getBackground().Convert();
				_event.m.Uneducated.getBackground().m.RawDescription += " " + _event.m.Cultist.getName() + " helped " + _event.m.Uneducated.getName() + " see the darkness.";
				_event.m.Uneducated.getBackground().buildDescription(true);
				_event.m.Uneducated.getBaseProperties().DailyWage -= _event.m.Uneducated.getDailyCost() / 2;
				_event.m.Uneducated.getSkills().update();
				this.List = [
					{
						id = 13,
						icon = _event.m.Uneducated.getBackground().getIcon(),
						text = _event.m.Uneducated.getName() + " has been converted to a Cultist"
					}
				];
				_event.m.Cultist.getBaseProperties().Bravery += 2;
				_event.m.Cultist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Cultist.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]You separate the two men, telling %uneducated% to go count some inventory. When he leaves, the cultist sneers at you.%SPEECH_ON%Davkul awaits. You see him in your sleep. You see him in the nights. His darkness is coming. No light burns forever.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Yeah, well, until then you work for me.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(2);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_moral_reputation.png",
					text = "The company\'s moral reputation increases"
				});
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
				_event.m.Cultist.worsenMood(2.0, "Was denied the chance to convert " + _event.m.Uneducated.getName());

				if (_event.m.Cultist.getMoodState() < ::Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = ::Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + ::Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists") return;
		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 4) return;

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist))
			{
				cultist_candidates.push(bro);
			}
			else if (bro.getSkills().hasSkill("injury.brain_damage")
				|| bro.getSkills().hasSkill("trait.dumb")
				|| (bro.getBackground().isBackgroundType(::Const.BackgroundType.Lowborn) && !bro.getSkills().hasSkill("trait.bright"))
			)
			{
				if (bro.getBackground().getID() != "background.legend_commander_berserker" && bro.getBackground().getID() != "background.legend_berserker" && bro.getBackground().getID() != "background.legend_donkey_background")
				{
					uneducated_candidates.push(bro);
				}
			}
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0)
		{
			return;
		}

		this.m.Cultist = cultist_candidates[::Math.rand(0, cultist_candidates.len() - 1)];
		this.m.Uneducated = uneducated_candidates[::Math.rand(0, uneducated_candidates.len() - 1)];
		this.m.Score = 65535;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist.getName()
		]);
		_vars.push([
			"uneducated",
			this.m.Uneducated.getName()
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
		this.m.Uneducated = null;
	}

});

