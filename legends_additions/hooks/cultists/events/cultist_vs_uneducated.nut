//changed the cooldown of cultist conversion to a week. Made the event more common
::mods_hookExactClass("events/events/cultist_vs_uneducated_event", function (o)
{
	o.create = function()
	{
		this.m.ID = "event.cultist_vs_uneducated";
		this.m.Title = "During camp...";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
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
					text = _event.m.Cultist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
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

				if (_event.m.Cultist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}
			}

		});
	}

	o.onUpdateScore = function()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists") return;

		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 4) return;

		this.logInfo("conversion reached 1: ");

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers )
		{
			local bg = bro.getBackground();

			if (bg.isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bg.isBackgroundType(::Const.BackgroundType.Cultist))
			{
				cultist_candidates.push(bro);
			}
			else if (bg.isBackgroundType(::Const.BackgroundType.Lowborn) && !bro.getSkills().hasSkill("trait.bright")
				|| (bg.isBackgroundType(::Const.BackgroundType.Noble) && bro.getSkills().hasSkill("trait.dumb"))
				|| bro.getSkills().hasSkill("injury.brain_damage"))
			{
				if (bg.getID() != "background.legend_commander_berserker"
					&& bg.getID() != "background.legend_berserker"
					&& bg.getID() != "background.legend_donkey_background")
				{
					if (bro.getFlags().get("IsSpecial") && bg.getID() != "background.kings_guard") continue;
					if (bro.getFlags().get("IsMilitiaCaptain")) continue;
					uneducated_candidates.push(bro);
				}
			}
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0) return;

		this.m.Cultist = ::MSU.Array.rand(cultist_candidates);
		this.m.Uneducated = ::MSU.Array.rand(uneducated_candidates);
		this.m.Score = 500 + cultist_candidates.len() * 45 + uneducated_candidates.len() * 30;
		this.logInfo("score: " + this.m.Score);
	}
});