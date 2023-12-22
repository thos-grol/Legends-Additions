this.last_stand_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		local r = ::Math.rand(1, 100);

		if (r <= 70)
		{
			this.m.DifficultyMult = ::Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = ::Math.rand(115, 135) * 0.01;
		}

		this.m.Type = "contract.last_stand";
		this.m.Name = "Defend Settlement";
		this.m.Description = "Scouts report undead hoards heading straight for a nearby city. Get over there and defend the city.";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		this.m.Flags.set("ObjectiveName", this.m.Origin.getName());
		this.m.Name = "Defend " + this.m.Origin.getName();
		this.m.Payment.Pool = ::Z.Economy.Contracts[this.m.Type];

		if (::Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Travel to %objective% in the %direction%",
					"Defend against the undead"
				];

				if (::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance)
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
				local r = ::Math.rand(1, 100);

				if (r <= 40)
				{
					this.Flags.set("IsUndeadAtTheWalls", true);
				}
				else if (r <= 70)
				{
					this.Flags.set("IsGhouls", true);
				}

				this.Flags.set("Wave", 0);
				this.Flags.set("Militia", 7);
				this.Flags.set("MilitiaStart", 7);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}
			}

			function update()
			{
				if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}
				else if (this.Contract.isPlayerNear(this.Contract.m.Origin, 600) && this.Flags.get("IsUndeadAtTheWalls") && !this.Flags.get("IsUndeadAtTheWallsShown"))
				{
					this.Flags.set("IsUndeadAtTheWallsShown", true);
					this.Contract.setScreen("UndeadAtTheWalls");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.isPlayerAt(this.Contract.m.Origin) && this.Contract.m.UnitsSpawned.len() == 0)
				{
					this.Contract.setScreen("ADireSituation");
					this.World.Contracts.showActiveContract();
				}
			}

		});
		this.m.States.push({
			ID = "Running_Wait",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Defend %objective% against the undead"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}
			}

			function update()
			{
				if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Contract.m.UnitsSpawned.len() != 0)
				{
					local contact = false;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local e = this.World.getEntityByID(id);

						if (e.isDiscovered())
						{
							contact = true;
							break;
						}
					}

					if (contact)
					{
						if (this.Flags.get("Wave") == 1)
						{
							this.Contract.setScreen("Wave1");
						}
						else if (this.Flags.get("Wave") == 2)
						{
							this.Contract.setScreen("Wave2");
						}
						else if (this.Flags.get("IsGhouls"))
						{
							this.Contract.setScreen("Ghouls");
						}
						else if (this.Flags.get("Wave") == 3)
						{
							this.Contract.setScreen("Wave3");
						}

						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.Flags.get("TimeWaveHits") <= this.Time.getVirtualTimeF())
				{
					if (this.Flags.get("IsGhouls") && this.Flags.get("Wave") == 3)
					{
						this.Flags.set("IsGhouls", false);
						this.Flags.set("Wave", 2);
						this.Contract.spawnGhouls();
					}
					else
					{
						this.Contract.spawnWave();
					}
				}
			}

		});
		this.m.States.push({
			ID = "Running_Wave",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Defend %objective% against the undead"
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = true;
					this.Contract.m.Origin.setLastSpawnTimeToNow();
				}

				foreach( id in this.Contract.m.UnitsSpawned )
				{
					local e = this.World.getEntityByID(id);

					if (e != null)
					{
						e.setOnCombatWithPlayerCallback(this.onCombatWithPlayer.bindenv(this));
					}
				}
			}

			function update()
			{
				if (this.Contract.m.Origin == null || this.Contract.m.Origin.isNull() || !this.Contract.m.Origin.isAlive())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
					return;
				}

				if (this.Contract.m.UnitsSpawned.len() == 0)
				{
					if (this.Flags.get("Wave") < 3)
					{
						local militia = this.Flags.get("MilitiaStart") - this.Flags.get("Militia");
						this.logInfo("militia losses: " + militia);

						if (militia >= 3)
						{
							this.Contract.setScreen("Militia1");
						}
						else if (militia >= 2)
						{
							this.Contract.setScreen("Militia2");
						}
						else
						{
							this.Contract.setScreen("Militia3");
						}
					}
					else
					{
						this.Contract.setScreen("TheAftermath");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatWithPlayer( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
				local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
				p.Music = ::Const.Music.UndeadTracks;
				p.CombatID = "ContractCombat";

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull() && this.World.State.getPlayer().getTile().getDistanceTo(this.Contract.m.Origin.getTile()) <= 4)
				{
					p.AllyBanners.push("banner_noble_11");

					for( local i = 0; i < this.Flags.get("Militia"); i = i )
					{
						local r = ::Math.rand(1, 100);

						if (r < 60)
						{
							p.Entities.push({
								ID = ::Const.EntityType.Militia,
								Variant = 0,
								Row = -1,
								Script = "scripts/entity/tactical/humans/militia",
								Faction = 2,
								Callback = null
							});
						}
						else if (r < 85)
						{
							p.Entities.push({
								ID = ::Const.EntityType.Militia,
								Variant = 0,
								Row = -1,
								Script = "scripts/entity/tactical/humans/militia_veteran",
								Faction = 2,
								Callback = null
							});
						}
						else
						{
							p.Entities.push({
								ID = ::Const.EntityType.Militia,
								Variant = 0,
								Row = 2,
								Script = "scripts/entity/tactical/humans/militia_ranged",
								Faction = 2,
								Callback = null
							});
						}

						i = ++i;
					}
				}

				this.World.Contracts.startScriptedCombat(p, this.Contract.m.IsPlayerAttacking, true, true);
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_combatID == "ContractCombat" && _actor.getFlags().has("militia"))
				{
					this.Flags.set("Militia", this.Flags.get("Militia") - 1);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];

				if (this.Contract.m.Origin != null && !this.Contract.m.Origin.isNull())
				{
					this.Contract.m.Origin.getSprite("selection").Visible = false;
				}

				this.Contract.m.Home.getSprite("selection").Visible = true;
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
		this.importScreens(::Const.Contracts.NegotiationDefault);
		this.importScreens(::Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_45.png[/img]{You find %employer% helping a young noble boy aim a bow downrange at a strawman. He straightens the kid\'s back and orders him to breathe deep before shooting. The amateur archer nods and does as told. The arrow is loosed. It wobbles, caroms off the ground, and rattles spinning into a stable where a few horses whinny at the scary disturbance. The nobleman claps the boy on the back.%SPEECH_ON%Trust me, I was worse on my first go. Keep at it. I\'ll be back in a moment.%SPEECH_OFF%The nobleman approaches you, shaking his head and lowering his voice.%SPEECH_ON%Things are dire, mercenary. The young know not of what dangers lurk these days, but you do. We have a settlement, %objective% just %direction% of here, that is surrounded by... well, the ills of this world. I\'ve no men to spare, but that\'s where you come in. Go there and save the village and you\'ll be paid very well, I can assure you!%SPEECH_OFF% | %employer% is found staring at one of his swords. He has it unsheathed, staring at his face in the steeled reflection.%SPEECH_ON%When I was taught how to use one of these, it was meant for men. Now? People speak of the dead, of greenskins, beasts beyond measure!%SPEECH_OFF%He slams the sword to the hilt and throws it and the scabbard on his table. He runs his hand through his hair.%SPEECH_ON%%objective% %direction% of here needs your help. It has been surrounded by these... these things! I know not what they are, only that they kill and kill and kill! I\'ve not a man to spare, but if you go there and help this town then you will be rewarded most handsomely!%SPEECH_OFF% | You find %employer% sitting between an abbot and a scribe who are yelling at each other in jowl-shaking, teeth-rattling old man voices. Given that the dead are arisen, questions of both mortality and life-after-death have become rather furiously debated. The nobleman sees you and jumps to his feet. He hurries to you, the argument raging in the background.%SPEECH_ON%Thank the old gods you are here, mercenary. Just %direction% of here, %objective% is under siege by an army of horribles. Undead, foul things, I don\'t know, I just know I don\'t have the men to protect the town myself. Go there and ensure those people are safe and I will pay you well!%SPEECH_OFF% | You find %employer% overseeing a group of sextons lowering a casket into the ground. The coffin is firmly nailed shut, almost hurriedly so: nails corkscrew and bend off the wood, and there are scrape marks along the sides. Seeing you, the nobleman comes over.%SPEECH_ON%The resident of said box decided to come back out. Killed a child and a dog. Almost killed another before the guards put it back down.%SPEECH_OFF%A splurge of black liquid gushes from the bottom of the coffin. The gravediggers jump away, dropping the crate right into its grave with a heavy clatter. %employer% shakes his head.%SPEECH_ON%With all these \'undead\' outbreaks, my forces have been spread thin. I\'ve just gotten word that %objective% just %direction% of here is another one to become under attack. Sellsword, would you go there and help save it?%SPEECH_OFF% | You find %employer% studying a crop of books scattered across his desk. He\'s shaking his head, every twist of the neck seemingly turning another page. Upset, he hurriedly waves you in.%SPEECH_ON%Don\'t dally, sellsword, we\'ve no time for that. I need you to go to %objective% %direction% of here. My birds tell me it\'s under assault, more of these damned \'dead\' come to life, if that\'s really the way to say it. Are you interested in going? The pay will more than compensate your efforts.%SPEECH_OFF% | You find %employer% watching over some masons putting sharply cut stones together. He shakes your hand.%SPEECH_ON%Building another monastery, sellsword, how does it look?%SPEECH_OFF%It looks good, but you point out that there is another abbey right across the road. The nobleman smirks.%SPEECH_ON%The dead are walking the earth again, there ain\'t enough pews around to sit the scared folk. Listen, I called you here because my forces are spread thin trying to handle this... oddity of undeath. There\'s a town just %direction% of here, %objective%, that desperately needs help. My birds tell me it\'s under attack and you seem just the man who\'d be interested in saving it. For a price, of course.%SPEECH_OFF% | %employer%, a treasurer, and a commander are talking. The treasurer says there\'s plenty of crowns, but the commander bluntly states that there are no men around with which to pay to fight. You, like the devil you are, enter the room and are immediately spoken of.%SPEECH_ON%Sellsword! Your services are needed immediately! We have a village %direction% of here, a little place called %objective%, that is under attack by these, er, what are they?%SPEECH_OFF%The commander leans toward the nobleman and whispers the answer. He rears back.%SPEECH_ON%Under attack by the... \'undead.\' Sure. Would you be willing to go there and protect those poor people?%SPEECH_OFF% | You eventually find %employer% out in his stables. He\'s putting a saddle on a horse and soon realizes that you\'re keeping your distance.%SPEECH_ON%Scared are we, sellsword?%SPEECH_OFF%Shrugging, you tell him you\'ve never cared for the beasts. The nobleman shrugs in return and mounts, swinging his legs over the cantle.%SPEECH_ON%Suit yourself. My birds have told me of %objective%\'s troubles, those troubles being a great horde of undead knocking on its doors and I don\'t think they\'re delivering milk to those townspeople. If you go there and help protect the village, there will be a stout satchel of pay waiting for you here on your return.%SPEECH_OFF% | %employer% is found walking the walls of his fortification. The guards around him are unusually shaped up, straight backed, dutiful eyes looking for danger. Seeing you, the nobleman waves you over. Together, you stare between the crenelations. The land spreads out before you, enormous forests turned into mere dots, mountains into arrowhead, birds arcing in thick formations.%SPEECH_ON%%direction% of here lies %objective%. Messengers told me that it is under attack by some unbelievable force, undead to be exact. Yes, that unbelievable. Whatever assails their walls, I have not the men to handle it. But you, sellsword, your services would be most appropriate here. Would you be interested?%SPEECH_OFF% | You find %employer% and a gaunt scribe staring at a headless corpse laid across a slab of stone. The head is in a corner, the eyeballs slanted, steel rods standing out of its half-carved skull. Seeing you, the nobleman offers an inviting hand.%SPEECH_ON%Nothing to fear, sellsword. As I\'m sure you\'ve heard, the dead are walking the earth again and with that comes a great deal of speculation as to why.%SPEECH_OFF%The scribe looks up, interrupting.%SPEECH_ON%Or how...%SPEECH_OFF%Smiling, the nobleman continues.%SPEECH_ON%Anyway, %objective% %direction% of here is being assaulted by these very monsters, er, former humans? But I\'ve not the men to send relief. You, however, are perfect for the job. Would you be willing to take it?%SPEECH_OFF% | %employer% is listening to the whispers of a scribe when you enter his room. The scribe glances at you with jaundiced eyes before continuing his talk. When he finishes, both men nod and the elder leaves. He doesn\'t so much as look at you as he goes. %employer% calls out.%SPEECH_ON%Glad you are here, sellsword! These are indeed dire times. My men are spread across the land handling all manner of monstrous evils. I\'m sure you have heard already, but the \'dead\', or whatever they are, walk again. And they\'re assaulting %objective% %direction% of here. With no men to spare, I depend upon your services, sellsword. Would you help save this town?%SPEECH_OFF% | %employer% is listening to the pleas of a group of peasants. You\'ve only arrived for the tail-end of the conversation as the nobleman angrily waves them off. As the laymen shout, guards close ranks to escort them out, peacefully for now, violently if they so wish. They go out the door without further protests, though one peasant glances at you and mouths \'help us\' before turning away. %employer% waves his hand.%SPEECH_ON%Well, hell, if it isn\'t the sellsword! Right on time, my money-grubbing friend. I\'ve a town %direction% of here, %objective%, which is in dire need of help. It is currently, so they say anyway, under siege by the undead. There\'s a large satchel of crowns waiting for you here if you go there and help defend it. What do you say, hm?%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{How much is this worth to you? | We can defend %objective% for the right price...}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This isn\'t worth it. | I\'m afraid %objective% is on their own.}",
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
			ID = "UndeadAtTheWalls",
			Title = "At %objective%...",
			Text = "[img]gfx/ui/events/event_29.png[/img]{Approaching %objective%, %randombrother% suddenly calls out from his lead point.%SPEECH_ON%Sir, hurry!%SPEECH_OFF%You rush over to him and look ahead. The town is absolutely surrounded by a pale sea of bobbing, moaning undead! The %companyname% will have to cut through them if it is to get inside. | A man jogs toward the %companyname%. He\'s holding one of his arms and a crown of crimson runs down his head. He yells out.%SPEECH_ON%Go, go away! There\'s nothing for you here but horrors!%SPEECH_OFF%%randombrother% throws the stranger to the ground and draws a weapon to keep him there. You stay the mercenary\'s hand as you look ahead: %objective% is already surrounded by a large number of undead. The %companyname% needs to act fast! | You\'ve arrived just in time: the walls of %objective% are already under assault by the undead! | Rounding a pathway, you\'re brought to a sudden stop. Ahead of you, %objective% is surrounded by a crowd of undead. Nearer to you, a few linger, oddly stranded from the horde. The %companyname% will need to fight its way into %objective%! | The walls of %objective% are strangely grey - wait, that\'s not the wood, it\'s the undead! To your horror, the pale monsters are already attacking, but you\'ve time yet to save %objective% and fight your way in. Drawing out your sword, you command the %companyname% to battle! | A shapeless formation of undead are already idling outside of %objective%\'s walls. You can see the heads of defenders peeking over the defenses, trying hard to not give themselves away. Drawing your sword, you tell the %companyname% that they will have to fight their way into the town. | A few undead are already at the gates of %objective%! Guards atop the gatehouse wave at you, put a finger to their lips, then point down. It appears the ghoulish monsters are yet attacking because they\'re unaware? You\'re not sure, you just know that the %companyname% only has one way in and that will be by the sword! | Luckily, you find %objective% still standing. Unluckily, the walls are being battered by a crowd of pale undead. The %companyname% will have to fight its way in!}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To arms!",
					function getResult()
					{
						this.Contract.spawnUndeadAtTheWalls();
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ADireSituation",
			Title = "At %objective%...",
			Text = "[img]gfx/ui/events/event_79.png[/img]{You find the guards inside %objective% looking like they hadn\'t slept in weeks, but they are smiling. Apparently, your awkward trip through to their front gate was of at least some amusement. | Bumbling and trundling as they are, the %companyname% finally passes through the front gate. Inside, the guards are standing with amused despondence, looking like they just stepped out of a horrific battle to be witnesses to a strange joke. One claps you on the shoulder.%SPEECH_ON%That was awfully funny to watch, mercenary, and my men needed the lift. Thank you.%SPEECH_OFF% | Taking a look around, you see the guards are frail, bony men standing watch over townspeople who look almost half-dead already. The muddied roads are littered with shite, garbage, and animal carcasses. Women and children weep at a makeshift graveyard: a ditch with a scroll of names penned above it, ink freshly renewed for another addition. | You enter through the gates of %objective% and find a few guards standing guard with thin hands tented atop spears. Their clothes shift about their bones like curtains astride an open window. The sense of hunger lingers thick in the air, reflected in the lip-smacking stares you\'re getting for just being here in good health. One of the defenders greets you warmly enough.%SPEECH_ON%We\'re tired and a wee bit hungry, but we\'ll manage. The fight is still in us, don\'t you doubt that.%SPEECH_OFF% | When you enter through the gates of %objective%, a dog is the first to greet you, licking your legs and sniffing deeply up your trousers. A man suddenly comes hollering, club raised, and soon man and animal go skittering down the muddied road, both seemingly barking. The mutt dodges the slow tackles of a hungry crowd and disappears entirely. A grinning guard walks over, using a stick to balance himself.%SPEECH_ON%Evenin\', sellsword. Food stocks are a bit low and that there doggo is fair game in a land of empty bellies.%SPEECH_OFF%You ask if they can still fight and the man laughs.%SPEECH_ON%Hell, a fight\'s all we got left!%SPEECH_OFF% | Entering through the front gates of %objective% is like walking beyond the veils of normalcy into the pits of the hells. Villagers shamble about, nothing to do but go hungrier and hungrier, and guards share jokes like they would food, laughing painfully while clutching their stomachs. The head of the defense comes over. He\'s unshaven, scarred, slackjawed, eyes looking labored with labored lookin\'. Although he stands a foot away, it\'s like he\'s staring at you from another world.%SPEECH_ON%Glad you made it, sellsword. We could certainly use your help these days.%SPEECH_OFF% | You pass through the gates of %objective% to find hell itself awaiting you. Guards stand at the ready like skeletons propped by a madman, and the villagers stand idle or lying in the dirt or leaning face-first against the walls. Children stand atop thatched roofs and pick through the straw in search of bugs. The defense\'s lieutenant welcomes you bluntly.%SPEECH_ON%Thank ye for comin\' sellsword, but you should have stayed home.%SPEECH_OFF% | The front gates of %objective% lurch ajar and slowly wheel open as the doorhandlers struggle to push the mechanisms forward. You enter the town to find a bunch of sextons digging a massive ditch right off the path. They\'re dumping bodies in and preparing fires to burn the corpses. The defense\'s lieutenant walks over.%SPEECH_ON%Sometimes the dead come back, but we learned ashes don\'t. Well, maybe they do, but they ain\'t no harm to nobody.%SPEECH_OFF%You think to mention the horrid stench, but realize that they probably got used to it ages ago. | Beyond the cluttered gates of %objective% you find a town that might as well have already succumbed to the undead hordes. Villagers shuffle around aimless and despondent. A few guardsmen stand beside a wagon going from home to home, giving out rations. You see a few defenders asleep along the fortifications walls, arms half strung along the crenelations and gripping their weapons, looking like puppets thrown in a corner. The lieutenant of the defense comes over.%SPEECH_ON%Thank you for comin\', sellsword. Many of us didn\'t think you would on account of this being hell itself.%SPEECH_OFF% | The front gates to %objective% are opened up and you pass through. Inside, you find two guards dragging a corpse toward a burning pile of bodies. A woman clutches at the boots of the dead man, begging them to let her have one last look. They ignore her and heave it into the fire and she falls before the pyre, slumping over as the skin of her husband crackles and pops. The defense\'s lieutenant comes over. He claps you on the shoulder.%SPEECH_ON%Glad you\'re here, sellsword.%SPEECH_OFF% | Through the gates of %objective% you\'re met by a man who grips you by the collar.%SPEECH_ON%You got food on ye? Hmm? I can smell it, or are you food itself?%SPEECH_OFF%A guard pries him away with the end of a spear. The crazy man clutches his stomach and talks in between picking nits off his eyebrows and eating them.%SPEECH_ON%Y\'all brought more swords here, but swords ain\'t what we need!%SPEECH_OFF%The guards take the man away as the lieutenant walks over.%SPEECH_ON%Don\'t mind him. He used to be a fatter, flubbier man so he\'s taking special umbrage with the recent developments. We\'ve still got food here, it just has to be rationed. Your swords are most appreciated mercenary and, make no mistake, you\'ll be using them shortly.%SPEECH_OFF% | You step through the gates of %objective% and are met with the smell of burnt flesh. There\'s a smoldering pile of corpses, a guard standing beside it with a stick, stirring the ashes like a chef would a cauldron. Villagers stand beside the charred remains, making religious rites in the air and wiping tears. The town\'s lieutenant walks over.%SPEECH_ON%Attacks can come from anywhere. The dead, they come back, and we is a suffering town. This here pile was a family. The wife died in the night and, through the cover of darkness, ate and ate and ate. We burn all the bodies. You have to.%SPEECH_OFF%The lieutenant sees you cringing. He lightens up with a smile.%SPEECH_ON%So how\'s your day going?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We need to prepare for the coming onslaught...",
					function getResult()
					{
						this.Flags.set("Wave", 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 8.0);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Wave1",
			Title = "At %objective%...",
			Text = "[img]gfx/ui/events/event_29.png[/img]{The wait is about to kill you when something else appears to do the job: the undead! %objective%\'s bells start ringing and the guards rush to action with a sort of unhinted liveliness. You order the %companyname% to prepare for battle. | As you watch a game of cards between the brothers, bells start ringing. You glance at the local monastery as see the sickly shape of an old man tolling his heart out. Guards respond to the ringing with renewed energy. One calls from the gatehouse.%SPEECH_ON%Here they come, to arms, to arms!%SPEECH_OFF% | Just when you think you\'ve joined the townsfolk in standing around and dying a slow death, the front gates open and a scout shoots through on a horse. The exhausted animal collapses and slides across the mud, its rider bailing and rolling free. He gets to his feet and shouts.%SPEECH_ON%The dead are coming! We have to get ready!%SPEECH_OFF% | A man atop one of the watch houses calls out.%SPEECH_ON%Message incoming, watch yer heads!%SPEECH_OFF%You look up to see an arrow arcing across the sky, twisting to come down right into the mud no more than a few feet from you. The lieutenant breaks a scroll off the arrow. His lips purse white the more he reads and he throws the paper aside.%SPEECH_ON%Time to get ready, mercenary, the dead are comin\'.%SPEECH_OFF%He turns to his fellow soldiers.%SPEECH_ON%Defenders of %objective%! To arms!%SPEECH_OFF% | One of the guards calls out.%SPEECH_ON%Gates opening, refugees comin\'!%SPEECH_OFF%A scattering of children sputter through the lurching doors. One explains that a horde of pale men are coming. The lieutenant stares at you.%SPEECH_ON%You\'d best get your men ready, sellsword.%SPEECH_OFF%The undead are heading this way, prepare for battle! | A scout enters %objective% and dismounts from a horse with bloodied legs and a missing tail. The rider\'s cradling a handless arm and his face has been carved free of an ear and eye. The lieutenant rushes over and the two talk before the scout passes out. Sighing, the lieutenant comes to stand.%SPEECH_ON%The undead are attacking, prepare yourselves! And put that steed out of its misery!%SPEECH_OFF%You nod and order the %companyname% to ready itself for battle. As the sellswords ready themselves, a man with a butcher\'s garb walks over and hacks the horse to death with a cleaver. The lieutenant claps you on the shoulder.%SPEECH_ON%Hey, at least now we\'ll have something good to eat if we make it through.%SPEECH_OFF% | You set down next to the lieutenant. He breaks bread.%SPEECH_ON%It\'s been awfully quiet since you got here.%SPEECH_OFF%Taking a bite, you ask if he\'s suggesting you\'re a double-agent for the dead. He laughs.%SPEECH_ON%Can\'t be too sure these days.%SPEECH_OFF%Just then, a bell tower tolls and guards rush the walls. Yelling and screaming erupt. The undead are attacking!\n\n The lieutenant throws his helmet on and helps you up.%SPEECH_ON%Time to prove your worth, sellsword.%SPEECH_OFF% | One of the guardsman takes a long-glass wrapped in leather and starts peering through the walls crenelations. His hands begin to shake and the glass wobbles out of the leather strappings and shatters against the stones. He points and screams.%SPEECH_ON%Th-the undead are here! T-to arms! Ring the bells!%SPEECH_OFF%You look over the walls, but don\'t need a spyglass to see the wave of pale coming your way. You tell the guardsman to calm down, and then rush to get the %companyname% prepared for battle. | A pack of dogs has come to %objective% and are howling to get inside. The hungry townspeople oblige their wish and the second the mutts enter they\'re set upon with knives and scythes. Despite the butchering, the dogs keep coming, fighting and gnashing to find safety in a slaughterhouse. You look over the walls to see just why they\'re willing to take the risk: the undead are coming! Shambling, shuffling, trundling over the horizon.\n\n You whistle at a man standing in a bell tower and point to the sighting. He straightens up so fast his metal cap falls off and clanks down the stone tower. He hurriedly rings the bell, the great bongs silencing the cruel canine commotion below. Man and mongrel stop to look up, a dreary silence settling over them all. Slowly, the din of death, groaning and growling, seeps into the very air. The lieutenant of the guards jumps into the scene, weapon already drawn out.%SPEECH_ON%To arms, men! To arms!%SPEECH_OFF% | One undead corpse shambles outside the wall of %objective%. The guards take turns trying to shoot it with arrows.%SPEECH_ON%Take a look at that, got \'im in the foot!%SPEECH_OFF%Another guard readies his shot.%SPEECH_ON%He\'s still walking. Aim for the head ya fool.%SPEECH_OFF%This shot lands true and there\'s a soft -tok- of the arrow piercing into a hollow brainpain. The corpse\'s balance shifts momentarily, pausing, then continues on as though it just remembered what it set out to do. Another guardsman shakes his head and readies his shot. He closes one eye, then slowly opens it. His hands start to shake and the arrow shaft rattles against the wooden bow.%SPEECH_ON%T-t-to... uh, to arms! Ring the alarms!%SPEECH_OFF%You look over the walls and see a sea of grey surfacing on the horizon, bobbing and trundling. The undead are attacking! | The town is quiet, the soft crackles and pops of a fire filling the muted air. You watch as men burn a rat on a spit and start slicing off chunks to share. Seeing enough, you go up the walls to find the lieutenant of the guards eyeing the horizon with a scope. He lowers it grimly.%SPEECH_ON%Well fark me arseways, they\'re coming.%SPEECH_OFF%He hands you the glass and you take a look. A throng of fish-eyed, warped-looking undead are shambling toward %objective%. The lieutenant takes his scope back.%SPEECH_ON%Time to earn your pay, sellsword.%SPEECH_OFF% | A woman\'s shriek draws you to look over your shoulder. You stare just in time to see a man leap off a tower and snap his neck at the length of a rope. The body sways, bumping and twisting against the stonewalls. The lieutenant of the guards angrily purses his lips and spits.%SPEECH_ON%Goddammit, he was supposed to be watching the horizon. %randomname%! Get up there, cut him free, and take his post!%SPEECH_OFF%Another guardsman grunts and does as told, but when he gets atop the guard he stops following any orders. Instead, he starts hysterically calling out.%SPEECH_ON%Sir! Sir! They\'re coming! All them pale folk, they\'re comin\'!%SPEECH_OFF%The lieutenant yells at his men to prepare for battle, and you yours. The man turns to you with a look of hopefulness.%SPEECH_ON%Whatever they\'re paying ya, I hope yer worth every crown, sellsword.%SPEECH_OFF% | One of the guards has found a den of rats which is cause for depressingly incredible celebration. As the townsfolk cheer and weep, and the shrill cries of the rodents go into spits and fires, the lieutenant of the guards comes over. He observes the scene with a smile, but it fades when a high-pitched scream breaks the air. Everyone turns to the walls where one of the guards is pointing toward the horizon. Even from where you\'re standing you can see the whites in his frightened eyes.%SPEECH_ON%The dead are comin\'! They\'re comin\' to kill us all! We ain\'t have enough men!%SPEECH_OFF%The lieutenant tells the man to grow some balls, then quietly turns to you.%SPEECH_ON%Prepare your men, sellsword, and prove you\'re worth whatever they\'re paying ya.%SPEECH_OFF% | A guard was caught trying to desert. He\'s on his knees while the lieutenant of the guards marches back and forth with disappointed appraisal.%SPEECH_ON%We can\'t spare a man, and you choose to do this to us?%SPEECH_OFF%One of the townsman throws a clop of mud which sails wide, but the intention is clear.%SPEECH_ON%Bury \'im alive! One less mouth to feed!%SPEECH_OFF%Just as the peasants start to get rowdy, the town bell starts bonging. A man atop one of the watchtowers shouts as hard as he can.%SPEECH_ON%They\'re coming! The undead, they\'re on the horizon!%SPEECH_OFF%The lieutenant looks down at the deserter.%SPEECH_ON%You want to earn back your honor, do it now. Will you fight?%SPEECH_OFF%The man quickly nods. The lieutenant turns to you, but you put a hand up.%SPEECH_ON%You need not ask the %companyname% such questions.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Defend the town!",
					function getResult()
					{
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Wave2",
			Title = "At %objective%...",
			Text = "[img]gfx/ui/events/event_73.png[/img]{As the %companyname% rests, cleaning sickly slough off their blades, another signal comes from the bell tower. The undead are attacking again! | The lieutenant of the guards goes around making sure his men are resting and drinking water. Just as he gets to you for a talk, the town bell tolls and the watchman hollers out that another attack is coming! You grin and clap the lieutenant on the shoulder.%SPEECH_ON%We just do what we\'re supposed to. Nothing simpler, right?%SPEECH_OFF%The lieutenant nods and goes to get his men prepared. | You watch as %randombrother% scrubs his blades of pale flesh and sopped clothing.%SPEECH_ON%By the old gods do they leave a mess.%SPEECH_OFF%Just then, a watchman whistles and barks out that the undead are attacking again! The mercenary angrily flings a strand of brain off his weapon.%SPEECH_ON%And just as I was starting to see my reflection!%SPEECH_OFF%You help the man to his feet, clapping him on the shoulder.%SPEECH_ON%Trust me, you ain\'t missing much.%SPEECH_OFF% | One of the guards breaks a hard roll into crumbs and starts doling out the scraps. Another guard asks where he got it and the man answers bluntly.%SPEECH_ON%Found it in the pockets of one of them dead fellas.%SPEECH_OFF%The eaters spit out the food and one even vomits. You watch as the men start fighting, but it\'s quickly broken up by the whistle of a watchman. The guard atop one of the towers is pointing toward the horizon.%SPEECH_ON%Here they come again! To battle!%SPEECH_OFF%Prepare for battle and try hard to not loot food off corpses that see you yourself as lunch. | As your men rest and recuperate, one of the watchman calls out.%SPEECH_ON%Here they come again!%SPEECH_OFF%War rarely gives one a proper break, especially wars with the undead. | You see %randombrother% wiping his face with mud. He pauses, glancing at your staring.%SPEECH_ON%Mudbath, sir. You know, to clean off the... bloodbath.%SPEECH_OFF%You roll your eyes. Just then, the town bell starts bonging and a watchman calls out, having sighted another attack on the way! You tell the sellsword to finish up his \'bath\' and get ready for battle. | You find %randombrother% washing strings of grey innards out from behind his ears.%SPEECH_ON%Momma always said get behind yer ears, but I don\'t think she foresaw this mess!%SPEECH_OFF%You tell him a good mother foresees all. The man laughs and nods.%SPEECH_ON%Yeah, she\'d just yell at me and ask where I got that mess from!%SPEECH_OFF%Just then, one of the watchmen along the towers calls out that the undead are attacking again. You turn to the sellsword.%SPEECH_ON%Well, time to get ourselves dirty again.%SPEECH_OFF% | You find one of the peasants carving lines into a stonewall. Seeing you, he explains himself.%SPEECH_ON%Just accounting for the lost. There\'s been so many I can\'t keep their names in order, but I can count.%SPEECH_OFF%You look down the length of the wall to see that it slowly traded names for numbers.%SPEECH_ON%We do what we can to remember, you know?%SPEECH_OFF%You nod and then, as if on cue, the watchmen call out, announcing another attack is on the way. The peasant grabs you by the arm with a pleading look.%SPEECH_ON%Tell me yer name and I\'ll put it up for ya if the time comes.%SPEECH_OFF%You yank your arm free and glare at the man, shrinking him down with a furious stare.%SPEECH_ON%I\'m a killer you fool, not your friend. The only thing separating my blade from your neck is who pays me. If you ask me that question again I\'ll put your number on that wall and I\'ll do it for free, got it?%SPEECH_OFF%The man nods. You nod back and leave to prepare your mercenaries for battle. | Just as you and the men settle down for a rest, the watchmen holler out and the town bell begins to toll. Another attack is on the way! You order the %companyname% to prepare for battle. | You climb %objective%\'s walls and find the lieutenant of the guard. He sighs.%SPEECH_ON%They\'re attacking. Again.%SPEECH_OFF%You stare toward the horizon and, indeed, there\'s another wave on its way. The lieutenant goes to collect his men for another fight and you do the same.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Defend the town!",
					function getResult()
					{
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Wave3",
			Title = "At %objective%...",
			Text = "[img]gfx/ui/events/event_73.png[/img]{As all the fighters rest, one of the watchman, is voice hoarse, yells out, defeated and despondent.%SPEECH_ON%Again. Here they come... again.%SPEECH_OFF%The %companyname% must rise to the challenge if %objective% is to survive! | One of the guardsman is staring into a fire, his hands shaking. He\'s mumbling to himself, but slowly gets louder for everyone to hear.%SPEECH_ON%Yeah, that\'s what we\'ll do! We can parlay! Let\'s make a deal with them! Let\'s talk to them! I\'ll do it, I\'ll talk to them!%SPEECH_OFF%The man gets up. A few try to drag him down, but he escapes their efforts. He runs to the walls and bails over. You rush to see the deranged fool sprinting across the fields - and right toward a huge wave of undead! Another guardsman starts shaking as he watches.%SPEECH_ON%By the old gods, more are coming? How could there possibly be more?%SPEECH_OFF%You ignore him and watch as the lunatic disappears in the crowd of corpses. Their ranks stagger to consume the intrusion before continuing on, like a pale pond briefly rippling from a rock. You yell out to your men.%SPEECH_ON%To battle, men! Into the fire we go again!%SPEECH_OFF% | One of the watchmen spots another attack coming! The man screams out so hard his voice breaks and he passes out. %objective%\'s milita is at its wit\'s end, hopefully this is the last of the assaults! | A watchman whistles out a warning that more undead are coming. The lieutenant of the guards shakes his head.%SPEECH_ON%By the old gods, will they ever stop coming? You\'re truly earning your keep this day, sellsword.%SPEECH_OFF%You think to joke about how you should earn more, but it just doesn\'t seem like a good time. Instead, you nod and go off to prepare the %companyname% for another battle. | While you and the lieutenant of the guard exchange war stories, a militiaman comes up. You notice that he\'s the man supposed to be watching the walls. He talks bluntly.%SPEECH_ON%Sirs, they\'re attacking again.%SPEECH_OFF%And just like that he turns on his heels and marches toward the town armory. You get up and help the lieutenant to his feet. He claps you on the shoulder with a terse, solemn smile.%SPEECH_ON%Into the fray again, huh?%SPEECH_OFF%You can only shrug.%SPEECH_ON%This is what we are here for. See you on the field, lieutenant.%SPEECH_OFF% | You stare over the walls of %objective% and see another wave of undead coming. All the excitement of previous attacks has gone. Now the defenders silently watch as the corpses shamble and shuffles onward. The lieutenant of the guard comes to your side.%SPEECH_ON%It has been an honor fighting by your side, sellsword.%SPEECH_OFF%You nod and respond.%SPEECH_ON%Mmm, honor, of course.%SPEECH_OFF%The lieutenant eyes you.%SPEECH_ON%You\'re thinking about your pay, aren\'t you?%SPEECH_OFF%Nodding again, you respond.%SPEECH_ON%I\'m thinking about what it\'ll buy: a warm bed, a warmer meal, and an even warmer wench.%SPEECH_OFF% | You stand at the walls of %objective% and look across the horizon. Another attack is coming, but there\'s no excitement in facing it. No screaming, no hysterics. Not anymore. It simply comes. A bulbous, shuffling ill-shapen army of corpses, bubbling and trundling forth, asking for yet another lancing. You order the %companyname% to prepare themselves. %randombrother% incredulously opens his arms, half his body caked in the sopping remains of undead torn asunder.%SPEECH_ON%Sir, I think we got it.%SPEECH_OFF%The men laugh and laugh, the militia joining in, and soon the hilarity fills the air, in part joined by the groaning of an increasingly close undead, madness made legion. | %randombrother% walks over to a campfire, drawing long strands of innards off his shoulders and slinging them away. A peasant eyes the viscera as though he\'s about one stomach growl away from taking a bite. The mercenary sits down with a discomfited plop.%SPEECH_ON%If I see one more corpse walking at me like it\'s lunchtime I\'m gonna...%SPEECH_OFF%Before he can even finish the sentence, a watchman along the walls gasses himself out on a horn, bellowing a warning for all to hear. He drops it at his side, face red and out of breath.%SPEECH_ON%The... undead... they\'re attacking again!%SPEECH_OFF%The mercenary\'s face goes dead still. He stands up and, not saying a word, slowly goes to arm himself. | A farmer stands at the gates of %objective%. He\'s arguing with its keepers.%SPEECH_ON%Lemme out! You\'ve surely fought them all and I wish to return to my farms. I\'ll have you know, I own two cows!%SPEECH_OFF%The man jets two fingers forward in case the listeners didn\'t get it. They shrug and open the gate, but the farmer doesn\'t move. Instead, he takes a step back.%SPEECH_ON%On second thought, the cows can wait for me to come home.%SPEECH_OFF%Beyond the walls, you see a huge horde of undead breaking over the horizon. Not a moment later, the warning signals are sent out and %objective% is busy with men running to and fro\' to arm themselves for yet another battle. | You meet the lieutenant of the guards along the walls. He\'s sharing bread with some of the militiamen and offers you a piece. You decline and ask what\'s on the horizon. The lieutenant points out toward the field.%SPEECH_ON%Oh, not much, they\'re just attacking again.%SPEECH_OFF%He hands you a scope. Looking through it, you see a huge crowd of corpses shambling toward %objective%. You lower the glass and ask the man why he hasn\'t raised the alarms. He shrugs.%SPEECH_ON%Giving the men an extra minute or two. The walking dead might want to kill us all, but they\'re not in a hurry about it, you know?%SPEECH_OFF%Understandable. You go ahead and have that bread on offer, then after another minute or two you go and prepare the %companyname% for battle. | One of the militiaman has taken a living dead man behind the walls. He\'s got it on the length of a chain, the corpse\'s arms cut off. There\'s a long, lolling tongue where the mouth should be. The lieutenant of the guards comes down. His face is so flush red he looks like he\'s gotta cuss like a drowning man needs to breathe.%SPEECH_ON%What in your mother\'s arsefarkin\' bastard shite cuckchild hells do you think you\'re doing?%SPEECH_OFF%The militiaman yanks on the chain, pulling the undead to the ground. He nervously explains himself.%SPEECH_ON%Maybe we can learn something from them? Learn what makes them go, learn how to, I dunno, maybe bring them back?%SPEECH_OFF%Before the argument continues any longer, a shout breaks over the men. A guard atop the watchtower is warning of another assault. Spinning around, blade in hand, the lieutenant swiftly decapitates the dead man. Its chinless head rolls right off the neck, the tongue flailing around the base like a snake in a jar. The lieutenant pulls the militiaman over by his collar.%SPEECH_ON%Don\'t you farkin\' pull this shite again, you got it? They\'re dead. That\'s all there is to it. Now grab your goddam weapon.%SPEECH_OFF%The %companyname% already stands at the ready, not needing your say so. | You find the town blacksmith hammering away on %objective%\'s \'finest\' weapons. His burly arms swing hammers and grasp tongs like they were made of sticks. He\'s got a lemniscate tattooed on the curve of his hand. Ember flares spiraling around like firebugs, he quickly notices your shadow casting madly around his open-air shop.%SPEECH_ON%Hey there, sellsword.%SPEECH_OFF%Genuinely curious and sincerely bored, you ask how he\'s doing. He flattens out some steel and turns it over, repeating the process.%SPEECH_ON%Been better, naturally. Could be worse, supposedly. How\'s this look?%SPEECH_OFF%The smith turns the blade up for your appraisal. Before you can answer, tolling alarm bells bong loudly, drawing a flurry of action as men rush to defend the town. Militias start running past, grabbing arms off the hooks that ring his shop. He lowers the blade, laughing.%SPEECH_ON%Bah, go on and fight, sellsword. It was one of them rhetorical questions anyway.%SPEECH_OFF% | %objective%\'s scribe walks about with a scroll of parchment. He\'s using the back of a servant to write whatever he\'s seeing. And you\'re curious, in this field of chaos, what is it he\'s seeing? The man answers you bluntly.%SPEECH_ON%Studying emotions. I feel sadness is a disease and it is spreading here.%SPEECH_OFF%A curious answer to a curious question demands a second round. You inquire about his research. He ignores the question and looks you up and down.%SPEECH_ON%By my metrics, you\'re in excellent health, sellsword. Well, except your body. You carry a limp like a maimed dog and you wince when you turn to the left. Easily noticed. But I can see the pain doesn\'t hold you back. In fact, I\'d say it... drives you. Are you making up for something taken from you?%SPEECH_OFF%Before you can answer, which would have been to tell him to shut his mouth, alarm bells interrupt sound off. Men starting rushing to action and getting ready for the next undead attack. When you turn back, the scribe is already gone, standing in some far corner, using his sharp quill pen to furiously write on the back of his grimacing servant. | As you prepare to settle down and get some rest, alarm bells sound off and the watchmen along the walls chase the sound with a good dose of screaming. It appears the undead are attacking again! You hurry to get the %companyname% ready for another battle. | You notice that the tips of the walls have been blackened with buzzards. The large birds stare into the town, watching like a cloaked funeral procession. Suddenly, a militiaman emerges out the door of a watchtower and smashes one of the birds with a stick. There\'s a brief squawk and the rest of the buzzards shift on their feet like lily pads on a rippling pond. And then the militiaman cracks a second bird upside the head and the scavengers get a good inkling of what\'s going on and take flight. The hunter swings his haul by the feet and proudly returns to the watchtower.%SPEECH_ON%Hey.%SPEECH_OFF%The lieutenant of the guard taps your shoulder. When you turn, he thumbs over his own.%SPEECH_ON%Undead are attacking again. I ordered the men to keep the alarms quiet. You know, in case all our hollering and hysterics are actually drawing more of those bastards here.%SPEECH_OFF%Seems like a reasonable idea.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Defend the town!",
					function getResult()
					{
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia1",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_46.png[/img]{You\'ve won the day, but the militia has possibly lost the war: the townguard took so many losses more citizens are packing to leave the village altogether rather than stay and help defend! | Victory, but at what cost? So many militiamen were killed in the battle that no citizen of %objective% wishes to take their place!}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "A victory nontheless.",
					function getResult()
					{
						this.Flags.set("Wave", this.Flags.get("Wave") + 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 3.0);
						this.Flags.set("Militia", 3);
						this.Flags.set("MilitiaStart", 3);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia2",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_46.png[/img]{The battle has been won, but not without losses. A few citizens of %objective% sign up to help defend the town while others yet pack their things to leave. | You\'ve taken the day, but the undead made you pay for it dearly. While some citizens agree to help the militia, helping replenish its numbers, an equal number keep their distance and prepare for the worst.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "A victory nontheless.",
					function getResult()
					{
						this.Flags.set("Wave", this.Flags.get("Wave") + 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 3.0);
						this.Flags.set("Militia", 6);
						this.Flags.set("MilitiaStart", 6);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia3",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_80.png[/img]{What a victory! Not only have the undead been beaten back, but so impressive was your success that many citizens of %objective% have joined the militia for battles to come! | The undead have been so thoroughly defeated that many citizens of %objective% have joined the militia to help in the coming battles!}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Victory!",
					function getResult()
					{
						this.Flags.set("Wave", this.Flags.get("Wave") + 1);
						this.Flags.set("TimeWaveHits", this.Time.getVirtualTimeF() + 3.0);
						this.Flags.set("Militia", 8);
						this.Flags.set("MilitiaStart", 8);
						this.Contract.setState("Running_Wait");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Ghouls",
			Title = "At %objective%...",
			Text = "[img]gfx/ui/events/event_69.png[/img]{As you prepare for the fight, you notice odd shapes bumbling around the ranks of undead: nachzehrers. The ceatures must be following the hordes to feed on whatever they kill, like seagulls following a fishing boat on the sea. | Nachzehrers! The foul creatures are seen trotting and loping amidst the crowds of corpses, the damned beasts looking for their next meal, no doubt. | The undead leave a lot of dead and dying in their wake and, unsurprisingly, scavengers have started following them. In this case, they\'re nachzehrers, the ugly beasts growling and snarling as they hungrily anticipate their next meal. | If you raid a pantry, the mice are sure to come. Now that the undead are attacking %objective%, they\'ve acquired a retinue of scavengers in their wake: nachzehrers.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Defend the town!",
					function getResult()
					{
						this.Contract.spawnGhouls();
						this.Contract.setState("Running_Wave");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TheAftermath",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_46.png[/img]{You stare over the battlefield. It is littered with the dead, the dying, the undying, and the dying undying. Men, of the living, breathing sort, march about the muck, finishing off anything that remotely resembles a reanimation. With the fight over, and the town saved, %employer% should now be expecting you. | The battle is over and the town saved. Time to return %employer% for a hell of a payday. | %objective% resembles a flooded graveyard more than any town you know of. Corpses, new and old, are washed out across the earth, blood and molded filth pooled about each. The stench reminds you of a dead dog you found alongside a creek, bones dripping the decomposition, the body being fed upon by crawfish and maggots.\n\nThe relentless attacks having finally ceased, %objective% seems safe for now. %employer% should be expecting you and you\'ve no reason to not escape this horrid place as soon as possible. | Well, the town is saved. The peasants step about the battlefield with long sticks, poking the earth like pelicans prodding over a pool of most dangerous waters. %randombrother% comes over, cleaning the sludge off his blade, and asks if it is time to return to %employer%. You nod. The sooner you can get back for your pay the better. | The battle is over. Among the dead are peasants and militiamen, each attended by survivors who\'ve come to cloak the bodies with sobbing silhouettes. As for the dead undead, well, nobody cares. Those bodies lay as though they came with no purpose and yet departed with a thorough destruction of whatever they touched. The sight of their corpses, and the chaotic nothingness that they represent, is infuriating. Not wanting to be around a second longer, you inform the men to get ready to return to %employer%. | You and the %companyname% stand victorious. The town and its people will survive, for now, and you can return to %employer% for your pay. | The lieutenant of the guard thanks you for saving the town. You mention that the only reason you\'re here is because someone paid you. He shrugs.%SPEECH_ON%I thank the rains I\'ve no command over, I\'ll thank you mercenary whether you like it or not.%SPEECH_OFF% | The battle is over and, thankfully, won. Undead bodies spill over the earth in such disarray that they hardly look any different than they did shambling and shuffling just hours ago. But the more recently expired share no such cosmic despondence. They are attended to by wailing women and confused children. You look away from the scene, ordering the %companyname% to prepare its return to %employer%. | A dead man is at your feet, and beside him an undead corpse. It\'s the strangest of sights, for they are equally put out of this world, but there\'s life yet in the man. The breath of a recent memory. You saw him swinging to the very end. A noble way for a fighter to go. This corpse, though? What of it? You\'ll remember it tearing a man\'s throat out with its bare teeth. Maybe the corpse had a time beyond that moment, a time when it had a family, a time when it was but a kind man doing good in this world. But a throat-ripping monstrosity is all it is now. All it will be remembered as.\n\nThe relentless attacks on %objective% have finally ceased, and so you hurry to collect the company and prepare a return to %employer% in %townname%. A good payday is better than another moment of looking at this shite. | What is a dead man? What of a dead man killed twice over? And what of a dead man killed thrice over? Unfortunate. Misfortunate. And a joke.\n\n You walk the battlefield collecting the men of the %companyname%. The town of %objective% is saved for now, and so it\'s time for you to get back to %employer% in %townname% for a well-earned payday. | %randombrother% wipes his forehead with a cloth, leaving behind a disgusting smear of pale liquid.%SPEECH_ON%Shite, what is that? Is that brain? Sir, would you please?%SPEECH_OFF%You help the man clean himself off. He stands back, arms wide. He\'s still absolutely covered in blood, guts, and things which may forever be left unknown.%SPEECH_ON%How do I look?%SPEECH_OFF%His grin winks out of the murk like a rind of the moon through a pale sky. You refuse to answer and just tell him to go get the men. With %objective% saved for now, %employer% will be expecting the company back in %townname%, and the company should be expecting a well-earned payday. | %randombrother% comes to your side, together the two of you overlooking the battlefield. Already you can see the families of the dead coming out to find their lost ones. Their wailing is sharp, humanly pitched, a disturbingly welcomed respite from the growling, moaning despondence of the undead. The mercenary claps you on the shoulder.%SPEECH_ON%I\'ll go and collect the men so we can get on back to %townname% and collect our pay.%SPEECH_OFF% | You watch as women shuffle about the battlefield, holding their dresses up like wetted fowl steering clear of a pond\'s murk. Of course, once they find what they\'re looking for, they drop all regard for cleanliness and drop into the filth, wailing and howling, covering themselves in the very horrors which had dispatched their fathers and husbands with infuriating indifference.\n\n %randombrother% joins your side.%SPEECH_ON%Sir, the attacks have ceased and the men are ready to return to %townname%. Just give the word.%SPEECH_OFF% | The lieutenant of the guard comes to your side and shakes your hand. Drying blood cracks and crumbles as you shake. He puts his fists to his hips and nods at the scene.%SPEECH_ON%You did well, sellsword, and we could not have done it without you. I\'d like to offer you more as thanks, but this town needs all the resources it has to rebuild. I do hope that %employer% pays you all that you are worth.%SPEECH_OFF%You hope so, too.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We did it!",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You enter %townname% and find %employer% looking over a balcony. He calls to you just as a guard slams a satchel of crowns into your arms.%SPEECH_ON%Sellsword! So glas to have you back! My little birds have already told me much of your doings. I hope you spend those crowns well!%SPEECH_OFF%Before you can say anything, the man spins and leaves. The guard who handed you the crowns is already gone as well. Peasants walk around you like a signpost pointing to places they\'ll never go. | You find %employer% slapping and kicking a child around, eventually punting him into the dirt with swift boot to the chest. Seeing you, the nobleman wipes the sweat from his brow and explains himself.%SPEECH_ON%This doesn\'t concern you.%SPEECH_OFF%The kid is tilting on hands and knees, one hand to his belly, the other drawing blood from his leaking nose. Gradually, he gets to his feet, wavering there, blinkered eyes blinking crimson. A servant comes by and starts dabbing water over him, but the nobleman grabs the cloth and tosses it aside.%SPEECH_ON%You think he\'ll learn that way. If you want to help someone, help this sellsword. He is owed %reward_completion% crowns. Snap snap.%SPEECH_OFF%The servant nods and quickly leaves. You stay awhile, watching the beating continue. The kid doesn\'t cry or call out for there is learned expectation in this punishment. A few minutes pass when the servant suddenly reappears, satchel in hand. He hands it to you and whispers an earnest suggestion that you make your leave. | %employer% is stooped over his table, arms tented long and stiff, his head drooped low as he stares at a dead crow.%SPEECH_ON%Found this raven in my bed this morning. Just lying there. Dead. You\'ve any idea what that means?%SPEECH_OFF%You suggest that it was, perhaps, a joke. The nobleman scoffs.%SPEECH_ON%Nay. I think this has to do with you, sellsword. You did well in saving that town, but perhaps it was not meant to be saved? Maybe that is what this bird represents. Maybe the dead shall come for me next as I have left Death itself unpaid.%SPEECH_OFF%You use this statement to slowly segue into the issue of your own pay. Despite his wild ravings, the nobleman does momentarily get his wits together to pay you your %reward_completion% crowns. | %employer% is listening to a group of scribes, somehow arranged in order of age and seniority. The youth of the group stay quiet, the only noise out of them is the scribbling of their quill pens. The elders argue amongst themselves, using volume just as much as reason and rationality. This seems a common sight nowadays, no doubt the dead climbing out of their graves being of some concern to men of philosophical takes. Regardless, you belch loudly to introduce yourself, shattering their conversation with disgusting aplomb. %employer% laughs and waves you in.%SPEECH_ON%Ah, sellsword! The man who gets things done, come to talk with the men who simply yap?%SPEECH_OFF%You shake your head and tell him you\'re only there for the pay. The nobleman nods.%SPEECH_ON%Of course. You did well in saving that town. I\'ve heard much of your heroics. %reward_completion% crowns awaits you there in the corner.%SPEECH_OFF%You walk across the room, your boots filling the suddenly hollow room with quiet claps of leather on stone. The scribes twist to watch you, murmuring amongst themselves. You pick a satchel up, hearing the chink of crowns shift around with a most welcomed weight. You quietly leave, though the second the door closes behind you the scribes erupt with arguing once again. | %employer% is found with a few women beside him. They\'re telling him of their lost fathers, husbands, and brothers. He nods, attentively, though occasionally sparing a moment to glance at the bosom of the youngest girl.%SPEECH_ON%Yes, yes of course. Absolutely horrible. Horrible! Hold on one moment. Sellsword!%SPEECH_OFF%He waves you in. The women part as you make your entrance. The youngest gal looks you up and down, quickly wiping tears from her eyes and does a little bit of youthful primping. The nobleman sees this and glances between you and her.%SPEECH_ON%Ahem, yes, uh, your crowns are in the corner. You must go. Now. I\'ve things to attend to.%SPEECH_OFF%He stands and points toward your %reward_completion% crowns, and in one swift motion takes the lady by the hand.%SPEECH_ON%Now, young backstress, you said your husband is dead and you\'ve no one left in this life? Absolutely no one at all?%SPEECH_OFF% | Dogs chew up something in the path. Whatever it was, it once had life, bones and organs which have long since grown pale and rotten, though the mongrels rabid eating would suggest it might as well be a slab of steak. %employer% greets you, attentive guards at his side.%SPEECH_ON%My birds tell me the town was saved. You\'ve done well, mercenary, better than I had thought you would. Your pay, as agreed upon.%SPEECH_OFF%He hands you a satchel of %reward_completion% crowns. The dogs pause, turning their heads toward you with flesh swinging from their teeth, narrow black eyes staring with an emptiness that reflects their hunger. The guards lower their spears and the dogs, somehow interpreting this correctly, slowly turn back to their dinner. | %employer% is found sitting low in his chair. He despondently waves you into the room.%SPEECH_ON%I\'ve horrid news. My seer says I\'ve brought a curse upon my land and my people. That\'s why the dead rise again.%SPEECH_OFF%You shrug and kindly state that the seer is full of shite. The nobleman shrugs.%SPEECH_ON%I sure hope so. What was it we agreed upon, %reward_completion% crowns?%SPEECH_OFF%You\'re tempted to say you agreed to more, but dare not cross a man who is so superstitious. When you answer, he smiles warmly at your accurate response.%SPEECH_ON%Good call, sellsword. You passed that test. I may be going mad, but I\'m not one to trifle with.%SPEECH_OFF%You ask if your honesty will be rewarded. The man raises an eyebrow.%SPEECH_ON%Your head is on your shoulders, is it not?%SPEECH_OFF%Point taken. | %employer% is found on his balcony. You join him, though guards stand very nearby, eyeing you carefully. The man waves his arm to the town which lies beneath him.%SPEECH_ON%I know you did not save this town directly but, in a way, I think you did. Stopping the undead anywhere is as good as stopping them here. Would you agree?%SPEECH_OFF%The man punctuates the question with a satchel of %reward_completion% crowns. You take the pay and nod. He nods back.%SPEECH_ON%Glad you agree for we may yet need your services again.%SPEECH_OFF% | You step into %employer%\'s darkened room. There are rugs over the windows and most of the candles are not lit. All the light flickers beside a scribe standing with a candelabra, his fire-red face grinning behind the candles like a little devil holding a trident. He glances at you and quietly sets the candles down. As he steps back, it is as though he were falling into a black pool, his disembodied face slowly dipping into the darkness. He\'s still there, breathing slightly, rustling his cloak, but you\'ve naught a part of him to see. %employer% waves you in.%SPEECH_ON%Sellsword! By the old gods you did well in saving that town!%SPEECH_OFF%You step forward, glancing at the darkness which shifts around, some of it shadow, some of it man. %employer% hands you a satchel. A scattering of candlelit coins shimmer across its open top.%SPEECH_ON%%reward_completion% crowns, as agreed upon. Now, please, depart. I have to more to study, more to learn.%SPEECH_OFF%You take your pay and slowly leave. As the door closes, you see the scribe reemerge like a gaunt specter, bony hands reaching for the light once more. | %employer% is found in his study. Guards stand at all the corners and a scribe quietly goes around the shelves, pulling scrolls and putting them back with equal earnest and disappointment. You\'re quickly waved in and just as quickly paid by the nobleman.%SPEECH_ON%Good job, sellsword. You\'re already a hero in some parts of these lands. Hell, maybe you\'ll end up in one of these scrolls, forever remembered.%SPEECH_OFF%You hear the scribe scoff. %employer% waves toward the door.%SPEECH_ON%Please? I\'ve immense things to study, and so little time to do it.%SPEECH_OFF% | You enter %employer%\'s room to find the man deep in his chair. Peasants argue on either side of him, pointing and accusing.%SPEECH_ON%This man is a murderer!%SPEECH_OFF%The defendant scoffs.%SPEECH_ON%Murderer? What happened was an accident! I thought he was one of them undead fellers!%SPEECH_OFF%The other man scoffs this time.%SPEECH_ON%Undead? He was merely drunk!%SPEECH_OFF%Tempers rise.%SPEECH_ON%Well, I heard growling! Or grunting.%SPEECH_OFF%Your employer despondently waves you in.%SPEECH_ON%Sellsword, good job on saving that town. Your pay.%SPEECH_OFF%He pushes a satchel of %reward_completion% crowns across the table. The peasants pause, staring at the coins wink out of its open top. You take the satchel, pretending that it weighs far too much for you.%SPEECH_ON%Oof, so heavy it is! You sirs have a good day.%SPEECH_OFF% | %employer% welcomes you into his room.%SPEECH_ON%My little birds tell me of the town being saved. You did well, mercenary, well enough in a world that\'s become so dark. Your pay of %reward_completion% crowns, as agreed upon.%SPEECH_OFF% | %employer% is standing outside, staring toward a graveyard that has gathered quite a few residents since your last visit. He hands you a satchel of %reward_completion% crowns.%SPEECH_ON%You did well, mercenary. Word of your doings has spread across the land. One success won\'t save us all, but it puts us on the right path. If we are to win this damned war with the dead, we need as much spirit and hope we can muster.%SPEECH_OFF%Taking your pay, you add that sellswords need as many crowns as possible. You know, to keep their \'spirits\' high. The nobleman grins.%SPEECH_ON%I\'m being sanctimonious, not philanthropic. Get on out of here.%SPEECH_OFF% | %employer%\'s guards take you into his room. He\'s got a few scrolls unwound all around him. Broken quill pens litter his table as though someone had splattered a bird there.%SPEECH_ON%Sellsword! Tis good to see the man of the hour, the day, the week! You did well in saving that town.%SPEECH_OFF%He throws you a satchel of %reward_completion% crowns.%SPEECH_ON%One victory to keep a town alive, one victory to keep the hopes of the people alive. I should pay you more. I mean, I won\'t, but I should.%SPEECH_OFF%You glumly take your pay, nodding back and responding.%SPEECH_ON%Well, it\'s the thought that counts.%SPEECH_OFF%The nobleman snaps his fingers.%SPEECH_ON%Exactly!%SPEECH_OFF% | You find %employer% slunk deep in his chair with an even deeper frown. His clothes wink with shiny opulence and the candelabras look worth more than the servants holding them. The gaudy grouch despondently waves you in. He speaks slowly and sarcastically.%SPEECH_ON%One victory for man. One more victory to carry us to the next day. Mmm, thank you sellsword.%SPEECH_OFF%You slowly step forward, the servants glancing at you with fearful eyes. You take your pay and step back. %employer% waves you away now.%SPEECH_ON%Begone. I hope to see you again, lest you are of ill-shape and of dead body, then it would be a shame. Then again, that\'s how we\'re all going to end up, isn\'t it?%SPEECH_OFF%You say nothing and make your leave. It appears the war against the unending undead has worn on the nobleman.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "%objective% is saved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationNobleContractSuccess, "Defended " + this.Flags.get("ObjectiveName") + " against undead");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(::Const.Factions.GreaterEvilStrengthOnCriticalContract);
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
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Origin, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "Around %objective%",
			Text = "[img]gfx/ui/events/event_30.png[/img]{The undead were too many and you had to retreat. Unfortunately, a whole town doesn\'t have such liberties and so %objective% was completely overrun. You didn\'t stick around to see what became of its citizens, though it doesn\'t take a genius to guess. | The %companyname% has been defeated in the field by the hordes of undead! In the wake of your failure, %objective% is quickly overrun. A mass of peasants run from the town and those too slow are added to the sea of shambling corpses. | You failed to hold back the undead! The corpses slowly shuffle beyond the walls of %objective% and eat and kill all that they come across. As you flee the field, you see the lieutenant of the guards shuffling alongside the horde of corpses.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "%objective% has fallen.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationNobleContractFail, "Failed to defend " + this.Flags.get("ObjectiveName") + " against undead");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function spawnWave()
	{
		local undeadBase = this.World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getNearestSettlement(this.m.Origin.getTile());
		local originTile = this.m.Origin.getTile();
		local tile;

		while (true)
		{
			local x = ::Math.rand(originTile.SquareCoords.X - 5, originTile.SquareCoords.X + 5);
			local y = ::Math.rand(originTile.SquareCoords.Y - 5, originTile.SquareCoords.Y + 5);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == ::Const.World.TerrainType.Ocean)
			{
				continue;
			}

			local navSettings = this.World.getNavigator().createSettings();
			navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;
			local path = this.World.getNavigator().findPath(tile, originTile, navSettings, 0);

			if (!path.isEmpty())
			{
				break;
			}
		}

		local party = this.World.FactionManager.getFactionOfType(::Const.FactionType.Undead).spawnEntity(tile, "Undead Horde", false, ::Const.World.Spawn.UndeadArmy, (80 + this.m.Flags.get("Wave") * 10) * this.getDifficultyMult() * this.getScaledDifficultyMult());
		this.m.UnitsSpawned.push(party.getID());
		party.getLoot().ArmorParts = ::Math.rand(0, 15);
		party.getSprite("banner").setBrush(undeadBase.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(::Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.setAttackableByAI(false);
		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(originTile);
		c.addOrder(attack);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(60.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(originTile);
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	function spawnUndeadAtTheWalls()
	{
		local undeadBase = this.World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getNearestSettlement(this.m.Origin.getTile());
		local party = this.World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).spawnEntity(this.m.Origin.getTile(), "Undead Horde", false, ::Const.World.Spawn.ZombiesOrZombiesAndGhosts, 100 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		party.setPos(this.createVec(party.getPos().X - 50, party.getPos().Y - 50));
		this.m.UnitsSpawned.push(party.getID());
		party.getLoot().ArmorParts = ::Math.rand(0, 15);
		party.getSprite("banner").setBrush(undeadBase.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(::Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local wait = this.new("scripts/ai/world/orders/wait_order");
		wait.setTime(15.0);
		c.addOrder(wait);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(90.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(this.m.Origin.getTile());
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	function spawnGhouls()
	{
		local originTile = this.m.Origin.getTile();
		local tile;

		while (true)
		{
			local x = ::Math.rand(originTile.SquareCoords.X - 5, originTile.SquareCoords.X + 5);
			local y = ::Math.rand(originTile.SquareCoords.Y - 5, originTile.SquareCoords.Y + 5);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			tile = this.World.getTileSquare(x, y);

			if (tile.getDistanceTo(originTile) <= 4)
			{
				continue;
			}

			if (tile.Type == ::Const.World.TerrainType.Ocean)
			{
				continue;
			}

			local navSettings = this.World.getNavigator().createSettings();
			navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;
			local path = this.World.getNavigator().findPath(tile, originTile, navSettings, 0);

			if (!path.isEmpty())
			{
				break;
			}
		}

		local party = this.World.FactionManager.getFactionOfType(::Const.FactionType.Undead).spawnEntity(tile, "Nachzehrers", false, ::Const.World.Spawn.Ghouls, 110 * this.getDifficultyMult() * this.getScaledDifficultyMult());
		this.m.UnitsSpawned.push(party.getID());
		party.getSprite("banner").setBrush("banner_beasts_01");
		party.setDescription("A flock of scavenging nachzehrers.");
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.setAttackableByAI(false);
		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		c.getBehavior(::Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(originTile);
		c.addOrder(move);
		local attack = this.new("scripts/ai/world/orders/attack_zone_order");
		attack.setTargetTile(originTile);
		c.addOrder(attack);
		local destroy = this.new("scripts/ai/world/orders/convert_order");
		destroy.setTime(60.0);
		destroy.setSafetyOverride(true);
		destroy.setTargetTile(originTile);
		destroy.setTargetID(this.m.Origin.getID());
		c.addOrder(destroy);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"objective",
			this.m.Flags.get("ObjectiveName")
		]);
		_vars.push([
			"direction",
			this.m.Origin == null || this.m.Origin.isNull() ? "" : ::Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Origin.getTile())]
		]);
	}

	function onOriginSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/besieged_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			foreach( id in this.m.UnitsSpawned )
			{
				local e = this.World.getEntityByID(id);

				if (e != null && e.isAlive())
				{
					e.setAttackableByAI(true);
					e.setOnCombatWithPlayerCallback(null);
				}
			}

			if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.Origin.hasSprite("selection"))
			{
				this.m.Origin.getSprite("selection").Visible = false;
			}

			if (this.m.Home != null && !this.m.Home.isNull() && this.m.Home.hasSprite("selection"))
			{
				this.m.Home.getSprite("selection").Visible = false;
			}
		}

		if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Origin.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(2);
			}
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
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
	}

});

