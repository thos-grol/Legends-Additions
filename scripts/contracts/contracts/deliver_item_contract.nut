this.deliver_item_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Location = null,
		RecipientID = 0
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.deliver_item";
		this.m.Name = "Armed Courier";
		this.m.Description = "There is valuable cargo that local lords want transported so they are hiring mercenaries to transport it";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;

		if (!this.m.Flags.has("Rating")) this.m.Flags.set("Rating", "F");
		if (this.World.getTime().Days > 50)
		{
			this.m.Flags.set("Rating", "E");
		}
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.DifficultyMult = ::Math.rand(70, 105) * 0.01;

		if (this.m.Home == null)
		{
			this.setHome(this.World.State.getCurrentTown());
		}

		local recipient = this.World.FactionManager.getFaction(this.m.Destination.getFactions()[0]).getRandomCharacter();
		this.m.RecipientID = recipient.getID();
		this.m.Flags.set("RecipientName", recipient.getName());
		this.contract.start();
	}

	function setup()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		foreach( s in settlements )
		{
			if (s.getID() == this.m.Home.getID())
			{
				continue;
			}

			if (!s.isDiscovered() || s.isMilitary())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer())
			{
				continue;
			}

			if (this.m.Home.isIsolated() || s.isIsolated() || !this.m.Home.isConnectedToByRoads(s) || this.m.Home.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = this.m.Home.getTile().getDistanceTo(s.getTile());

			if (d < 15 || d > 100)
			{
				continue;
			}

			if (this.World.getTime().Days <= 10)
			{
				local distance = this.getDistanceOnRoads(this.m.Home.getTile(), s.getTile());
				local days = this.getDaysRequiredToTravel(distance, ::Const.World.MovementSettings.Speed, false);

				if (this.World.getTime().Days <= 5 && days >= 2)
				{
					continue;
				}

				if (this.World.getTime().Days <= 10 && days >= 3)
				{
					continue;
				}
			}

			candidates.push(s);
		}

		if (candidates.len() == 0)
		{
			this.m.IsValid = false;
			return;
		}

		this.m.Destination = this.WeakTableRef(candidates[::Math.rand(0, candidates.len() - 1)]);
		local distance = this.getDistanceOnRoads(this.m.Home.getTile(), this.m.Destination.getTile());
		local days = this.getDaysRequiredToTravel(distance, ::Const.World.MovementSettings.Speed, false);
		local modrate = this.World.State.getPlayer().getBarterMult();

		if (days >= 2 || distance >= 40)
		{
			this.m.DifficultyMult = ::Math.rand(100, 175) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = ::Math.rand(100, 115) * 0.01;
		}

		this.m.Payment.Pool = ::Z.Economy.Contracts[this.m.Type] * days;

		if (this.World.getTime().Days > 50) this.m.Payment.Pool += 20;
		if (::Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Distance", distance);
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Deliver cargo to %recipient% in %objective% about %days% to the %direction% by road"
				];
				local isSouthern = this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == ::Const.FactionType.OrientalCityState;

				if (!isSouthern && ::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else if (isSouthern)
				{
					this.Contract.setScreen("TaskSouthern");
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

				if (this.World.getTime().Days > 50)
				{
					
					if (!this.World.Flags.get("IsCursedCrystalSkull")) 
					{
						this.Flags.set("IsEvilArtifact", true);
						this.Flags.set("IsCursedCrystalSkull", true);

					}
					else if (r <= 25) this.Flags.set("IsEvilArtifact", true);
					else if (r <= 50)
					{
						this.Flags.set("IsMercenaries", true);
					}
				}
				else
				{
					if (r <= 5)
					{
						this.Flags.set("IsEvilArtifact", true);
						if (!this.World.Flags.get("IsCursedCrystalSkull")) this.Flags.set("IsCursedCrystalSkull", true);
					}
					else if (r <= 20)
					{
						this.Flags.set("IsMercenaries", true);
					}
					else if (r <= 30)
					{
						this.Flags.set("IsThieves", true);
					}
				}
				

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Deliver cargo to %recipient% in %objective% about %days% to the %direction% by road"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Destination) && !this.Flags.get("IsStolenByThieves"))
				{
					if (this.Flags.get("IsEnragingMessage"))
					{
						this.Contract.setScreen("EnragingMessage1");
					}
					else
					{
						local isSouthern = this.Contract.m.Destination.isSouthern();

						if (isSouthern)
						{
							this.Contract.setScreen("Success2");
						}
						else
						{
							this.Contract.setScreen("Success1");
						}
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					local parties = this.World.getAllEntitiesAtPos(this.World.State.getPlayer().getPos(), 400.0);

					foreach( party in parties )
					{
						if (!party.isAlliedWithPlayer)
						{
							return;
						}
					}

					if (this.Flags.get("IsMercenaries") && this.World.State.getPlayer().getTile().HasRoad)
					{
						if (!this.TempFlags.get("IsMercenariesDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && ::Math.rand(1, 1000) <= 1)
						{
							this.Contract.setScreen("Mercenaries1");
							this.World.Contracts.showActiveContract();
							this.TempFlags.set("IsMercenariesDialogTriggered", true);
						}
					}
					else if (this.Flags.get("IsEvilArtifact") && !this.Flags.get("IsEvilArtifactDone"))
					{
						if (!this.TempFlags.get("IsEvilArtifactDialogTriggered") && this.Contract.getDistanceToNearestSettlement() >= 6 && ::Math.rand(1, 1000) <= 1)
						{
							this.Contract.setScreen("EvilArtifact1");
							this.World.Contracts.showActiveContract();
							this.TempFlags.set("IsEvilArtifactDialogTriggered", true);
						}
					}
					else if (this.Flags.get("IsEvilArtifact") && this.Flags.get("IsEvilArtifactDone"))
					{
						this.Contract.setScreen("EvilArtifact3");
						this.World.Contracts.showActiveContract();
						this.Flags.set("IsEvilArtifact", false);
					}
					else if (this.Flags.get("IsThieves") && !this.Flags.get("IsStolenByThieves") && this.World.State.getPlayer().getTile().Type != ::Const.World.TerrainType.Desert && (this.World.Assets.isCamping() || !this.World.getTime().IsDaytime) && ::Math.rand(1, 100) <= 3)
					{
						local tile = this.Contract.getTileToSpawnLocation(this.World.State.getPlayer().getTile(), 5, 10, [
							::Const.World.TerrainType.Shore,
							::Const.World.TerrainType.Ocean,
							::Const.World.TerrainType.Mountains
						], false);
						tile.clear();
						this.Contract.m.Location = this.WeakTableRef(this.World.spawnLocation("scripts/entity/world/locations/bandit_hideout_location", tile.Coords));
						this.Contract.m.Location.setResources(0);
						this.World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).addSettlement(this.Contract.m.Location.get(), false);
						this.Contract.m.Location.onSpawned();
						this.Contract.addUnitsToEntity(this.Contract.m.Location, ::Const.World.Spawn.BanditRoamers, 80 * this.Contract.getDifficultyMult());
						::Const.World.Common.addFootprintsFromTo(this.World.State.getPlayer().getTile(), tile, ::Const.GenericFootprints, ::Const.World.FootprintsType.Brigands, 0.75);
						this.Flags.set("IsStolenByThieves", true);
						this.Contract.setScreen("Thieves1");
						this.World.Contracts.showActiveContract();
					}
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "EvilArtifact")
				{
					this.Flags.set("IsEvilArtifactDone", true);
				}
				else if (_combatID == "Mercs")
				{
					this.Flags.set("IsMercenaries", false);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "EvilArtifact")
				{
					if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == ::Const.FactionType.OrientalCityState)
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationNobleContractFail, "Failed to deliver cargo");
					}
					else
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationCivilianContractFail, "Failed to deliver cargo");
					}

					this.World.Contracts.removeContract(this.Contract);
				}
				else if (_combatID == "Mercs")
				{
					if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == ::Const.FactionType.OrientalCityState)
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationNobleContractFail, "Failed to deliver cargo");
					}
					else
					{
						this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationCivilianContractFail, "Failed to deliver cargo");
					}

					this.World.Contracts.removeContract(this.Contract);
				}
			}

		});
		this.m.States.push({
			ID = "Running_Thieves",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = false;
				}

				if (this.Contract.m.Location != null && !this.Contract.m.Location.isNull())
				{
					this.Contract.m.Location.getSprite("selection").Visible = true;
				}

				this.Contract.m.BulletpointsObjectives = [
					"Follow the thieves\' tracks and return your cargo",
					"Deliver cargo to %recipient% in %objective% about %days% to the %direction% by road"
				];
			}

			function update()
			{
				if (this.Contract.m.Location == null || this.Contract.m.Location.isNull())
				{
					this.Contract.setScreen("Thieves2");
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
			Text = "[img]gfx/ui/events/event_112.png[/img]{%employer% shoves a sizeable crate into your hands before he or you even says a word.%SPEECH_ON%Look at that, the cargo I need delivering has already found someone to ship it off! What wonder!%SPEECH_OFF%He drops the theatrics.%SPEECH_ON%I need that taken to %objective% where a man by the name of %recipient% is waiting for it. It may look small, but I\'m willing to pay good crowns to be sure it gets there safe and sound. You interested? Or is it a little too heavy for your arms?%SPEECH_OFF% | You find %employer% closing a box up. He quickly glances up, as though he\'s been caught with his pants down.%SPEECH_ON%Sellsword! Thank you for coming.%SPEECH_OFF%He locks the latches with a few quick snaps. Then he pats the crate a few times, even leans on it as though it needed one more, fat latch.%SPEECH_ON%This here cargo has to be delivered safely to %objective%. A man by the name of %recipient% is waiting for it. I do not believe the task will be easy, as the cargo is rather precious to certain people who\'d go to great lengths to acquire it, which is why I\'m turning to a man of your... experiences. Are you interested in doing this for me?%SPEECH_OFF% | As you enter %employer%\'s room he and one of his servants are nailing a box shut.%SPEECH_ON%Good seeing you, sellsword. One moment, please. No, idiot, hold the nail that way! I know I hit your thumb before, but I won\'t do it again.%SPEECH_OFF%His servant reluctantly holds a nail while the man hammers it home. Finished, he wipes the sweat off his brow and looks to you.%SPEECH_ON%I need this here crate delivered to %objective% about %days% %direction% by road. It\'s going to %recipient%, you know. Him. Alright, maybe you don\'t know him. What I do know is that this may not ordinarily be your line of work, but I\'m willing to pay some serious crowns for you to see it through. That\'s your real business, right? Earning some crowns?%SPEECH_OFF% | %employer% folds his hands together when he sees you.%SPEECH_ON%This might be a strange question, but how interested are you in making a delivery for me?%SPEECH_OFF%You explain that, for the right price, such a journey would be a welcome departure from the usual killing and dying that goes on around you. The man claps his hands together.%SPEECH_ON%Excellent! Unfortunately, I don\'t expect it to be quite like that. It\'s of enough import to garner unsavory attention, which is why I\'m looking to hire sellswords in the first place. It\'s going to %objective%, %days% or so %direction% of here by road, where a man by the name of %recipient% is waiting for it to fall into his hands. So, you see, this won\'t be the \'departure\' you speak of, but it can be a fine payday if you\'re interested.%SPEECH_OFF% | %employer%\'s men are standing around a bit of cargo. Their employer shoos them away when he sees you.%SPEECH_ON%Welcome, welcome. Good seeing you. I\'m in need of armed guards to have this here package delivered to a man by the name of %recipient% in %objective%. I reckon it\'s about %days% of travel for a company as your. How interested would you be in doing that for me?%SPEECH_OFF% | %employer%\'s got his feet up on his table when you enter. He puts his hands behind his head, looking a little too relaxed for your tastes.%SPEECH_ON%Good tidings, captain. What say you take a leave from all that killing and dying.%SPEECH_OFF%He raises an eyebrow at your response, which is precisely none at all.%SPEECH_ON%Huh, I figured you\'d jump on that opportunity. No matter, it was a lie: I need you to take a certain package to %recipient%, a fellow residing in %objective%. This cargo has undoubtedly garnered some ill-intentioned eyes which is why I need your men watching it for me. If you\'re interested, which you should be, let\'s talk numbers.%SPEECH_OFF% | %employer% welcomes you, waving you in.%SPEECH_ON%Very well, now that you\'re here, would you please shut the door behind you?%SPEECH_OFF%One of the man\'s guards pokes his head around the corner. You smile as you slowly shut him out. Turning around, you find %employer% walking toward a window. He stares out as he talks.%SPEECH_ON%I need something... it\'s a, uh, well you don\'t need to know what it is. I need this \'something\' delivered to a fellow called %recipient%. He\'s waiting for it in %objective%. It\'s important that it actually gets there, important enough for an armed escort for %days% of travel, which is why I\'m turning to you and your company. What say you, mercenary?%SPEECH_OFF% | Dim candles barely light the room enough for you to see, it\'s %employer% sitting behind his desk while his shadows dance on the walls by the tune of flickering lights.%SPEECH_ON%Would you lend your swords to me if I paid you good coin? I need {a small chest | something dear to me | something valuable} delivered safely to %recipient% in %objective%, about %days% of travel %direction% of here. Men have killed each other over this, so you must be ready to defend it with your life.%SPEECH_OFF%He takes a pause, measuring your response.%SPEECH_ON%I will write a sealed letter with instructions to pay you as you deliver the item to my contact in %objective%. What say you?%SPEECH_OFF% | A servant bids you to wait for %employer%, who, he says, will be right with you. And so you wait, and wait, and wait. And finally, as you are about to leave for the second time, %employer% throws open the doors and rushes towards you.%SPEECH_ON%Who\'s this, again? The mercenary?%SPEECH_OFF%His assistant nods and %employer% sets on a smile.%SPEECH_ON%Oh most fortuitous to have you in %townname%, good captain!\n\nIt is imperative that some precious commodities of mine reach %objective% as safely and quickly as possible. You are precisely who I need, for no common brigand would dare attack you and your men.\n\nYes, I\'d like to hire you for escort. Make sure the items are delivered to %recipient%, no detours of course. Can we come to an understanding?%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Let\'s talk money. | How many crowns are we talking about?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{Not interested. | Our travels will not take us there for a while. | This is not the kind of work we\'re looking for.}",
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
			ID = "TaskSouthern",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_112.png[/img]{One of the Vizier\'s aldermen approaches with a retinue of servants. They\'re laboring a modestly sized crate in your general direction.%SPEECH_ON%Crownling, the Vizier has use for you. Have these servants load the crate into your keeping then take it to %recipient% in %objective%, a good %days% by road to the %direction%.%SPEECH_OFF%The alderman bows.%SPEECH_ON%Though a simple task it may be, the Vizier is willing to pay a plentiful sum for the task\'s completion.%SPEECH_OFF% | You find %employer% awaiting in the foyer. He is listening to a row of merchants, each with their own request or offer, and all the while a scribe at his side makes notations in a ledger which unfurls ever longer across the marbled floor. Seeing you, the Vizier snaps his fingers and a man off to the side approaches.%SPEECH_ON%Crownling, the majesty wishes to make use of your services. Take a crate with this labeling to %recipient% in %objective%, about %days% by road. You will be compensated upon arrival.%SPEECH_OFF% | A man with peacock feathers in a jaunty cap approaches you seemingly out of nowhere. He sidles along with a ledger in hand, though the ledger carries the emblem of one of %townname%\'s Viziers and his guard.%SPEECH_ON%%employer% wishes to employ your services, Crownling. You are to handle a fine material, crated away from your devilish eyes of course, and secret it to %recipient% in %objective%, located %days% by road to the %direction%. Once the material is delivered, you will then be paid at the location upon which you have arrived.%SPEECH_OFF%The man rakes the feathers back and briefly shakes his head.%SPEECH_ON%Do you find this offer congruent with your current financial wishes?%SPEECH_OFF% | You\'re first hailed by a pigeon with a note, the note pointing you to a young boy who then takes you to a servant, the servant guides you through a harem hall of naked women after which you arrive to the room of a wealthy merchant.%SPEECH_ON%Ah, finally, you have arrived. I set out a simple task to my indebted and it takes this long to complete? I\'ll have to look into that.%SPEECH_OFF%The merchant tosses you a ledger and simultaneously falls into a pile of cushions.%SPEECH_ON%I, excuse me, the Vizier needs you to take a crate of goods to %recipient% in %objective%, located %days% on the road to the %direction%. You are not to open said goods, only deliver them. If you open the goods, the Vizier will hear of it. And trust me, Crownling, the Vizier only likes to hear of splendid things. That is why I am here instead of the majesty.%SPEECH_OFF%What a courtesy.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Let\'s talk money. | How many crowns are we talking about?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{Not interested. | Our travels will not take us there for a while. | This is not the kind of work we\'re looking for.}",
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
			ID = "Mercenaries1",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{While on the road, a band of well-armed men cross your path. | Marching toward %objective%, a few men interrupt your quiet travels, the clinky-clank of their weapons and armor filling the air as they step into formation. | Your travels, unfortunately, are not to be simple. A number of men have stepped out in front of you, clearly blocking your way. | Some armed and well armored men have come out to make something of a metal impasse. They look as though they intend to make sure you go no farther. | A few of the men come to a stop. You go to the front to figure out what is going on, only to see a line of well-armed men standing in %companyname%\'s way. Well, this should be interesting.} The enemy lieutenant steps forward and pounds his chest with his fist clenched.%SPEECH_ON%{It is us, the %mercband%, that stand before you. Slayers of beasts beyond imagination, the last hope of this godsforsaken land! | The name is %mercband% and we\'re well known throughout this land as splitters of heads, drinkers of kegs and lovers of ladies! | \'Tis the legendary %mercband% standing before you. It is we, saviors of %randomtown% and slayers of the false king! | Behold my proud band, the %mercband%! We, who fought off a hundred orcs to save a city from certain doom. What have you to your name? | You\'re talking to a man of the %mercband%. No common brigand, foul greenskin, bag of coins or skirt ever escaped from us!}%SPEECH_OFF%After the man finishes his posturing and personal pontificating, he points at the cargo you are carrying.%SPEECH_ON%{So now that you realize the danger you are in, why don\'t you go ahead and hand that cargo over? | I hope you realize who you\'ve come to face, pathetic sellsword, so that you may best make sure your men make it to their beds tonight. All you need to do is hand over the cargo and we won\'t have to add you to the history of %mercband%. | Ah, I bet you\'d like to be a part of our history, wouldn\'t you? Well, good news, all you gotta do is not hand over that cargo and we\'ll scribble you in with our swords. Of course, you can escape the scribe\'s pen if you just give us that cargo. | Now, if it isn\'t the %companyname%. As much as I\'d like add you to our list of victories, I\'ll give you a chance here, mercenary to mercenary. All you have to do is hand over that cargo and we\'ll be on our way. How\'s that sound?}%SPEECH_OFF%{Hmm, well it was a bombastic request if nothing else. | Well, the theatrics were pretty entertaining if nothing else. | You don\'t quite understand the need for showmanship, but there\'s little doubt about the seriousness of this new situation you\'ve found yourself in. | While you appreciated the superlatives and hyperbole, there remains the very terse reality that these men do actually mean business.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "If you want it, come and take it!",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Mercs";
						p.Music = ::Const.Music.NobleTracks;
						p.PlayerDeploymentType = ::Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = ::Const.Tactical.DeploymentType.Line;
						::Const.World.Common.addUnitsToCombat(p.Entities, ::Const.World.Spawn.MercenariesLow, 120 * this.Contract.getDifficultyMult(), this.World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				},
				{
					Text = "It\'s not worth dying over. Take that damn cargo and be gone.",
					function getResult()
					{
						return "Mercenaries2";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Mercenaries2",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{Not wanting a fight, you hand the cargo over. They laugh as they take it off your hands.%SPEECH_ON%Good choice, mercenary. Maybe someday you\'ll be the one doing the threatening.%SPEECH_OFF% | The cargo, whatever it is, isn\'t worth the lives of your men. You hand the crate over and the mercenaries take it. They laugh at you as you leave.%SPEECH_ON%Like charming a whore!%SPEECH_OFF% | This does not seem like the time or place to be sacrificing your men in the name of %employer%\'s delivery service. You hand the cargo over. The mercenaries take it then make their leave, their lieutenant flipping you a crown that spins its way into the mud.%SPEECH_ON%Get yerself a shinebox, kid, this work ain\'t cut out for you.%SPEECH_OFF% | The mercenaries are well armed and you don\'t know if you could sleep at night knowing you spent the lives of your men just for some silly crate carrying the old gods know what. With a nod, you hand the cargo over. The mercenary band gladly takes it from you, their lieutenant pausing to nod back with respect.%SPEECH_ON%A wise choice. Don\'t think I didn\'t make many like it when I was coming up.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Hrm...",
					function getResult()
					{
						this.Flags.set("IsMercenaries", false);
						this.Flags.set("IsMercenariesDialogTriggered", true);

						if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == ::Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationNobleContractFail, "Failed to deliver cargo");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationCivilianContractFail, "Failed to deliver cargo");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(::Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(::Const.World.Assets.RelationCivilianContractFail * 0.5);
						}

						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "BountyHunters1",
			Title = "Along the road...",
			Text = "[img]gfx/ui/events/event_07.png[/img]{While on the roads, you come across a band of bounty hunters. Their prisoner calls out to you, his voice cracking as he begs for you to save him. He claims he is an innocent man. The bounty hunters tell you to fark off and die. | You\'re traveling the roads when you come across a group of well-armed bounty hunters. They\'re yanking along a man shackled from head to toe.%SPEECH_ON%You want no part of this fellow.%SPEECH_OFF%One man says, striking his prisoner in the back of the shins. The man yelps and crawls to you on bloodied hands and knees.%SPEECH_ON%They\'re all liars! These men will kill me even though I\'ve done nothing wrong! Save me, sirs, I beg of you!%SPEECH_OFF% | You come across a large band of bounty hunters, your two groups oddly mirroring one another, though your purposes in this world clearly diverge. They\'re transporting a prisoner who has been chained and his mouth stuffed with a rag. The man yells out to you, almost pleading, choking on his words until he\'s red in the face. One of the bounty hunters spits.%SPEECH_ON%Pay him no mind, stranger, and get on down the road. Best there be no trouble between men such as we.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "This isn\'t any of our business.",
					function getResult()
					{
						return 0;
					}

				},
				{
					Text = "Perhaps we can buy the prisoner?",
					function getResult()
					{
						return ::Math.rand(1, 100) <= 50 ? "BountyHunters1" : "BountyHunters1";
					}

				},
				{
					Text = "If you want it, come and take it!",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Mercs";
						p.Music = ::Const.Music.NobleTracks;
						p.PlayerDeploymentType = ::Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = ::Const.Tactical.DeploymentType.Line;
						::Const.World.Common.addUnitsToCombat(p.Entities, ::Const.World.Spawn.Mercenaries, 140 * this.Contract.getDifficultyMult(), this.World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Thieves1",
			Title = "During camp...",
			Text = "[img]gfx/ui/events/event_05.png[/img]{You raise up from a nap and turn over, looking for the package as though it were a lover. But she\'s not there and neither is the cargo. Quickly getting to your feet, you begin ordering the men to attention. %randombrother% runs up and says he\'s tracked some footprints leading off from the site. | While taking a rest, you hear a disturbance somewhere in the camp. You rush to it to find %randombrother% face down in the dirt, rubbing the back of his head.%SPEECH_ON%Sorry sir, I was taking a piss, and then they went on ahead and took it out of me. Also, they stole the package.%SPEECH_OFF%You tell him to repeat that last part.%SPEECH_ON%Goddamn thieves have stolen the goods!%SPEECH_OFF%Time to track those bastards down and get it back. | Naturally, it wouldn\'t be an ordinary trip. No, this world is too shite for that to be the case. It appears thieves have taken off with the cargo. Luckily, they\'ve left a hell of a lot of evidence, namely footprints and dragmarks from toting the package around. They should be easy to find... | Just once you\'d like to have a nice walk from one town to the next. Instead, your agreement with %employer% has attracted trouble once again. Thieves, somehow, managed to sneak into the camp and make off with the cargo. The good news is that they didn\'t manage to sneak back out: you\'ve found their footprints and they won\'t be hard to follow.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We follow their tracks!",
					function getResult()
					{
						this.Contract.setState("Running_Thieves");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Thieves2",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img]{Thief blood runs thick. You manage to find your employer\'s goods still in the camp, all locked and safe. He doesn\'t need to know about this little excursion. | Well, everything\'s right where it should be. %employer%\'s cargo was found underneath a thief\'s writhing body. You made sure to kick him off before running him through. Wouldn\'t want to get blood on the package, after all. | Killing off the last of the thieves, you and the men spread out through the brigands\' camp looking for the package. %randombrother% spots it right quick, the container still held in the clutches of a dead fool. The mercenary fumbles with the corpse\'s grasp and, in frustration, simply cuts the arms off the bastard. You retrieve the package and hold it a little closer for the trip going forward. | Staring over the bodies of the felled thieves, you wonder if %employer% needs to know about this. The package looks alright. Some blood and bone on it, but you can rub that right off. | The package\'s a little scuffed, but it\'ll be fine. Alright, there\'s blood all over it and a thief\'s degloved finger is all smashed up into one of the latches. Those issues aside, everything is perfectly fine.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Back where it belongs.",
					function getResult()
					{
						this.Flags.set("IsThieves", false);
						this.Flags.set("IsStolenByThieves", false);
						this.Contract.setState("Running");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EnragingMessage1",
			Title = "At %objective%",
			Text = "{The cemetery is layered in fog - that or a thick miasma given off by the dead. Wait... that IS the dead! To arms! | You eye a tombstone with a mound of soil unearthed at its base. Blots of mud lead away like a crumb trail. There are no shovels... no men... As you follow the lead, you come across a band of undead moaning and groaning... now staring at you with insatiable hunger... | A man lingers deep in the rows of tombstones. He seems to be wavering, as though ready to pass out. %randombrother% comes to your side and shakes his head.%SPEECH_ON%That\'s no man, sir. There\'s undead afoot.%SPEECH_OFF%Just as he finishes talking, the stranger in the distance slowly turns and there in the light reveals he\'s missing half his face. | You come to find many of the graves are emptied. Not just emptied, but unearthed from below. This is not the work of graverobbers...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To arms!",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact1",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_55.png[/img]{While on the move, you notice that something else is moving, too: the cargo. The lid on it is jumping around and there\'s a strange glow emerging from its sides. %randombrother% approaches, looks at it, then looks at you.%SPEECH_ON%Should we open it, sir? Or I can take it and throw it in the closest pond because none of that right there is alright.%SPEECH_OFF%You jab the man and ask if he\'s scared. | Moving along the paths, you begin to hear a low hum emanating from the package %employer% had given you. %randombrother% is standing beside it, poking it with a stick. You slap him back. He explains himself.%SPEECH_ON%Sir, there\'s something that ain\'t right with the cargo we\'re tugging...%SPEECH_OFF%You take a good look at it. There\'s a faint color brimming at the edges of the lid. As far as you know, fire can\'t breathe in such a space, and the only thing else that glows in the dark are the moons and the stars. You worry that curiosity is starting to get the better of you... | The cargo rests in the wagon beside you, jostling about to the tilts and turns of the paths. Suddenly, it begins to hum and you swear you saw the lid float upward for just a second. %randombrother% glances over.%SPEECH_ON%You alright, sir?%SPEECH_OFF%Just as he finishes talking, the lid explodes outward, a swirl of colors, mist, ash, fiery heat and brutish cold. You throw your arms up, shielding yourself, and when you take a peek through your elbows the package is completely still, the lid back on. You exchange a glance with the sellsword, then both of you stare at the cargo. This might be a little more than an ordinary delivery... | A low hum emanates from nearby. Thinking a bee hive nearby, you instinctively duck, only to realize the sound is coming from the cargo %employer% had handed you. The lid atop the container is rattling side to side, jostling the latches and nails that are supposed to keep it there. %randombrother% looks a little frightened.%SPEECH_ON%Let\'s just leave it here. That thing ain\'t right.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "I want to know what\'s going on.",
					function getResult()
					{
						return "EvilArtifact2";
					}

				},
				{
					Text = "Leave that thing alone.",
					function getResult()
					{
						this.Flags.set("IsEvilArtifact", false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact2",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_73.png[/img]{Curiosity gets the best of you. Slowly you start prying at the lid. %randombrother% takes a step back and protests.%SPEECH_ON%I think we should leave it alone, sir. I mean c\'mon, look at it.%SPEECH_OFF%Ignoring him, you tell the men it\'s going to be alright, and then you lift the lid up.\n\n It isn\'t alright. The explosion knocks you off your feet. Horrible shapes and shrieks swirl all around you. The men instinctively arm themselves as the piloted specters spear into the earth. There the ground lifts in mounds, and there, too, the earth begins to groan. You watch as hands shoot forth, dragging decrepit bodies from their pit. The dead live again and surely they mean to add to their ranks! | Against anyone\'s best judgment, you pry the cargo open. At first, there is nothing. It\'s just an empty box. %randombrother% nervously laughs.%SPEECH_ON%Well... I guess that\'s it then.%SPEECH_OFF%But that can\'t be it, can it? Why would %employer% have you delivering an empty container unless -- \n\n You wake up to a ringing slowly fading from your ears. Turning over, you see that the box has completely evaporated, a flurry of snowy sawdust all that remains of it. %randombrother% rushes over, picking you up and dragging you toward the rest of the company. They point, their mouths moving, shouting...\n\n A mob of well-armed men are... shuffling your way? As you get a better sight of them, you realize that they are armed with old wooden shields painted with odd spiritual rites, and their armor is of shapes and sizes you have never seen before, as though they were crafted by men just learning the trade, yet still well learned in what they had learned thus far. These are like ancients... the first men. | %randombrother% shakes his head as you go to pick up the lid. With some effort, it\'s pried open and you quickly step back, expecting the worst. But there\'s nothing. Not even a sound comes out of the box. You take a sword and rattle it around in the empty box, looking for a secret compartment or something. %randombrother% laughs.%SPEECH_ON%Hey, we\'re just delivering a bunch of air! And to think I thought that damned thing was too heavy!%SPEECH_OFF%Just then, the box lifts briefly into the air, spins, and smashes itself into the ground. It breaks perfectly, noiselessly, and with no wasted movements, every piece of wood laid against the grass like ancient stoneworks. An incorporeal shape leers up from the splintered rites, grinning as it twists.%SPEECH_ON%Oh humans, it is truly good to see you again.%SPEECH_OFF%The voice is like ice down your back. You watch as the specter shoots into the sky then slams back down, spearing into the very earth. Not a second passes before the ground is erupting as bodies begin to clamber out. | The box magnetizes you. Without hesitation, you crank the cargo open and take a look inside. You smell before you see - a horrid stench overwhelming you almost to the point of blindness. One of the men pukes. Another retches. When you look back at the box, blackened tendrils of smoke are sifting out of it, stretching long and far, probing the ground as they go. When they find what they\'re looking for, they dive into the earth, yanking up bones of dead men like a lure would a fish. | Ignoring the worries of a few of the men, you bust the package open. A pile of heads are to be found, their glowing eyes flickering awake. Their jaws crackle open, shifting from unmoved states to rattle in laughter. You quickly close the box, but a force pushes it back open. You struggle with it, %randombrother% and a few others trying to help, but it\'s almost as if the utterly silent winds of a storm are pushing back against you.\n\nA bare moment later, you\'re all thrown back, the lid of the crate soaring into the sky, ushered upward by a gust of blackened souls. They zip around, combing the earth, then collectively position opposite the %companyname%. There you watch in horror as the incorporeal begins to take shape, the foggy mists of souls hardening into the very real bones of souls lost long ago. And, of course, they come armed, the crackling jawbones still clattering with hollow laughter.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To arms!",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "EvilArtifact";
						p.Music = ::Const.Music.UndeadTracks;
						p.PlayerDeploymentType = ::Const.Tactical.DeploymentType.Center;
						p.EnemyDeploymentType = ::Const.Tactical.DeploymentType.Circle;

						if (this.Flags.get("IsCursedCrystalSkull"))
						{
							this.World.Flags.set("IsCursedCrystalSkull", true);
							p.Loot = [
								"scripts/items/accessory/legendary/cursed_crystal_skull"
							];

							::Const.World.Common.addUnitsToCombat(p.Entities, ::Const.World.Spawn.Zombies, 300, this.World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getID());
						}
						else ::Const.World.Common.addUnitsToCombat(p.Entities, ::Const.World.Spawn.Zombies, 120 * this.m.DifficultyMult, this.World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getID());

						this.World.Contracts.startScriptedCombat(p, false, false, false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact3",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_55.png[/img]{The battle over, you quickly rush back over to the artifact, finding it floating in the air. %randombrother% runs up to your side.%SPEECH_ON%Destroy it, sir, before it causes any more trouble!%SPEECH_OFF% | Your men weren\'t the only thing to survive the battle - the artifact, or whatever remains of its pulsing power, floats innocently where you\'d last seen it. The thing is an orb swirling with energy, occasionally rattling, sometimes whispering a language you know not of. %randombrother% nods toward it.%SPEECH_ON%Smash it, sir. Smash it and let us be done with this horror.%SPEECH_OFF% | Such power was not meant for this world! The artifact has taken the shape of an orb the size of your fist. It floats off the ground, humming as though singing a song from another world. The thing almost seems to be waiting for you, like a dog would wait its master.%SPEECH_ON%Sir.%SPEECH_OFF%%randombrother% tugs on your shoulder.%SPEECH_ON%Sir, please, destroy it. Let us not take that thing another step with us!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We have to destroy it.",
					function getResult()
					{
						return "EvilArtifact4";
					}

				},
				{
					Text = "We\'re paid to deliver this, so that\'s what we\'ll do.",
					function getResult()
					{
						this.Flags.set("IsEvilArtifact", false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact4",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_55.png[/img]{You take out your sword and stand before the artifact with the blade slowly raised over your head.%SPEECH_ON%Don\'t do it!%SPEECH_OFF%Glancing over your shoulder, you see %randombrother% and the other men scowling at you. Blackness surrounds them and the whole world as far as your eye can see. Their eyes glow red, pulsing furiously with every spoken word.%SPEECH_ON%You shall burn forever! Burn forever! Destroy it and you shall burn! Burn! BURN!%SPEECH_OFF%Screaming, you turn around and slice your sword through the relic. It splits effortlessly in two and a wave of color sweeps back into your world. Sweat pours from your forehead as you find yourself leaning on the pommel of your weapon. You look back to see your mercenary company staring at you.%SPEECH_ON%Sir, are you alright?%SPEECH_OFF%You sheathe your sword and nod, but you\'ve never felt so horrified in all your life. %employer% won\'t be happy, but he and his anger be damned! | Just as soon as the thought of destroying the relic crosses your mind, so too does a wave of horrified screaming. The shrill crying of women and children, their voices cracking with terror as though they had come running at you all on fire. They scream at you in hundreds of languages, but every so often the one you know passes you and it\'s always with the same word: DON\'T.\n\n You draw your sword and swing it back over your head. The artifact hums and vibrates. Smoky tendrils waft off it and a brutish heat washes over you. DON\'T.\n\n You steady your grip.\n\n Davkul. Yekh\'la. Imshudda. Pezrant. DON\'T.\n\nYou swallow and steady your aim.\n\n DON\'T.RAVWEET.URRLA.OSHARO.EBBURRO.MEHT\'JAKA.DON\'T.DON\'T.DON\'T.DO--\n\n The strike is true, the word is lost, the artifact falls to the earth in twine. You fall with it, to your knees, and a few of the company\'s brothers come to lift you back up. %employer% won\'t be happy, but you can\'t help but feel as though you\'ve spared this world a horror it need not ever see or hear.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "It\'s done.",
					function getResult()
					{
						this.Flags.set("IsEvilArtifact", false);

						if (this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).getType() == ::Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationCivilianContractFail, "Failed to deliver cargo");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.m.Destination.getFactions()[0]).addPlayerRelation(::Const.World.Assets.RelationNobleContractFail, "Failed to deliver cargo");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(::Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(::Const.World.Assets.RelationCivilianContractFail * 0.5);
						}

						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "EvilArtifact5",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_55.png[/img]{You shake your head and get another crate, carefully pushing the floating artifact into it then closing the lid. %employer% was paying you good money and, well, you plan on seeing it through. But for some reason you\'re not sure if that choice is your own, or if this strange relic\'s whispering is guiding your hand for you. | You go and retrieve a wooden chest and lift it up to the artifact, quickly closing the lid over it. A few of the mercenaries shake their head. It\'s probably not the best of ideas, but for some reason you fill compelled to finish your task. | Better judgment says you should destroy this horrible relic, but better judgment fails once more. You take a wooden chest and move it over the artifact before closing the lid and snapping shut the latches. You\'ve no idea what you are doing this, but your body is filled with newfound energy as you get ready to get back on the road.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We should move on.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_20.png[/img]{%recipient%\'s waiting for you as you enter the town. He hurriedly takes the cargo off your hands.%SPEECH_ON%Oh, ohhh I did not think you would get here.%SPEECH_OFF%His grubby fingers dance along the chest carrying the cargo. He turns around and barks an order to one of his men. They step forward and hand you a satchel of crowns. | Finally, you\'ve made it. %recipient% is standing there in the middle of the road, his hands clasped over his stomach, a slick grin on his cheeky face.%SPEECH_ON%Sellsword, I was not sure you\'d make it.%SPEECH_OFF%You lug the cargo up and hand it over.%SPEECH_ON%Oh yeah, and why do you say that?%SPEECH_OFF%The man takes the box and hands it off to a robed man who quickly hurries away with it tucked under an arm. %recipient% laughs as he hands you a satchel of crowns.%SPEECH_ON%The roads are rough these days, are they not?%SPEECH_OFF%You understand he\'s making small talk, anything to get your attention off the cargo you just handed over. Whatever, you got your pay, that\'s good enough for you. | %recipient% welcomes you and a few of his men hurry over to take the cargo. He claps you on the shoulders.%SPEECH_ON%I take it your journey went well?%SPEECH_OFF%You spare him the details and inquire about your pay.%SPEECH_ON%Bah, a sellsword through and through. %randomname%! Get this man what he deserves!%SPEECH_OFF%One of %recipient%\'s bodyguards walks over and hands you a small chest of crowns. | After some looking, a man asks who you\'re looking for. When you say %recipient%, he points you out toward a nearby paddock where a man is strutting about on a rather opulent looking horse.\n\n You walk on over and the man rears the steed and asks if that\'s the cargo %employer% sent. You nod.%SPEECH_ON%Leave it there at your feet. I\'ll come and get it.%SPEECH_OFF%You don\'t, instead asking about your pay. The man sighs and whistles to a bodyguard who hurries over.%SPEECH_ON%See to it that this sellsword gets the pay he deserves.%SPEECH_OFF%Finally, you put the crate on the ground and make your leave.} ",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						local playerRoster = this.World.getPlayerRoster().getAll();
						local xp = this.Contract.m.Payment.getOnCompletion() * 0.25;

						foreach( bro in playerRoster )
						{
							bro.addXP(xp);
							bro.updateLevel();
						}

						if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == ::Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(::Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(::Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
						}

						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.RecipientID).getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns"
				});
				this.Contract.m.Home.setResources(this.Contract.m.Home.getResources() + this.Contract.m.Home.getResources() * 0.05);
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "At %objective%",
			Text = "[img]gfx/ui/events/event_163.png[/img]{%SPEECH_START%Ah, the Crownling.%SPEECH_OFF%The voice comes from a nearby alley. Usually that means you\'re about to have some coin lifted off ya, but instead find a man offering you gold.%SPEECH_ON%I am %recipient%, and that package belongs to me. Send %employer% my regards, or don\'t, I don\'t care.%SPEECH_OFF%The man steals away and is gone just as soon as he came. | %recipient% is a squat man and he carries the Vizier\'s emblem and signage as though it were as heavy as the crate you just brought him.%SPEECH_ON%I\'ve given the Vizier much, and what does he use to repay me? A Crownling\'s sweat. May the Gilder blink when gazing upon that man\'s future.%SPEECH_OFF%You say nothing to this, in part because you wonder if it is a \'test\' to see if you\'ll agree with him and turn yourself out to be an enemy of the ever majestic Vizier. The man stares at you for a moment, then shrugs and continues.%SPEECH_ON%I have your payment here. The coin is all accounted for, though I will not take offense if you wish to count it yourself. Ah, I see you already are. Good. See? It\'s all there. Now run along little Crownling.%SPEECH_OFF% | You find %recipient% holding court over a small throng of children. He quickly singles you and teaches them a lesson about keeping to their studies lest they end up like you. After the kids are dismissed, the man comes over with a satchel of crowns.%SPEECH_ON%My men told me you had arrived and that the material was still in good standing. Here is your motly payment, Crownling.%SPEECH_OFF% | You enter %recipient%\'s home where the package is finally dropped off and whisked away by servants. Staring at you from a comfortable looking chair, %recipient% asks if your journey went well. You state that idle talk does not fill your pockets and then inquire about your pay. The man raises an eyebrow.%SPEECH_ON%Ah, have I offended the Crownling with my kind, civilized sensibilities? How dare I. Well then, your pay is in the corner and it is in full as agreed upon.%SPEECH_OFF% | %recipient% is pontificating about the nature of birds to a mirror. When he sees you in the reflection, he turns around and speaks as though nothing unusual had been going on at all.%SPEECH_ON%A Crownling. Of course the Vizier sends a Crownling. I like to imagine you did not dare profane the materials of the crate with your eyes, but I can\'t even trust such professionalism out of your sort. But you can expect it of me: your payment is in the corner, and in full.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "Crowns well deserved.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						local playerRoster = this.World.getPlayerRoster().getAll();
						local xp = this.Contract.m.Payment.getOnCompletion() * 0.25;

						foreach( bro in playerRoster )
						{
							bro.addXP(xp);
							bro.updateLevel();
						}

						if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getType() == ::Const.FactionType.OrientalCityState)
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationNobleContractSuccess, "Delivered some cargo");
						}
						else
						{
							this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationCivilianContractSuccess, "Delivered some cargo");
						}

						local recipientFaction = this.Contract.m.Destination.getFactionOfType(::Const.FactionType.Settlement);

						if (recipientFaction != null)
						{
							recipientFaction.addPlayerRelation(::Const.World.Assets.RelationCivilianContractSuccess * 0.5, "Delivered some cargo");
						}

						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				local xpGained = ::Math.round(this.Contract.m.Payment.getOnCompletion() * 0.25 * ::Const.Combat.GlobalXPMult);
				this.Characters.push(this.Tactical.getEntityByID(this.Contract.m.RecipientID).getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + ::Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] Crowns and [color=" + ::Const.UI.Color.PositiveEventValue + "]" + xpGained + "[/color] Experience"
				});
				this.Contract.m.Home.setResources(this.Contract.m.Home.getResources() + this.Contract.m.Home.getResources() * 0.05);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		local days = this.getDaysRequiredToTravel(this.m.Flags.get("Distance"), ::Const.World.MovementSettings.Speed, true);
		_vars.push([
			"objective",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.m.Destination.getName()
		]);
		_vars.push([
			"recipient",
			this.m.Flags.get("RecipientName")
		]);
		_vars.push([
			"mercband",
			::Const.Strings.MercenaryCompanyNames[::Math.rand(0, ::Const.Strings.MercenaryCompanyNames.len() - 1)]
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : ::Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Destination.getTile())]
		]);
		_vars.push([
			"days",
			days <= 1 ? "a day" : days + " days"
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
			}

			if (this.m.Location != null && !this.m.Location.isNull())
			{
				this.m.Location.getSprite("selection").Visible = false;
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive() || !this.m.Destination.isAlliedWithPlayer())
		{
			return false;
		}

		return true;
	}

	function onIsTileUsed( _tile )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull() && _tile.ID == this.m.Destination.getTile().ID)
		{
			return true;
		}

		return false;
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

		if (this.m.Location != null && !this.m.Location.isNull())
		{
			_out.writeU32(this.m.Location.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		_out.writeU32(this.m.RecipientID);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		local location = _in.readU32();

		if (location != 0)
		{
			this.m.Location = this.WeakTableRef(this.World.getEntityByID(location));
		}

		this.m.RecipientID = _in.readU32();

		if (!this.m.Flags.has("Distance"))
		{
			this.m.Flags.set("Distance", 0);
		}

		this.contract.onDeserialize(_in);
	}

});

