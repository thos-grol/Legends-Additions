this.anatomist_helps_blighted_guy_1_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_helps_blighted_guy_1";
		this.m.Title = "On the road...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_53.png[/img]{You come across a man being buried alive, an inference you take from the fact that he\'s bound like a dead man yet still screaming about the whole affair. You ask what is going on and one of the diggers turns and holds a hand out.%SPEECH_ON%Keep yer distance. This man is blighted and anyone he touches becomes blighted. We don\'t want no disease, and neither should you.%SPEECH_OFF%The man cries out for help as another clump of soil lands on him. He tries to climb back out of the grave but one of the diggers kicks him back in, the kicker himself complaining he\'ll have to burn his favorite boot. The anatomist comes over with a quieted voice. He says the man has a skin disease which might look like leprosy or a plague, but is in fact benign. You ask if he\'s sure of it, and he nods, albeit with a finger of reluctance held up.%SPEECH_ON%I may be wrong, of course. And if I am, then his very real disease might spawn itself upon us all. But to bury a man alive is not something I find, how do you say, scientifically compelling.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "In that case we\'re going to help him.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "This is not our problem.",
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
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_88.png[/img]{You draw out your sword and order the diggers to stop. They look at you with incredulous stares. One points at the man in the grave.%SPEECH_ON%Did you not hear? This fella is blighted. What we\'re doing here might not look right but-%SPEECH_OFF%With a point of your sword, the digger falls quiet. You tell the man in the grave to hop on out, and as he does the diggers drop their shovels and back off. They tell you he\'s all yours. The supposedly diseased man ambles over, still frightened and no doubt unsure if his rescuers have anything better in mind for him than those who would bury him alive. The anatomist takes him under his wing and, after a brief examination, states that the man is ill, but it\'s not serious and he will recover in good time. For now, though, he needs rest.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Alright.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "We don\'t need anyone else.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return "D";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"vagabond_background"
				], false);
				_event.m.Dude.setTitle("");
				_event.m.Dude.getFlags().set("IsSpecial", true);
				_event.m.Dude.getBackground().m.RawDescription = "The Anatomist rescued %name% from being buried alive for carrying some strange disease. Now he has the unique pleasure of both bearing the plague AND being a lab rat for some researchers. Stay over there, please.";
				_event.m.Dude.getBackground().buildDescription(true);

				_event.m.Dude.m.PerkPoints = 8;
				_event.m.Dude.m.LevelUps = 8;
				_event.m.Dude.m.Level = 9;
				_event.m.Dude.m.XP = ::Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);
				talents[this.Const.Attributes.MeleeSkill] = 3;
				talents[this.Const.Attributes.MeleeDefense] = 3;
				talents[this.Const.Attributes.Bravery] = 3;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
				}

				_event.m.Dude.worsenMood(1.5, "Was almost buried alive for bearing a disease");
				local i = this.new("scripts/skills/injury/sickness_injury");
				i.addHealingTime(8);
				_event.m.Dude.getSkills().add(i);
				_event.m.Dude.getFlags().set("IsMilitiaCaptain", true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You tell the man that the %companyname% doesn\'t need anymore sellswords. You also imply that, before he goes, he should maybe consider compensating you for the help. He nods and takes off his boot, revealing he had gold stashed in there. Not trusting what illness he has, you tell him to rub the coins on the grass and then kick it over with his feet. He does as told. He nods.%SPEECH_ON%Well. I appreciate it. You take care out there.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good luck to you as well.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(65);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]65[/color] Crowns"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins) return;
		if (!::World.Statistics.getFlags().has("retinue_anatomist") 
			|| !::World.Statistics.getFlags().get("retinue_anatomist") ) return;
		
		local currentTile = this.World.State.getPlayer().getTile();
		if (!currentTile.HasRoad) return;
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

