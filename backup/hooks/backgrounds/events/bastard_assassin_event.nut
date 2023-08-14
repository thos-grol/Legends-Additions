::mods_hookExactClass("events/events/bastard_assassin_event", function (o)
{
	o.create = function()
	{
		this.m.ID = "event.bastard_assassin";
		this.m.Title = "During camp...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "Intro",
			Text = "[img]gfx/ui/events/event_33.png[/img]Under the cover of night, a man slips into your tent beneath the folds wafting just over the ground. He\'s masked with a black cloak and noble pauldrons. You arm yourself, but he holds a hand out.%SPEECH_ON%Don\'t bother, sellsword, for I am not here for you.%SPEECH_OFF%That\'s not good enough for you. The second the man takes another step, you charge and plant him on your table and with your free arm put a dagger to his neck. He grins.%SPEECH_ON%I already told you that I am not here for you. I am here for %bastard%.%SPEECH_OFF%The bastard nobleman? You ask what the stranger wants with him.%SPEECH_ON%Well, that depends, are you willing to talk?%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Alright, talk.",
					function getResult( _event )
					{
						return "A";
					}

				},
				{
					Text = "No talking. You just die.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 33)
						{
							return "Decline1";
						}

						if (r <= 66)
						{
							return "Decline2";
						}
						else
						{
							return "Decline3";
						}
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Assassin = roster.create("scripts/entity/tactical/player");
				_event.m.Assassin.setStartValuesEx([
					"assassin_background"
				]);

				_event.m.Assassin.m.PerkPoints = 9;
				_event.m.Assassin.m.LevelUps = 9;
				_event.m.Assassin.m.Level = 10;
				_event.m.Assassin.m.XP = ::Const.LevelXP[_event.m.Assassin.m.Level - 1];
				_event.m.Assassin.m.Talents = [];
				local talents = _event.m.Assassin.getTalents();
				talents.resize(::Const.Attributes.COUNT, 0);
				talents[::Const.Attributes.MeleeSkill] = 3;
				talents[::Const.Attributes.MeleeDefense] = 3;
				talents[::Const.Attributes.Initiative] = 3;
				_event.m.Assassin.m.Attributes = [];
				_event.m.Assassin.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);

				this.Characters.push(_event.m.Assassin.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]You lift the dagger from his neck. He straightens up on the table and glances at the map.%SPEECH_ON%I see the %companyname% has marched far and wide. %bastard% chose wisely to fit himself into its ranks.%SPEECH_OFF%When a drop of blood spatters the paper, he pauses to scratch a small nick you left on his neck, pursing his lips as though he had done it to himself in a morning shave.%SPEECH_ON%Anyway, let\'s get down to business. My benefactors want %bastard% dead. Seeing as how I\'ve been paid a large sum of coin, I am obligated to see this ambition to its end. Or... maybe not.%SPEECH_OFF%When he raises a playful eyebrow, you tell him to spill what he\'s thinking. He stiltwalks a sexton across the map as he talks.%SPEECH_ON%%bastard% has an army waiting for him if he so chooses. That\'s why the nobles want him dead, because he stands as a real and viable threat to the status quo and this he does not yet know. I suppose he doesn\'t have to, either, but it\'d be a nice send off, no? You get to see to it that his place in this world is justified and that he isn\'t some accident gliding through a world he believes to hate him. But what about me, a grossly talented assassin with a perfect streak of kills, hm? What about me? Well, I don\'t want this life anymore. So here\'s my offer: I take his place. He goes home, I go with you. He goes and conquers, my benefactors are nonethewiser and for all they know, I simply disappeared. Sounds good, no?%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We have a deal.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "How much are you paid for this?",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "Or I\'ll just kill you.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 33)
						{
							return "Decline1";
						}

						if (r <= 66)
						{
							return "Decline2";
						}
						else
						{
							return "Decline3";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]%bastard% deserves better. Not that the %companyname% is beneath him, but he is a man who has spent his whole life seeing himself as an outsider, a blight upon his own family name, a threat to those he love merely because they carry a finer bloodline than he. You agree to the assassin\'s demand and send for the bastard to enter your tent. When he does, you quickly explain the situation. He asks for proof that an army is awaiting him and the hired killer quickly complies, producing a stamped scroll with a sigil and signature only the bastard could recognize. %bastard% reads it carefully. He lowers and looks to you.%SPEECH_ON%And you are alright with this? The destiny is mine to take, but you have my sword and allegiance for as long as you want.%SPEECH_OFF%You clap the man on the shoulder and tell him to go forge his path. The assassin tells him if he is to do it then he should do it quickly. A little tearful, and not at all trying to hide it, %bastard% thanks you for at the very least believing in him even if only for the short time he was with the %companyname%. And then he leaves. Turning around, you find the assassin bowing.%SPEECH_ON%And just like that, you have my sword, captain.%SPEECH_OFF%This will take some explaining to the other men, but they\'ll be sure to trust your intuition here.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Take care you bastard.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Assassin);
						this.World.getTemporaryRoster().clear();
						_event.m.Assassin.onHired();
						_event.m.Bastard.getItems().transferToStash(this.World.Assets.getStash());
						_event.m.Bastard.getSkills().onDeath(::Const.FatalityType.None);
						this.World.getPlayerRoster().remove(_event.m.Bastard);
						_event.m.Bastard = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
				this.Characters.push(_event.m.Bastard.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Bastard.getName() + " leaves the " + this.World.Assets.getName()
				});
				this.List.push({
					id = 13,
					icon = "ui/icons/special.png",
					text = _event.m.Assassin.getName() + " joins the " + this.World.Assets.getName()
				});
				_event.m.Assassin.getBackground().m.RawDescription = "%name% joined the company in exchange for " + _event.m.Bastard.getName() + "\'s life. Little is known about the assassin and most remain wary of him. With a dagger in hand, the killer\'s sword-hand swerves and sways more akin to a snake than a man.";
				_event.m.Assassin.getBackground().buildDescription(true);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]Before you decide anything, you ask the assassin how much was offered to slay the bastard. He weighs the numbers by tilting his head side to side.%SPEECH_ON%Well, it was... and then, deducting travel time, equipment costs, the time it took to find the damn sod, and the time it took scouting your encampment and figuring out whether you\'d be open to dialogue I\'d say... five-thousand crowns. If you\'re thinking of matching that, it\'s going to be a bit more. About one-thousand more, so that\'d be six-thousand crowns on your bill. You still up for that sort of \'discussion\', hm?%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I agree to your offer. %bastard% will go, and you will take his place.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "I will pay you those 6,000 crowns, and both %bastard% and you will stay.",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "I think I\'ll just kill you.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 33)
						{
							return "Decline1";
						}

						if (r <= 66)
						{
							return "Decline2";
						}
						else
						{
							return "Decline3";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_33.png[/img]While the %companyname% is doing well, it could be doing the best in the world and six-thousand crowns would still be a lot to ask for. But... you agree. The assassin hears your words and sits there for a moment.%SPEECH_ON%You agree? You\'ll pay six-thousand crowns, really?%SPEECH_OFF%You nod. He mulls the words over for another moment, a slight break in an otherwise stalwart presentation he has been putting on.%SPEECH_ON%Gotta be honest, didn\'t think you\'d do that. But a deal is a deal, and I am not one to playfully waste words.%SPEECH_OFF%He jets his hand out and you take it with a firm shake - just in case it is a ruse. He bows gracefully, no doubt something he learned in the halls of the noblemen that had sent him here in the first place.%SPEECH_ON%Captain of the %companyname%, you have my blade!%SPEECH_OFF%It\'ll take some explaining as to how a random man slipped into the company overnight, but the men have enough faith in your command that you could have recruited a sword-wielding goat and they would go along with it.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome aboard, assassin.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Assassin);
						this.World.getTemporaryRoster().clear();
						_event.m.Assassin.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
				_event.m.Assassin.getBackground().m.RawDescription = "An assassin tired of the killing life, %name% offered to join your company at a large price which you were quick to match. He is extremely skilled with a short-blade, twirling daggers around with more dexterity and control than some men have over their own fingers.";
				_event.m.Assassin.getBackground().buildDescription(true);
				this.World.Assets.addMoney(-6000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + ::Const.UI.Color.NegativeEventValue + "]6,000[/color] Crowns"
				});
				this.List.push({
					id = 13,
					icon = "ui/icons/special.png",
					text = _event.m.Assassin.getName() + " joins the " + this.World.Assets.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Decline1",
			Text = "[img]gfx/ui/events/event_33.png[/img]You refuse the assassin\'s offer. He nods.%SPEECH_ON%Alright.%SPEECH_OFF%The dagger comes quick, faster than you thought it would have. Your hand rises to deflect, but it\'s a moment too slow. A knife\'s edge clips your cheek and draws blood. By the time you draw your sword, the assassin has already leapt out of the tent. You hear a commotion outside and rush to it. %bastard% the bastard is laying on the ground, a few other brothers beside him. %otherbrother% comes over to ask if you\'re okay. He says a man in black tried to kill the bastard.%SPEECH_ON%I think we mortally wounded him, but I don\'t know where he went. Farker slashed the lot of us. Sir, you\'re bleeding.%SPEECH_OFF%You tell him you know and that the priority right now is to take care of the bastard and the rest of the men.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Well, at least no one was killed.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bastard.getImagePath());
				local injury = _event.m.Bastard.addInjury(::Const.Injury.PiercingBody);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Bastard.getName() + " suffers " + injury.getNameOnly()
				});
				injury = _event.m.Bastard.addInjury(::Const.Injury.PiercingBody);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Bastard.getName() + " suffers " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "Decline2",
			Text = "[img]gfx/ui/events/event_33.png[/img]You put a hand to the pommel of your sword and decline the assassin\'s request. He claps his hands.%SPEECH_ON%Alright, sellsword. Fair enough. And don\'t bother with the theatrics there.%SPEECH_OFF%He nods to your sword-hand.%SPEECH_ON%If I really wanted the bastard dead, do you think I\'d be standing here? I came to talk, and talk we did. The killing life has left me and with it, apparently, so too did my poker face. You called my bluff and I suppose that\'s that. Good evening, mercenary.%SPEECH_OFF%Before you can say another word, the assassin ducks out of the tent. You rush to see where he\'d gone to, but all you find is the dark of night. %bastard% the bastard spies you peering around and asks what you\'re up to. You smile and tell him to get some rest for he truly deserves it. Confused, the man shrugs.%SPEECH_ON%Well, uh, I guess so. Thanks, captain.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I guess that was that.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bastard.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Decline3",
			Text = "[img]gfx/ui/events/event_33.png[/img]You refuse the assassin\'s offer. He nods, coursing a hand over a candle.%SPEECH_ON%Well then. I guess our talk has come to an end and so something else must begin.%SPEECH_OFF%His face turns to you. He winks.\n\n The dagger comes quick, its sheen flashing as it slashes just before your face. You reach for your blade but the man kicks your hand, slamming the sword back into its scabbard. A second dagger comes - this one yours, unsheathed from behind your back and launched forward with murderous intentions. The assassin\'s dagger pops open into a trident into which your blade gets caught. He twists his hand, disarming you in an instant, then twists his hand back around, closing the dagger into one blade again. Sonuvabitch...\n\n The man goes for a stab, but you catch his arm. He shushes you with his free hand before retrieving another blade which you\'ve no means to stop. He whispers with disturbing calmness.%SPEECH_ON%Die with grace, captain.%SPEECH_OFF%As his hand goes backward, it suddenly disappears in a glint of metal. All that remains is a nub spewing crimson. The assassin looks at the stump and screams. %bastard% is standing there, weapon in hand. Another flash of metal and the assassin\'s head rolls off his shoulders. A gush of blood pours out of the hole as his torso slams into your table and back against the ground. The bastard hurriedly asks.%SPEECH_ON%Are you alright? Who in the fark was that?%SPEECH_OFF%More sellswords enter the tent to see what the commotion was. You let them know an assassin had come for the bastard, but you weren\'t going to give him over that easy. The men applaud your defense of the mercenary.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You owe me, you bastard.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bastard.getImagePath());

				if (!_event.m.Bastard.getSkills().hasSkill("trait.loyal") && !_event.m.Bastard.getSkills().hasSkill("trait.disloyal"))
				{
					local loyal = ::new("scripts/skills/traits/loyal_trait");
					_event.m.Bastard.getSkills().add(loyal);
					this.List.push({
						id = 10,
						icon = loyal.getIcon(),
						text = _event.m.Bastard.getName() + " is now loyal"
					});
				}

				_event.m.Bastard.improveMood(2.0, "You risked your life for him");

				if (_event.m.Bastard.getMoodState() >= ::Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = ::Const.MoodStateIcon[_event.m.Bastard.getMoodState()],
						text = _event.m.Bastard.getName() + ::Const.MoodStateEvent[_event.m.Bastard.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Bastard.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.5, "You risked your life for the men");

						if (bro.getMoodState() >= ::Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = ::Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + ::Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}
});