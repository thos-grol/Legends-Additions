this.find_artifact_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.find_artifact";
		this.m.Name = "Expedition";
		this.m.Description = "As the war rages on, scouts report the existence of an ancient relic that could shift the balance of the war. Fight through the undead hordes and steal back that relic.";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		local myTile = this.World.State.getPlayer().getTile();
		local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		local highestDistance = 0;
		local best;

		foreach( b in undead )
		{
			if (b.isLocationType(this.Const.World.LocationType.Unique))
			{
				continue;
			}

			local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 45);

			if (d > highestDistance)
			{
				highestDistance = d;
				best = b;
			}
		}

		this.m.Destination = this.WeakTableRef(best);
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		local nemesisNames = [
			"the Raven",
			"the Fox",
			"the Bastard",
			"the Cat",
			"the Lion",
			"the General",
			"the Robber Baron",
			"the Rook"
		];
		local nemesisNamesC = [
			"The Raven",
			"The Fox",
			"The Bastard",
			"The Cat",
			"The Lion",
			"The General",
			"The Robber Baron",
			"The Rook"
		];
		local nemesisNamesS = [
			"Raven",
			"Fox",
			"Bastard",
			"Cat",
			"Lion",
			"General",
			"Robber Baron",
			"Rook"
		];
		local n = this.Math.rand(0, nemesisNames.len() - 1);
		this.m.Flags.set("NemesisName", nemesisNames[n]);
		this.m.Flags.set("NemesisNameC", nemesisNamesC[n]);
		this.m.Flags.set("NemesisNameS", nemesisNamesS[n]);
		this.m.Payment.Pool = ::Z.Economy.Contracts[this.m.Type] * this.getReputationToPaymentMult();
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else if (r == 2)
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Score", 0);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Retrieve the artifact from %objective% to the %direction%"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					this.Flags.set("IsLost", true);
				}

				r = this.Math.rand(1, 100);

				if (r <= 20)
				{
					if (!this.Flags.get("IsLost"))
					{
						this.Flags.set("IsScavengerHunt", true);
					}
				}
				else if (r <= 25)
				{
					this.Flags.set("IsTrap", true);
				}
				else if (r <= 30)
				{
					this.Flags.set("IsTooLate", true);
				}

				if (!this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.m.Destination.setLootScaleBasedOnResources(130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));

				if (!this.Flags.get("IsLost") && !this.Flags.get("IsTooLate"))
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsTrap") && !this.Flags.get("IsTrapShown"))
					{
						this.Flags.set("IsTrapShown", true);
						this.Contract.setScreen("Trap");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsScavengerHunt") && !this.Flags.get("IsScavengerHuntShown"))
					{
						this.Flags.set("IsScavengerHuntShown", true);
						this.Contract.setScreen("ScavengerHunt");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("SearchingTheRuins");
						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.Flags.get("IsLost") && !this.Flags.get("IsLostShown") && this.Contract.isPlayerNear(this.Contract.m.Destination, 500))
				{
					this.Flags.set("IsLostShown", true);
					local brothers = this.World.getPlayerRoster().getAll();
					local hasHistorian = false;

					foreach( bro in brothers )
					{
						if (bro.getBackground().getID() == "background.historian")
						{
							hasHistorian = true;
							break;
						}
					}

					if (hasHistorian)
					{
						this.Contract.setScreen("AlmostLost");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("Lost");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (!this.Flags.get("IsAttackDialogShown"))
				{
					this.Flags.set("IsAttackDialogShown", true);

					if (this.Flags.get("IsTooLate"))
					{
						this.Contract.setScreen("TooLate1");
					}
					else
					{
						this.Contract.setScreen("ApproachingTheRuins");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					_dest.m.IsShowingDefenders = true;
					this.World.Contracts.showCombatDialog();
				}
			}

		});
		this.m.States.push({
			ID = "Running_TooLate",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Catch up to %nemesis% and get the artifact"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onCombatWithNemesis.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					this.Contract.setScreen("TooLate3");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatWithNemesis( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;

				if (!this.TempFlags.get("IsAttackDialogWithNemesisShown"))
				{
					this.TempFlags.set("IsAttackDialogWithNemesisShown", true);
					this.Contract.setScreen("TooLate2");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					properties.Music = this.Const.Music.NobleTracks;
					properties.Entities.push({
						ID = this.Const.EntityType.BanditLeader,
						Variant = 0,
						Row = 2,
						Script = "scripts/entity/tactical/enemies/bandit_leader",
						Faction = _dest.getFaction(),
						Callback = this.onNemesisPlaced.bindenv(this)
					});
					properties.EnemyBanners = [
						this.Const.PlayerBanners[this.Flags.get("NemesisBanner") - 1]
					];
					this.World.Contracts.startScriptedCombat(properties, true, true, true);
				}
			}

			function onNemesisPlaced( _entity, _tag )
			{
				_entity.setName(this.Flags.get("NemesisNameC"));
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(null);
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_45.png[/img]{You find %employer% looking at a pile of maps, sifting through them with the very tools used to draw them in the first place. He looks up, a cartographer\'s strained look on his face.%SPEECH_ON%My scribes have handed me these maps, telling me that they\'ve found a place named \'%objective%\'. It is said to hold immense power somewhere in its halls, or corridors, or, uh, whatever it is that is there.%SPEECH_OFF%You raise an eyebrow, but the man persists.%SPEECH_ON%Look, my scribes honestly believe that whatever is there might help us find a solution to this undead scourge. But they\'ve also told me that others are seeking it out. I need you to get there before anyone else.%SPEECH_OFF% | %employer% greets you by unfurling a map, the paper standing from his head to toe. He wraps a finger around one of its edges to plant on a certain spot.%SPEECH_ON%See this? It is called \'%objective%\'. A place that I... don\'t actually know that much about. What I do know is that others are going there and supposedly it is to retrieve an artifact of some great power. My scribes believe this supposed artifact might help us fight off the undead scourge. Obviously, I\'d like you to go and get it before anyone else does!%SPEECH_OFF% | %employer% presents you a map, in particular a certain location upon it.%SPEECH_ON%That would be what is called \'%objective%\'. Rumors state that other men are seeking it out. My scribes, who are not fond of rumors, believe that it holds a certain artifact we could use to help fight off the undead scourge. This area is located deep within hostile territory and I have reason to believe you won\'t be the only ones looking for it. Go there, bring the artifact back to me and I will reward you handsomely.%SPEECH_OFF% | When you meet %employer% he hurriedly implores you to come to his side and read a book. You see a language that you know not ever existed, but there\'s also a map on the pages which needs no translation, in particular the location upon it which is heavily circled by a quill pen. %employer% taps it.%SPEECH_ON%I need you to go there, sellsword. They call it \'%objective%\'. My scribes state it holds an artifact of great power that we could use to fight off the undead scourge. Of course, an artifact such as that isn\'t going to just be sitting out in the open. I\'d very much expect all manner of man and creature to be prowling that area, drawn by the hum of the artifact\'s very power! You need to get it and bring it back.%SPEECH_OFF% | %employer% welcomes you and quickly describes a location called \'%objective%\', some horrid place that lies %direction% from where you are.%SPEECH_ON%My scribes state this area holds an artifact of immense power that could help us fight off the undead scourge. Of course, they might just be trying to sell me on getting something they want to study. For now, I believe them. I need you to go there and find it. Immense power is magnetizing so I would not expect to be the only goof footing around out there, understand? Go and bring it back to me and you will be rewarded accordingly.%SPEECH_OFF% | You find a scribe leaning into %employer%\'s ear, whispering things that has the nobleman nodding repeatedly. Upon seeing you, he quickly explains the situation.%SPEECH_ON%Sellsword! I have gotten... news, that a place %direction% of here contains an immense power we need to get a hold of. I think it will help us fight off the undead scourge. Of course, if it really has the power to do that then we can easily assume others will be looking for this item, too! For that reason, speed is of the utmost importance. I want you there and back.%SPEECH_OFF% | %employer% is found stepping through his personal graveyard. He stands before a gravestone.%SPEECH_ON%Every night, I worry that these will start moving and my ancestors will rise up, come to destroy me for my failings.%SPEECH_OFF%He turns and looks at you with a cold grimace on his face. Without speaking, he takes you into his home where an old man is poring over books completely covering his desk. %employer% tells you to speak to the man and then goes and stands by the door. You sit down across from the elder who puts down his quill pen.%SPEECH_ON%{My liege has granted me the honor of telling you everything you need to know. I have identified an artifact of great power located %direction% of here in a place called \'%objective%\'. I believe this artifact may contain the power to help resolve this issue with the dead... coming alive again. I also believe that power of this magnitude does not go unnoticed in this world. You need to go there, fight off anyone who thinks it belongs to them, and return to us. | Welcome, sellsword. It is not often I go to a man of your vocation to solve my problems. A good book and a quiet evening used to more than suffice, but no longer. We need you to travel %direction% of here to a place called \'%objective%\'. We have reason to believe it may contain the answer to our problem of the dead walking among us. Of course, such power is a powerful lure. You need to move fast to get there and back, lest we may lose it.}%SPEECH_OFF% | A scribe stands at %employer%\'s side. Both men are staring at a piece of paper. As you near, they slowly push it across the table for you to read. It appears that the scribe has located a place of immense power and they believe it may contain the solution to the undead scourge. %employer% believes many others will be hunting for it, too, and that speed is of the utmost importance. | You find %employer% talking to a scribe, both men noses down into a book, a flickering candle between them. Upon hearing you, the lord quickly looks up and explains the situation at hand: they have deciphered the location of a great artifact, an artifact which very well may contain the answer to the dead walking the earth. %employer% nods dutifully.%SPEECH_ON%We have reason to believe that you won\'t be alone in seeking it out, nor that where it lies is the safest of places to begin with.%SPEECH_OFF% | %employer% takes a torch off a brazier and takes you down into some crypts. You watch as ghoulish statues emerge from the dark, the nobleman\'s flame bringing life to shades and shadows. He pauses before one then turns around.%SPEECH_ON%This is my father. Listen closely.%SPEECH_OFF%You put your ear toward the enormous sarcophagus and hear a faint scratching from within. %employer% shakes his head.%SPEECH_ON%My scribes have deciphered the location of a supposed great artifact. It lies %direction% from here in a place called \'%objective%\'. It may or may not contain the power to end this madness. Of course, such power never exists quietly in this world. We expect many others, man or otherwise, to be around the artifact. Go there, sellsword, and bring it back to me and you will be rewarded.%SPEECH_OFF%He waves the torch back to the coffin which emits a muted growl.%SPEECH_ON%For our sake and theirs.%SPEECH_OFF% | %employer% and his scribe take you down into the catacombs. There you find a coffin which has been broken open. Two guards stand with pikes to push a ghoulish and decaying woman from attacking. She snarls and snaps at them, teeth chomping in hollow clatters as the firelight fills her gaunt shapes. %employer% turns to you.%SPEECH_ON%We know not what this is or what started it, but we think that a location called \'%objective%\' which lies %direction% from here may contain the answer. An artifact of some power is supposed to be there and I need you bring it back. My scribe states you should prepare for dangers unknown.%SPEECH_OFF%The walking dead girl growls and lurches forward, impaling herself on a blade and pushing herself down it. The scribe nods and %employer% continues.%SPEECH_ON%If it can end this torment, who knows what else it may do.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{I trust you\'ll pay amply for a dangerous journey as this. | That\'s a long way from here, so it better pay well.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This isn\'t worth it. | It\'s too long a march. | We have more pressing business to attend to. | We\'re needed elsewhere.}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "ApproachingTheRuins",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_57.png[/img]{Right, the ruins. Let\'s see if %employer% and his silly scribes know what they\'re talking about. | You come to the ruins. There isn\'t much around which has you uneasy. You tell the %companyname% to prepare for the worst. | Finally, you arrive at the supposed home of a great artifact. Time to see if %employer% and his scribes really knew what the hell they were talking about. | The ruins stand slanting and folding into one another. Almost as if on cue, a cloud of bats come screeching out. %randombrother% ducks and the rest of the men have a laugh. | You find %objective% and stand on a hill adjacent. Looking down, you can see why it was hidden for so long, the place in such an innocuous location. Even from here you can listen to the wind curving through its stoneworks. | You arrive at %objective% and %randombrother% assesses it like you\'d expect.%SPEECH_ON%Looks lame as hell. Let\'s get on with it, yeah?%SPEECH_OFF%Hopefully, he is right. | %randombrother% straightens up.%SPEECH_ON%Hell, I think that\'s it.%SPEECH_OFF%He stares at a group of ruins that do in fact appear to be %objective%. He claps and rubs his hands together.%SPEECH_ON%Let\'s get on with it. I swear to fark if there\'s some lich in there I\'m gonna be complaining long after I\'m dead.%SPEECH_OFF% | %randombrother% looks down at %objective% which lies in the distance.%SPEECH_ON%So, what do you think is down there? I think %employer% is fooling us. We\'re gonna walk in there and be greeted by a bunch of beautiful women. A reward for us hardworking men, ya know?%SPEECH_OFF%For some reason, you do not think this will be the case. | %objective% lies a short distance away. You can only see the slanting stoneworks from here, but a smell lingers far from where it is. %randombrother% covers his nose.%SPEECH_ON%Smells like my aunt\'s shits. Wouldn\'t surprise me if that witch was in there, too.%SPEECH_OFF% | Approaching %objective%, you tell your men to prepare for a fight. Who knows what awaits the %companyname% in these forbidden lands! | As you approach %objective%, soft whispers pass you by.%SPEECH_ON%{Go in. Go in. It\'s for the best. You will like it here, yes you will. We agree. Yes, we do. Please, hurry. We can\'t wait any longer! | You\'re not the first. You\'re not the first. You won\'t be the last. You won\'t be the last. | Silly man, you think your thoughts are your own? | Your men will betray you. They believe you useless. Turn back you sniveling insect. | Here you are. Here you will forever be. | Ah, more humans. I can hardly stand the smell of you in this state. You are poison to the air I breathe. Let me have you. I will put rot in your bellies and you will be so much better for it... | A daring little man you are to come here, but you are just a mere specimen. Fear will fill your heart until there is no room for anything more. And then you will die. So it is, so it will be. | Approach little human. Here is where I\'ve always wanted you to be. | Yes! You have finally come! It is so good to see you, human, so very good to see you! | Ah, another cruel beast approaches. What a stupid little thing it is. Yes, very stupid. What shall we do with it? Let it in, of course. Of course!}%SPEECH_OFF%%randombrother% turns a finger in his ear.%SPEECH_ON%Did you say something, sir?%SPEECH_OFF%You shake your head and hurriedly tell the men to prepare for anything. | As you approach %objective%, soft whispers pass you by.%SPEECH_ON%{Go in. Go in. It\'s for the best. You will like it here, yes you will. We agree. Yes, we do. Please, hurry. We can\'t wait any longer! | You\'re not the first. You\'re not the first. You won\'t be the last. You won\'t be the last. | Silly man, you think your thoughts are your own? | Your men will betray you. They believe you useless. Turn back you sniveling insect. | Here you are. Here you will forever be. | Ah, more humans. I can hardly stand the smell of you in this state. You are poison to the air I breathe. Let me have you. I will put rot in your bellies and you will be so much better for it... | A daring little man you are to come here, but you are just a mere specimen. Fear will fill your heart until there is no room for anything more. And then you will die. So it is, so it will be. | Approach little human. Here is where I\'ve always wanted you to be. | Yes! You have finally come! It is so good to see you, human, so very good to see you! | Ah, another cruel beast approaches. What a stupid little thing it is. Yes, very stupid. What shall we do with it? Let it in, of course. Of course!}%SPEECH_OFF%%randombrother% turns a finger in his ear.%SPEECH_ON%Did you say something, sir?%SPEECH_OFF%You shake your head and hurriedly tell the men to prepare for anything.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Be on your guard!",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SearchingTheRuins",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_57.png[/img]{Finally, you got the artifact. Its weight seems off in your hands, as though it should be heavy, but there\'s something keeping it artificially light. You sack it up and get ready to head back to your employer, %employer%. | You now have the artifact which you\'ve been seeking. If you\'re being honest, it\'s a bit of a disappointment. A part of you was hoping it\'d give you immense power, but instead it idly sits in your hands. Perhaps you just weren\'t the chosen one. | You take the artifact, ignoring the muted hum it is giving off, and ready a return to %employer%. | You take the artifact and get a good look at it. %randombrother% walks up and puts his fists to his hips.%SPEECH_ON%Hell, that ugly thing ain\'t that precious.%SPEECH_OFF% | You weigh the artifact in your hands. It goes from light to heavy and back again. Well, that\'s weird enough and so you quickly shove it into a satchel. | %randombrother% takes a look at the artifact before you stow it away.%SPEECH_ON%Doesn\'t look like much.%SPEECH_OFF%You tell him a lot of things that are of power don\'t look like much. He sits there and thinks.%SPEECH_ON%My farts don\'t look like nothing at all, so I guess yer right.%SPEECH_OFF% | You give the artifact to %randombrother%. He holds it up.%SPEECH_ON%What if I smashed it right here and now, would you be mad?%SPEECH_OFF%You glare at the man.%SPEECH_ON%Yeah, a little. But maybe there are little demons in there that\'ll fark you for eternity for breaking their home. Who knows, right?%SPEECH_OFF%The mercenary quickly puts the artifact into a satchel. | You look at the artifact. It is blank and unmoving, not something you\'d expect to hold great power, but for some reason that\'s the most unsettling part. You quickly put it into a satchel. | You put the artifact into a satchel only for it to glow and call out to you. Opening the sack, you look down at two red dots staring back up at you. %randombrother% asks if you\'re alright. You quickly snap the satchel closed and nod. | You finally have the artifact. It doesn\'t glow, it doesn\'t hum, it doesn\'t even look all that pretty. You\'re not sure what the big fuss was about, but if %employer% wants to pay you for it that\'s his concern. | Well, you got the artifact. %randombrother% walks over, scratching his head.%SPEECH_ON%So a lotta people died for that little thing?%SPEECH_OFF%The artifact rattles and a growling voice answers.%SPEECH_ON%They didn\'t die. They\'re with me now and forever.%SPEECH_OFF%The mercenary jumps back.%SPEECH_ON%You know what? I didn\'t hear that. I don\'t know what that was. I don\'t care. Nope. Just gonna go back to eating hard, stale bread and living a boring life thank you very much.%SPEECH_OFF% | You hold the artifact, using a cloth between it and you lest its powers seep into your very flesh. Of course, it just looks like a fancy hunk of stone, but there\'s no harm in being careful. %employer% should be happy to see it and he can hold it anyway he wants as far as you\'re concerned. | The artifact looks odd, but nothing too out of the ordinary. For all you know, it was some vagrant\'s project that someone else took for a godly object. %randombrother% stares at it.%SPEECH_ON%I\'ve shit prettier things than that, if I\'m being honest.%SPEECH_OFF%You warn him that if this relic really does have powers, he\'ll probably pay for that comment. He shrugs.%SPEECH_ON%Don\'t change the facts of the matter though.%SPEECH_OFF% | You raise the relic up and it suddenly weighs heavy, bringing it back down. When you lower it toward your feet, it gets lighter, as if wishing to be picked back up. This is weird enough for you and so you quickly stow it away and prepare a return to %employer% in %townname%. | Finally, you got the artifact. You\'re staring at it when %randombrother% approaches.%SPEECH_ON%So, that\'s what %employer% wants? Hell, I could\'ve crafted something like that and saved us all this trouble.%SPEECH_OFF%You stow the artifact into a sack and respond.%SPEECH_ON%I think he\'d know it was a fake eventually.%SPEECH_OFF%The mercenary raises his finger.%SPEECH_ON%Keyword: eventually.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We have what we came here for. Time to head back!",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.setState("Return");
			}

		});
		this.m.Screens.push({
			ID = "AlmostLost",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_42.png[/img]{While marching along, %historian% the historian sees you staring at the map. He asks to have a look which you allow. The man holds it out, then brings it close.%SPEECH_ON%We\'re going the wrong way. %employer%\'s scribes must have read this wrong. See this symbol? It actually means...%SPEECH_OFF%He pauses, seeing that whatever he\'s about to say will not make sense to you. He laughs.%SPEECH_ON%Alright, basically we need to go this way.%SPEECH_OFF%He takes out a quill pen and makes a correction. | %historian% the historian is looking at one of the maps %employer% gave you. He pauses and asks.%SPEECH_ON%You said the nobleman\'s scribes created this map? Because it\'s all wrong. Look.%SPEECH_OFF%He shows it to you.%SPEECH_ON%They misread the languages. This isn\'t an alphabet, but symbols of faith. These aren\'t words, but puzzles. And if you interpret them right, they lead you here.%SPEECH_OFF%He points to an entirely different spot than where you were heading. It appears the %companyname% needs to correct its course. | %historian% the historian is shaking his head as he pores over a map.%SPEECH_ON%Sir, we\'re going the wrong way. %employer%\'s scribes misread the symbols here. We need to change directions.%SPEECH_OFF%You think to question the man\'s assumptions, but you\'d sooner believe a hardy historian who rides with the %companyname% than some old fart cooked up in a nobleman\'s tower. | %historian% takes the map %employer% had given you and looks it over.%SPEECH_ON%Yeah, no, we\'re heading the wrong way. See this? The alphabet here goes up and down, to right to left. It\'s a puzzle of words, one which the nobleman\'s scribes incorrectly thought they had solved.%SPEECH_OFF%You ask if that means you are heading the wrong way. %historian% nods.%SPEECH_ON%Yup. Good thing I was here, right?%SPEECH_OFF% | You look at the map %employer% gave you. It\'s full of loopy symbols you don\'t understand as if someone doodled out an entire language. %historian% the historian walks over, eating his lunch. He speaks betweenc chomps.%SPEECH_ON%Map\'s wrong.%SPEECH_OFF%You wipe the crumbs off the map and ask what he means. He laughs.%SPEECH_ON%I mean the map\'s wrong. %employer%\'s scribes had no idea what they\'re looking at. See that rock formation down there? That\'s where we need to be going. This is good, by the way, you want some?%SPEECH_OFF%He offers a bite, but you turn it down.%SPEECH_ON%Your loss. Should I go tell the men we\'re changing directions?%SPEECH_OFF%You sigh and nod.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Useful knowledge to have.",
					function getResult()
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						local myTile = this.World.State.getPlayer().getTile();
						local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
						local lowestDistance = 9999;
						local best;

						foreach( b in undead )
						{
							if (b.isLocationType(this.Const.World.LocationType.Unique))
							{
								continue;
							}

							local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 25);

							if (d < lowestDistance)
							{
								lowestDistance = d;
								best = b;
							}
						}

						this.Contract.m.Destination = this.WeakTableRef(best);
						this.Flags.set("DestinationName", this.Contract.m.Destination.getName());
						this.Contract.m.Destination.setDiscovered(true);
						this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
						this.Contract.m.Destination.clearTroops();
						this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.getActiveState().start();
						this.World.Contracts.updateActiveContract();
						this.Contract.m.Dude = null;
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local candidates = [];

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.historian")
					{
						candidates.push(bro);
					}
				}

				this.Contract.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];
			}

		});
		this.m.Screens.push({
			ID = "Lost",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_42.png[/img]You arrive where you think you\'re supposed to be. Except... there\'s nothing here. You studiously look at the map and realize where you went wrong. Apparently, there are two rock formations shaped like a {man holding a sword | church being attacked by the old gods | giant potato with a face on it | beautiful, curvy woman | a dog walking a man | a bear reared up on its hind legs, striking down a small girl trying to eat soup from a bowl | a young man looking at the clouds, which are also shaped above it with a rock that looks like a bunny though %randombrother% states it must be a dog, only for you two to realize you were debating what a bunch of rock clouds looked like while they were being stared at by a rock cloud watcher}. You put a note on your map and head toward the real location, hoping that you haven\'t lost too much time for this little excursion gone astray.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Damnit!",
					function getResult()
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						local myTile = this.World.State.getPlayer().getTile();
						local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
						local lowestDistance = 9999;
						local best;

						foreach( b in undead )
						{
							if (b.isLocationType(this.Const.World.LocationType.Unique))
							{
								continue;
							}

							local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 25);

							if (d < lowestDistance)
							{
								lowestDistance = d;
								best = b;
							}
						}

						this.Contract.m.Destination = this.WeakTableRef(best);
						this.Flags.set("DestinationName", this.Contract.m.Destination.getName());
						this.Contract.m.Destination.setDiscovered(true);
						this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
						this.Contract.m.Destination.clearTroops();
						this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						this.Contract.m.Destination.setLootScaleBasedOnResources(130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

						if (this.Contract.getDifficultyMult() <= 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
						{
							this.Contract.m.Destination.getLoot().clear();
						}

						this.Contract.getActiveState().start();
						this.World.Contracts.updateActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "TooLate1",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_57.png[/img]As you step into a room expecting to find the relic, all you see is an empty pedestal with a note there. It reads:%SPEECH_ON%{Looks like your lackeys are late again, %employer%. Remember when you used to work with me? This is what you get! | Ah-ha! Yes, I wrote that, for that is what I exclaimed when I saw that I, once again, was one step ahead of you %employer%! A shame you went the cheap route and hired a bunch of nobody-mercenaries. Better luck next time. | If you\'re reading this, you\'re too slow and %employer% was mistaken to hire you over me. Alas, I have the relic. Now drag yourselves back to your employer and explain how you lost. | If you\'re reading this, then you\'re probably that group of mercenaries %employer% decided to hire over me. Look how wrong he was! And look at how slow you are! You\'re probably so hard in the head you can\'t even read this. | Hello mercenary, it\'s a shame I couldn\'t be there to see your face when you started reading this. Oh well, we can\'t always get what we want. The fact the relic is in my hands and not yours should sufficiently drive this point home. Better luck next time, losers, and send %employer% my regards.}%SPEECH_OFF%At the bottom, it\'s signed \'%nemesis%\'.\n\n You\'re not sure who the hell that is, but he\'s a walking dead man now. A scattering of footprints give a hint as to where this arse went.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "An unexpected twist!",
					function getResult()
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
						local playerTile = this.World.State.getPlayer().getTile();
						local camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getNearestSettlement(playerTile);
						local tile = this.Contract.getTileToSpawnLocation(playerTile, 8, 14);
						local party = this.World.FactionManager.getFaction(camp.getFaction()).spawnEntity(tile, this.Flags.get("NemesisNameC"), false, this.Const.World.Spawn.Mercenaries, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
						party.setFootprintType(this.Const.World.FootprintsType.Mercenaries);
						local n = 0;

						do
						{
							n = this.Math.rand(1, this.Const.PlayerBanners.len());
						}
						while (n == this.World.Assets.getBannerID());

						party.getSprite("banner").setBrush(this.Const.PlayerBanners[n - 1]);
						this.Flags.set("NemesisBanner", n);
						this.Contract.m.UnitsSpawned.push(party);
						party.getLoot().Money = this.Math.rand(50, 100);
						party.getLoot().ArmorParts = this.Math.rand(0, 10);
						party.getLoot().Medicine = this.Math.rand(0, 2);
						party.getLoot().Ammo = this.Math.rand(0, 20);
						local r = this.Math.rand(1, 6);

						if (r == 1)
						{
							party.addToInventory("supplies/bread_item");
						}
						else if (r == 2)
						{
							party.addToInventory("supplies/roots_and_berries_item");
						}
						else if (r == 3)
						{
							party.addToInventory("supplies/dried_fruits_item");
						}
						else if (r == 4)
						{
							party.addToInventory("supplies/ground_grains_item");
						}
						else if (r == 5)
						{
							party.addToInventory("supplies/pickled_mushrooms_item");
						}

						this.Contract.m.Destination = this.WeakTableRef(party);
						party.setAttackableByAI(false);
						party.setFootprintSizeOverride(0.75);
						local c = party.getController();
						c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
						local roam = this.new("scripts/ai/world/orders/roam_order");
						roam.setPivot(camp);
						roam.setMinRange(5);
						roam.setMaxRange(10);
						roam.setAllTerrainAvailable();
						roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
						roam.setTerrain(this.Const.World.TerrainType.Shore, false);
						roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
						c.addOrder(roam);
						this.Const.World.Common.addFootprintsFromTo(playerTile, this.Contract.m.Destination.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Mercenaries, 0.75);
						this.Contract.setState("Running_TooLate");
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "TooLate2",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{Following their footprints, you manage to catchup with %nemesis% and his men. You know it\'s them because the biggest arse of the group is holding the relic. It appears the man can back up his insults: he is surrounded by a well-armed group of fighters. You should be careful in how you approach. | %nemesisC% wasn\'t as hard to find as his gaudy, insulting message might have made him out to be. But if nothing else, he is very well guarded. A retinue of armed and armored men surround the arsehole as he stares greedily at the relic in his hands. To get that artifact, the %companyname% should think out how best to approach this situation. | You find a man staring at the relic you were after. It must be %nemesis%! Just as you are about to jump out and kill him yourself, %randombrother% grabs you by the shirt and pulls you back down. He points ahead and there appear a retinue of well-armed guards. The %companyname% should approach this situation carefully. | The footprints weren\'t hard to follow. You initially thought it was because this %nemesisS% fellow was an idiot, but as it turns out he\'s just very well guarded. You find him holding the relic and being utterly surrounded by a detail of well-armed guards. Violence was what you came here for, but perhaps there is another way? | You find %nemesis% holding the relic. He\'s an easy enough-looking target who has left footprints galore, either out of ignorance or misplaced confidence. As you draw your sword, %randombrother% stays your hand. He nods forward.\n\n You watch as a group of men approach %nemesis% and ask for orders. They\'re his guards, and they are very well armed. Getting the artifact back might require more bloodshed than you thought.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "You made a terrible mistake, challenging the %companyname%. Your last one.",
					function getResult()
					{
						this.Contract.getActiveState().onCombatWithNemesis(this.Contract.m.Destination, false);
						return 0;
					}

				},
				{
					Text = "No one needs to die here. The artifact in exchange for %bribe% crowns, what say you?",
					function getResult()
					{
						return this.Math.rand(1, 100) <= 50 ? "TooLateBribeRefused" : "TooLateBribeAccepted";
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "TooLate3",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_11.png[/img]{Finally, you got the artifact. Its weight seems off in your hands, as though it should be heavy, but there\'s something keeping it artificially light. You sack it up and get ready to head back to %employer%. | You now have the artifact which you\'ve been seeking. If you\'re being honest, it\'s a bit of a disappointment. A part of you was hoping it\'d give you immense power, but instead it idly sits in your hands. Perhaps you just weren\'t the chosen one. | You take the artifact, ignoring the muted hum it is giving off, and ready a return to %employer%. | You take the artifact and get a good look at it. %randombrother% walks up and puts his fists to his hips.%SPEECH_ON%Hell, that ugly thing ain\'t that precious.%SPEECH_OFF% | You weigh the artifact in your hands. It goes from light to heavy and back again. Well, that\'s weird enough and so you quickly shove it into a satchel. | %randombrother% takes a look at the artifact before you stow it away.%SPEECH_ON%Doesn\'t look like much.%SPEECH_OFF%You tell him a lot of things that are of power don\'t look like much. He sits there and thinks.%SPEECH_ON%My farts don\'t look like nothing at all, so I guess yer right.%SPEECH_OFF% | You give the artifact to %randombrother%. He holds it up.%SPEECH_ON%What if I smashed it right here and now, would you be mad?%SPEECH_OFF%You glare at the man.%SPEECH_ON%Yeah, a little. But maybe there are little demons in there that\'ll fark you for eternity for breaking their home. Who knows, right?%SPEECH_OFF%The mercenary quickly puts the artifact into a satchel. | You look at the artifact. It is blank and unmoving, not something you\'d expect to hold great power, but for some reason that\'s the most unsettling part. You quickly put it into a satchel. | You put the artifact into a satchel only for it to glow and call out to you. Opening the sack, you look down at two red dots staring back up at you. %randombrother% asks if you\'re alright. You quickly snap the satchel closed and nod. | You finally have the artifact. It doesn\'t glow, it doesn\'t hum, it doesn\'t even look all that pretty. You\'re not sure what the big fuss was about, but if %employer% wants to pay you for it that\'s his concern. | Well, you got the artifact. %randombrother% walks over, scratching his head.%SPEECH_ON%So a lotta people died for that little thing?%SPEECH_OFF%The artifact rattles and a growling voice answers.%SPEECH_ON%They didn\'t die. They\'re with me now and forever.%SPEECH_OFF%The mercenary jumps back.%SPEECH_ON%You know what? I didn\'t hear that. I don\'t know what that was. I don\'t care. Nope. Just gonna go back to eating hard, stale bread and living a boring life thank you very much.%SPEECH_OFF% | You hold the artifact, using a cloth between it and you lest its powers seep into your very flesh. Of course, it just looks like a fancy hunk of stone, but there\'s no harm in being careful. %employer% should be happy to see it and he can hold it anyway he wants as far as you\'re concerned. | The artifact looks odd, but nothing too out of the ordinary. For all you know, it was some vagrant\'s project that someone else took for a godly object. %randombrother% stares at it.%SPEECH_ON%I\'ve shit prettier things than that, if I\'m being honest.%SPEECH_OFF%You warn him that if this relic really does have powers, he\'ll probably pay for that comment. He shrugs.%SPEECH_ON%Don\'t change the facts of the matter though.%SPEECH_OFF% | You raise the relic up and it suddenly weighs heavy, bringing it back down. When you lower it toward your feet, it gets lighter, as if wishing to be picked back up. This is weird enough for you and so you quickly stow it away and prepare a return to %employer%. | Finally, you got the artifact. You\'re staring at it when %randombrother% approaches.%SPEECH_ON%So, that\'s what %employer% wants? Hell, I could\'ve crafted something like that and saved us all this trouble.%SPEECH_OFF%You stow the artifact into a sack and respond.%SPEECH_ON%I think he\'d know it was a fake eventually.%SPEECH_OFF%The mercenary raises his finger.%SPEECH_ON%Keyword: eventually.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We have we what we came here for. Time to head back!",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "TooLateBribeRefused",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{The leader of the thieves laughs and shakes his head.%SPEECH_ON%Did you seriously just... I mean, really?%SPEECH_OFF%He steps forward and continues.%SPEECH_ON%That was worth a try, I suppose, but the answer is no.%SPEECH_OFF%Slowly, he draws out his blade. The metal shimmers as he levels it toward you.%SPEECH_ON%A firm no.%SPEECH_OFF% | Your attempt at bribery was not accepted. Not only did the thieves decline, they took offense and are attacking! Apparently, there is some honor among these thieves! | The head of the thieves scoffs.%SPEECH_ON%A bribe? No. We did not come this far and suffered what we have suffered just to make a petty exchange. Hey men, what say you it is their time to suffer?%SPEECH_OFF%Cheering, the group of vandals draw out their weapons. Their leader points a blade toward the %companyname%.%SPEECH_ON%Prepare to die, mercenaries.%SPEECH_OFF% | You offer the bribe and it\'s quickly declined. The vandals\' leader and yourself nod. One thing is understood: neither one of you is going back emptyhanded. Prepare for battle! | The brigands make a huddle and talk it through hushed whispers. Finally, the leader comes out, hands to his hips and chest boastfully puffed outward. He shakes his head.%SPEECH_ON%We respectfully decline the offer. Now, let us pass, or prepare for battle.%SPEECH_OFF%%employer% isn\'t paying you to come back emptyhanded. You order the %companyname% into formation. The brigand sighs and draws out his sword.%SPEECH_ON%So be it!%SPEECH_OFF% | The vandals laugh at your offer. It appears they also interpreted as a sign of weakness for they are all taking out their weapons. You thought the offer was very fair, but it looks like these men wish to sell the item at the ultimate price. So be it. Prepare for battle! | The leader of the thieves laughs.%SPEECH_ON%An interesting offer, but no. I think we both know this little artifact is worth more than that, and certainly worth more than anything else you can offer. Now move out of the way.%SPEECH_OFF%The %companyname% falls into formation, drawing weapons. %randombrother% spits.%SPEECH_ON%We can kill them all, sir, just give the order.%SPEECH_OFF%You have the utmost faith in the %companyname% for it is a religion of exacting violence. Time to practice what we preach! | The head of the brigands reaches into a sack and takes out a head. It is luridly grey and twists by the hair taut between his fingers.%SPEECH_ON%This is what happened to the last men who stood in our way. Your offer is respectfully declined, mercenary. Now step out of our way or this here is where my niceties end.%SPEECH_OFF%You laugh and respond in turn.%SPEECH_ON%We are the %companyname%, and it is a shame nobody knows who you are for there will be nothing to boast after we kill you all to the last man.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To arms!",
					function getResult()
					{
						this.Contract.getActiveState().onCombatWithNemesis(this.Contract.m.Destination, false);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "TooLateBribeAccepted",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{After some discussion, the thieves agree to your offer. You hand over the crowns and they hand over the artifact. This was easier than expected. | The brigands talk amongst themselves, huddled together and occasionally looking out at you. It\'s a strange ordeal, considering that in a few minutes you all could be killing one another based on what they decide. Finally, they break the huddle and the leader waves you over.%SPEECH_ON%Our employer isn\'t going to be happy, but those crowns are hard to pass up. You have yourself a deal, sellsword.%SPEECH_OFF% | The vandals argue over your offer. Some say that their employer will be most unhappy if they come back emptyhanded while others state that this is not worth dying over. The latter party wins. You are handed the artifact in return for crowns. | An honorable party may have tried to fight the %companyname%, but you\'re dealing with thieves here, not men of the most honorable report. They agree to hand over the artifact for crowns. | The thieves\' leader draws out his sword.%SPEECH_ON%Do you seriously think we would ever accept that off...%SPEECH_OFF%A spurt of blood finishes the word and it splashes on the length of a blade suddenly protruding from his chest. The brigand\'s eyes roll back as his killer puts a boot on his back and kicks him off the sword. The killer cleans his weapon.%SPEECH_ON%We ain\'t dying for that sonuvabitch. Your offer is accepted, sellsword.%SPEECH_OFF% | An argument breaks out between the thieves. Some think they can take you on while others are a little more aware of who the %companyname% is and that latter party argues quite strongly against any hostilities. Finally, they come to an agreement: the bribe is accepted. | Your offer to pay for the artifact spurs quite the debate between the thieves. They argue in hushed tones, but their glancing stares seem to indicate they regard you as a most existential threat. Finally, they break their huddle and come to agree with your terms. You\'re happy that it did not come to bloodshed. | The thieves scoff.%SPEECH_ON%Do you think we can go back to our benefactors emptyhanded?%SPEECH_OFF%You run a hand through your hair and respond.%SPEECH_ON%Beats not coming back at all, doesn\'t it?%SPEECH_OFF%Each thief warily takes a step back. Their leader shakes his head then nods all in one swift go.%SPEECH_ON%Hell, sellsword, you put us in a bind here. But alright, we\'ll accept.%SPEECH_OFF%The artifact is handed over and violence avoided. | The leader of the thieves turns to his band and asks earnestly.%SPEECH_ON%What say you, men, think we can take them?%SPEECH_OFF%One shrugs.%SPEECH_ON%I think we can take that gold they be offerin\'.%SPEECH_OFF%Another one pipes in.%SPEECH_ON%This was to be an expedition, we ain\'t paid well enough to die over the damned artifact.%SPEECH_OFF%Slowly, the brigands come to agreement: they\'ll take the bribe rather than be slaughtered. Smart move by most metrics.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "You made the right decision.",
					function getResult()
					{
						this.Contract.m.Destination.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
						return "TooLate3";
					}

				}
			],
			function start()
			{
				local bribe = this.Contract.beautifyNumber(this.Contract.m.Payment.Pool * 0.4);
				this.World.Assets.addMoney(-bribe);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + bribe + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Trap",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_12.png[/img]{You step over a tripwire and tell %hurtbro% to be careful. He doesn\'t and eats a trapmaker\'s machinations for his carelessness. | The floor of the ruins is lined with obvious traps and deadly gadgets. You manage to go through the lot of them without issue until %hurtbro%, thinking himself in the clear, suddenly rushes ahead. Ancient machinery is triggered and you think the whole place is about to collapse on your heads. Luckily, only the mercenary pays for his lack of discretion. | The ruins are rigged with traps and %hurtbro% manages to set one off. | %hurtbro%\'s foot falls on a brick that quickly depresses into the floor. Ancient machinery rumbles behind the walls and the ceiling begins to crumble. Despite all the noise, the trap itself is quite small and the sellsword will live. | Glyphs on the wall spell out ancient ruminations through the use of pictures. Unfortunately, the stick figures are so poorly drawn you don\'t realize they\'re actually warning signs until it\'s too late: %hurtbro% wanders into a trap and eats a lot of trouble for your poor translating skills. | You should have known better: the ruins are lined with traps and %hurtbro% walks right into one. He\'ll survive and you\'ll be safer from now on. | %hurtbro% sets off a trap and eats a lot of painful trouble for his lack of caution. | Many, many years ago, a man sat down to make a trap. Today, %hurtbro% walks right into it. | You set off a tripwire and hear the walls come alive with ancient machinery. Ducking, you think yourself in the clear only to turn around and see %hurtbro% has eaten the brunt of the trap\'s damage. Whoops... | You see a tripwire on the ground and laugh. So close, ancient trapmaker, so very close - suddenly, %hurtbro% walks right by you and triggers the trap. The idiot will live, but there is a lot of pain in his future. | %hurtbro%\'s whistling and the tune carries deep into the ruins, but the echo seems rather off, like it\'s hiccupping somewhere in the walls. You tell the men to hold their ground, but the whistler walks on ahead and promptly falls through the floor into a pit. Rushing to the edge, you see that he just managed to avoid some spikes. | While walking through the ruins, %hurtbro% sets off a trap which sends him plummeting through the floor. He lands on a lower floor dotted with holes. Spikes emerge, but slowly enough for the man to get out of the way. Thankfully, the trap didn\'t trigger in the right order and you manage to get the sellsword out of there. | While winding through the confusing ruins, %hurtbro% suddenly drops out of view. You rush to where he was to almost fall into the same trap: a pit in the ground littered with the crunchy molts of snakeskin. Thankfully, the critters are no longer around, but the fall itself was enough to put the hurt on the poor mercenary.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Be more careful!",
					function getResult()
					{
						this.Contract.m.Dude = null;
						return "SearchingTheRuins";
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local bro = brothers[this.Math.rand(0, brothers.len() - 1)];
				local injury = bro.addInjury(this.Const.Injury.Accident1);
				this.Contract.m.Dude = bro;
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = bro.getName() + " suffers " + injury.getNameOnly()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "ScavengerHunt",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_57.png[/img]{You find a map in the ruins that seems to suggest the relic is actually located at ruins called %objective% somewhere %direction% from here. | Unfortunately, the relic is not here. Some investigating reveals that you have made a mistake coming here: what you\'re looking for is actually in %objective% just %direction% of here. | Well, you came to the wrong area. You and the men do their best to decipher the languages on the wall and compare them to what you have on your map. With time, you figure out that the artifact you\'re looking for is most likely located in a place called %objective% just %direction% of here. | %randombrother% brings you the map and he\'s cursing under his breath.%SPEECH_ON%I think we came to the wrong spot, sir. Look at this.%SPEECH_OFF%Together, you figure out that the artifact is most likely located in some ruins %direction% of here in a place called %objective%. | You were hoping to find the artifact in one go, but that won\'t be happening. Through careful investigation, the company slowly finds out it has some to the wrong place. It needs to go to %objective% %direction% of here. | The ruins are the wrong ones. Some signage on the walls and the distinct lack of the artifact tell you as much. Through careful speculations, you figure the relic is actually in %objective% %direction% of here. | Clambering through the ruins and finding nothing of value, you slowly figure out that you\'ve come to the wrong ones. You and %randombrother% study the map for awhile before judging that the artifact is actually in a place called %objective% just %direction% of here. | %randombrother% finds a man impaled on a couple of trap-triggered spikes. He\'s got a map in his bony, decaying grip. You read the map and realize that, just like this man did, you came to the wrong set of ruins. The artifact is actually in %objective% %direction% of here. Good thing this trepid explorer got here before you did! | A corpse is founded huddled at a pair of steps leading to an empty podium. You think this is where the relic was supposed to be, but it\'s gone. The dead man doesn\'t seem to have it. %randombrother% picks through the body\'s clothes to find a folded map. It leads to a place called %objective% somewhere %direction% of here.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Get ready to move on, men!",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Destination = null;
				local myTile = this.World.State.getPlayer().getTile();
				local undead = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
				local lowestDistance = 9999;
				local best;

				foreach( b in undead )
				{
					if (b.isLocationType(this.Const.World.LocationType.Unique))
					{
						continue;
					}

					local d = myTile.getDistanceTo(b.getTile()) + this.Math.rand(0, 35);

					if (d < lowestDistance)
					{
						lowestDistance = d;
						best = b;
					}
				}

				this.Contract.m.Destination = this.WeakTableRef(best);
				this.Flags.set("DestinationName", this.Contract.m.Destination.getName());
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.UndeadArmy, 120 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.getActiveState().start();
				this.World.Contracts.updateActiveContract();
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer%\'s door is open and you walk in. He turns to look at you with a long gaze and a \'well?\' stare. You produce the artifact and hold it out. The nobleman jumps to his feet with unhinted energy.%SPEECH_ON%You have it! By the old gods! Lemme have it!%SPEECH_OFF%The artifact is handed over and %employer%\'s eyes widen. You inquire about your pay, but he\'s already in another world, as if he\'s been sucked into the artifact itself. One of his scribes steps forward out from the shadows of a corner. He hands you a satchel of %reward_completion% crowns.%SPEECH_ON%Please excuse us, mercenary. My liege and I have duties to attend to.%SPEECH_OFF% | %employer% is deep in a chair and perhaps even deeper in his thoughts. One of his guards has to tell him that you\'re there, repeating himself three times until the nobleman looks up. He stares at you, then at the artifact. His body rises from the chair as though it were animated by the impetuous of some unseen force. He takes the artifact and wheels around, rushing to his desk where he sets it down and squats before it, practically prostrating himself, observing it with atavistic fervor. The guard hands you a satchel of %reward_completion% crowns.%SPEECH_ON%You\'d best leave, sellsword.%SPEECH_OFF% | A scribe of %employer%\'s welcomes you outside the nobleman\'s room. He\'s got moldy book breath and a hurriedness about his mannerisms.%SPEECH_ON%Is that the artifact? Is it?%SPEECH_OFF%You hand over a bag with the relic in it. The scribe\'s fingers clasp at the draw strings like beaks plucking at worms.%SPEECH_ON%Give it! Give! Here, take your money and go!%SPEECH_OFF%He slams a satchel of %reward_completion% crowns into your hands before ducking into %employer%\'s room. | A couple of scribes wait inside %employer%\'s room. The nobleman himself is asleep in his bed, head facing the ceiling, his arms at his side like some half-finished mannequin. One of the scribes steps forward.%SPEECH_ON%The relic, hand it over.%SPEECH_OFF%This is very off, but you sure as hell won\'t waken a sleeping lord. You inquire about pay. Another scribe throws you a sack of %reward_completion% crowns, the bag sliding across the stone floor.%SPEECH_ON%Now put the relic on the ground and leave.%SPEECH_OFF%You take your money and go. | You find %employer% humoring a crowd of nobility. Spying you over their heads, he hurries through his jokes before bidding adieu. He slides around the room to greet you with whispers.%SPEECH_ON%Do you have the relic?%SPEECH_OFF%You hand it over and the man grins. He gives you a sack of %reward_completion% crowns.%SPEECH_ON%Good job, sellsword, but you should go. This isn\'t your crowd. Not that it is mine, either.%SPEECH_OFF%He winks and shoos you off. | A scribe intercepts you outside %employer%\'s room. He puts a finger to his lips and shakes his head before guiding you further down the hall. Stepping before a brazier, the elder quickly glances around before pulling down on the torch.%SPEECH_ON%Push the wall, sellsword.%SPEECH_OFF%You do as told. A slab of it isn\'t stone at all, but wood. It slides open and you step through. %employer% is there with a host of books and strange items littered about a dusky, candlelit room. He snaps his fingers and you hand the artifact over. In return, you receive a satchel of %reward_completion% crowns. The nobleman pauses, then looks at his scribe.%SPEECH_ON%Wait, this place was supposed to be secret, what the hell are you doing?%SPEECH_OFF%The old man awkwardly purses his lips. The noble pinches his forehead.%SPEECH_ON%Goddammit. Alright, call up the mason again, I guess.%SPEECH_OFF% | You find %employer% and hand the artifact over. He gives you a satchel of %reward_completion% crowns and just like that the transaction is complete. Well, that was anticlimactic. | %employer% is standing beside a few of his commanders. They look at you as you come in and the nobleman puts his hand out across his desk. You slowly walk forward and put the relic in his palm. He takes it, turns it, stares at it, then glances at you. He snaps his fingers.%SPEECH_ON%Pay the sellsword his money.%SPEECH_OFF%One of the commanders hands you a satchel of %reward_completion% crowns and you are soon ushered out of the room. | A man that looks an awful lot like %employer% awaits you in the nobleman\'s room. He asks you to hand over the relic and you do as told. The man pauses, holding it, his eyes darting around. Finally, he puts it on the ground and calls out.%SPEECH_ON%Seems alright!%SPEECH_OFF%Suddenly, the real %employer% appears from the side of the room, cautiously stepping forward.%SPEECH_ON%Sorry for the theatrics, but there are powers here that you can\'t understand.%SPEECH_OFF%You doubt an artifact could come to life as a would-be assassin, but you won\'t question the nobleman\'s clearly insane thought processes. You accept your %reward_completion% crowns and happily depart. | %employer% meets you outside his room. His face is red and sweaty and he seems to almost be guarding the door.%SPEECH_ON%Evening, sellsword. Do you have what was asked of you?%SPEECH_OFF%You hand the relic over. The man grins and gives you a satchel of %reward_completion% crowns. He turns to go back into his room, then pauses.%SPEECH_ON%Hey, go. I\'m not paying you to stand around and watch what I do.%SPEECH_OFF%You nod and depart. As you leave, you hear the door open and a rush of womanly noises slip through in a quick rush before it closes again. | One of %employer%\'s guards takes you to the gardens where the nobleman is tending to his crops. He\'s teaching a young boy to clip tomatoes.%SPEECH_ON%The stem, you idiot! Clip this, see? Why would you ever stab the food? Never stab the food! Sellsword!%SPEECH_OFF%The lord bolts upright at the sight of you. He pushes the boy out of the way and comes over asking if you have the relic. You hand it over and receive %reward_completion% crowns in return. The nobleman nods.%SPEECH_ON%You\'ve done well, mercenary. I\'m losing faith in individuals\' abilities to do what I ask of them. I\'m sure you understand.%SPEECH_OFF%Over the nobleman\'s shoulders you see the boy assassinating another plant. You slowly nod. | You hand the relic over to %employer%. He stares at it with scrunched eyebrows, angrily rolling his fingers along his desk.%SPEECH_ON%Hmm, I guess that\'s it. A little disappointing, but an agreement is an agreement.%SPEECH_OFF%He begrudgingly slides a sack of %reward_completion% crowns over to you. | %employer% welcomes you into his room, offering you a goblet of wine. You drink as a scribe comes over and takes the relic. He goes to the side of the room and begins measuring, weighing, and even... tasting it? You ignore whatever calculations are going on there and inquire about your pay. %employer% grins.%SPEECH_ON%You\'re drinking it!%SPEECH_OFF%You pause with the goblet on your lips. The nobleman laughs.%SPEECH_ON%A joke, sellsword, relax! Here, %reward_completion% crowns as we agreed upon.%SPEECH_OFF% | You open the door to %employer%\'s room to find the nobleman and a few scribes standing before a table. Oddly shaped vials and flasks are all over the place, some filled with even stranger colors. One of the scribes hurries over to you and shoots his hand out from overly big, loose sleeves, like snakes stabbing out of a cave. He steals the relic away with one hand while the other slams a sack of %reward_completion% crowns into your chest. %employer% waves you off.%SPEECH_ON%Leave, mercenary, you\'ve done as much as we have asked and that is as far as your services are required for now.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "Procured an artifact important for the war effort");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCriticalContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hurtbro",
			this.m.Dude == null ? "" : this.m.Dude.getName()
		]);
		_vars.push([
			"historian",
			this.m.Dude == null ? "" : this.m.Dude.getNameOnly()
		]);
		_vars.push([
			"objective",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"nemesis",
			this.m.Flags.get("NemesisName")
		]);
		_vars.push([
			"nemesisS",
			this.m.Flags.get("NemesisNameS")
		]);
		_vars.push([
			"nemesisC",
			this.m.Flags.get("NemesisNameC")
		]);
		_vars.push([
			"bribe",
			this.beautifyNumber(this.m.Payment.Pool * 0.4)
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});

