this.raze_attached_location_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Settlement = null
	},
	function setSettlement( _s )
	{
		this.m.Flags.set("SettlementName", _s.getName());
		this.m.Settlement = this.WeakTableRef(_s);
	}

	function setLocation( _l )
	{
		this.m.Destination = this.WeakTableRef(_l);
		this.m.Flags.set("DestinationName", _l.getName());
	}

	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = 0.85;
		this.m.Type = "contract.raze_attached_location";
		this.m.Name = "Raze Location";
		this.m.Description = "As the war rages one of the lords wants you to target key locations. Travel to enemy house lands and raze their key locations.";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		local s = this.World.EntityManager.getSettlements()[this.Math.rand(0, this.World.EntityManager.getSettlements().len() - 1)];
		this.m.Destination = this.WeakTableRef(s.getAttachedLocations()[this.Math.rand(0, s.getAttachedLocations().len() - 1)]);
		this.m.Flags.set("PeasantsEscaped", 0);
		this.m.Flags.set("IsDone", false);
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		this.m.Payment.Pool = ::Z.Economy.Contracts[this.m.Type] * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
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
					"Raze " + this.Flags.get("DestinationName") + " near " + this.Flags.get("SettlementName")
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
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().get("Betrayed") && this.Math.rand(1, 100) <= 75)
				{
					this.Flags.set("IsBetrayal", true);
				}
				else
				{
					this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Peasants, this.Math.rand(90, 150));

					if (this.Math.rand(1, 100) <= 25)
					{
						this.Flags.set("IsMilitiaPresent", true);
						this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.Militia, this.Math.min(300, 80 * this.Contract.getScaledDifficultyMult()));
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
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setFaction(this.Const.Faction.Enemy);
					this.Contract.m.Destination.setAttackable(true);
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Flags.get("IsDone"))
				{
					if (this.Flags.get("IsBetrayal"))
					{
						this.Contract.setScreen("Betrayal2");
					}
					else
					{
						this.Contract.setScreen("Done");
					}

					this.World.Contracts.showActiveContract();
				}
			}

			function onEntityPlaced( _entity, _tag )
			{
				if (_entity.getFlags().has("peasant") && this.Math.rand(1, 100) <= 75)
				{
					_entity.setMoraleState(this.Const.MoraleState.Fleeing);
					_entity.getBaseProperties().Bravery = 0;
					_entity.getSkills().update();
					_entity.getAIAgent().addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat_always"));
				}

				if (_entity.getFlags().has("peasant") || _entity.getFlags().has("militia"))
				{
					_entity.setFaction(this.Const.Faction.Enemy);
					_entity.getSprite("socket").setBrush("bust_base_militia");
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (this.Contract.m.Destination.getTroops().len() == 0)
				{
					this.onCombatVictory("RazeLocation");
					return;
				}
				else if (!this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);

					if (this.Flags.get("IsBetrayal"))
					{
						this.Contract.setScreen("Betrayal1");
					}
					else if (this.Flags.get("IsMilitiaPresent"))
					{
						this.Contract.setScreen("MilitiaAttack");
					}
					else
					{
						this.Contract.setScreen("DefaultAttack");
					}

					this.World.Contracts.showActiveContract();
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.Contract.m.Destination.getPos());
					p.CombatID = "RazeLocation";
					p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[this.Contract.m.Destination.getTile().Type];
					p.Tile = this.World.getTile(this.World.worldToTile(this.World.State.getPlayer().getPos()));
					p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
					p.LocationTemplate.Template[0] = "tactical.human_camp";
					p.LocationTemplate.Fortification = this.Const.Tactical.FortificationType.None;
					p.LocationTemplate.CutDownTrees = true;
					p.LocationTemplate.AdditionalRadius = 5;
					p.PlayerDeploymentType = this.Flags.get("IsEncircled") ? this.Const.Tactical.DeploymentType.Circle : this.Const.Tactical.DeploymentType.Edge;
					p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
					p.Music = this.Const.Music.CivilianTracks;
					p.IsAutoAssigningBases = false;

					foreach( e in p.Entities )
					{
						e.Callback <- this.onEntityPlaced.bindenv(this);
					}

					p.EnemyBanners = [
						"banner_noble_11"
					];
					this.World.Contracts.startScriptedCombat(p, true, true, true);
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (_actor.getFlags().has("peasant"))
				{
					this.Flags.set("PeasantsEscaped", this.Flags.get("PeasantsEscaped") + 1);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "RazeLocation")
				{
					this.Contract.m.Destination.setActive(false);
					this.Contract.m.Destination.spawnFireAndSmoke();
					this.Flags.set("IsDone", true);
				}
				else if (_combatID == "Defend")
				{
					this.Flags.set("IsDone", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "RazeLocation")
				{
					this.Flags.set("PeasantsEscaped", 100);
				}
				else if (_combatID == "Defend")
				{
					this.Flags.set("IsDone", true);
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
				this.Contract.m.Destination.getSprite("selection").Visible = false;
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.Contract.m.Destination.setOnCombatWithPlayerCallback(null);
				this.Contract.m.Destination.setFaction(this.Contract.m.Destination.getSettlement().getFaction());
				this.Contract.m.Destination.clearTroops();
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("PeasantsEscaped") == 0)
					{
						this.Contract.setScreen("Success1");
					}
					else if (this.Math.rand(1, 100) >= this.Flags.get("PeasantsEscaped") * 10)
					{
						this.Contract.setScreen("Success2");
					}
					else
					{
						this.Contract.setScreen("Failure1");
					}

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
			Text = "[img]gfx/ui/events/event_61.png[/img]{%employer% throws back his silken sleeves and cracks his knuckles.%SPEECH_ON%I hope I can entrust you with a most delicate matter as my family cannot be connected to what I am about to tell you.%SPEECH_OFF%You nod as though a sellsword is often asked to keep a secret. The man continues.%SPEECH_ON%The town of %settlementname% is too weak to protect itself and the people are clamoring for protection from brigands. We, the house of %noblehousename%, are the only ones who can truly offer the safety they seek. Unfortunately, the local council is too blind to see this. They are convinced they can guard their people themselves. Let us prove them wrong.\n\n I want you to burn the %location% close to %settlementname% to the ground and kill the peasantry there. Make it look like brigands did it. I\'m sure you are familiar with their work. Now...%SPEECH_OFF%%employer% leans in close.%SPEECH_ON%...let me be very clear and I need you to listen very closely. There must be no survivors that could tell who really attacked them. None! Understand? Good. Return to me once the deed is done.%SPEECH_OFF% | %employer% stares at a pile of scrolls before angrily swiping them off his table in a flurry of papery madness.%SPEECH_ON%The councilmen of %settlementname% think they can protect their little town from brigands, but I know they can\'t. I know they need my protection! And I offered it at such a reasonable price...%SPEECH_OFF%He calms down just long enough to glance at you.%SPEECH_ON%I got it. I know what to do. You... you\'re familiar with a brigand\'s doings, yes? Of course. So how about you... go to %location% outside of %settlementname% and... do what a brigand what do. Of course, make it actually look like a brigands doing... after that, surely the town will contract me to protect them! And then they will be safe!%SPEECH_OFF% | %employer% has his hands tented, the tips of them pressed against his forehead. He lets out a long sigh.%SPEECH_ON%I\'ve tried to deal with these people of %settlementname% for quite some years now, but I\'m beginning to think I\'ll have to take drastic measures to get what I want. The council there won\'t pay me to protect their village because they think they can do it themselves. They say that they\'ve been safe from harm for quite some time now. So what if... they weren\'t? What if you were to go in there, dressed as a brigand of course, and teach them that without the aid of %noblehousename% nobody is safe! Of course, you mustn\'t tell anyone of our little talk here... What say you, mercenary?%SPEECH_OFF% | %employer%\'s staring out the window as you settle into a seat.%SPEECH_ON%Stand up, sellsword. I don\'t like to whisper down, it gets me to raise my voice and with what I\'m about to tell you I don\'t think I want to be doing that.%SPEECH_OFF%You stand up and lend your ear.%SPEECH_ON%%settlementname% name has refused my offer of protection. They\'ve decided to go it alone. Not only are they not paying %noblehousename%, but they\'re besmirching our name. If this village refuses our protection, what will others do? I need you to take the \'part\' of a brigand, go there, and teach them what it is to go in this world without %noblehousename% by your side! Of course, discretion is of the utmost importance. Nothing I\'ve said here must leave this room.%SPEECH_OFF% | %employer%\'s rubbing an apple raw, peeling back the rind with the grit of his thumb.%SPEECH_ON%My father used to tell me, if you don\'t have a name that raises respect just by its sound, then you have no name at all. Unfortunately, %settlementname% does not respect the name of %noblehousename%. They\'ve refused my offers of protection and have insulted my family. I want you to pay them back for this. I want you to go there, not as mercenaries but as brigands, and show them what happens in a world without %noblehousename%\'s protection. Of course, you must be thorough, sellsword. You mustn\'t tell anyone of what we say in this here room.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Let\'s talk money. | How many crowns are we talking about? | What will the pay be? | For the right price, everything can be done.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{That\'s not our line of work. | That\'s not for the %companyname%.}",
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
			ID = "DefaultAttack",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_16.png[/img]{You reach the %location%. Peasants are out and about just as you figured. This will be like spearing fish in a barrel. Now the only question is: how do you want to approach? | %location% is a little more serene than you thought it\'d be. A few peasants mosey about, chucking sickles and hoes around as they banter about this or that. You hear them barking with laughter over a joke. What a shame the rest of their day won\'t be nearly as funny. | You pass through some tall weeds to get a good look at %location%. There are a few peasants walking about, completely oblivious to the cat-like destruction stalking through the grass just outside their little hamlet. Scanning the area, you begin to plot your next move. | %location% is quiet, a little too quiet for a place targeted for destruction. You shake your head at the cruelty of this world, but then remind yourself that this is a job you\'re going to be getting well paid for. That makes it a little easier. | Killing peasants was never really your forte. Not that you couldn\'t do it, but the simplicity of it always rubbed you the wrong way. Like killing a legless dog, or stepping on a blind frog. But nobody ever paid you much to put a mutt to sleep. How ironic that these peasants would have been safer as mongrels than humans.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Encircle them!",
					function getResult()
					{
						this.Flags.set("IsEncircled", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				},
				{
					Text = "Sweep through from one side!",
					function getResult()
					{
						this.Flags.set("IsEncircled", false);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "MilitiaAttack",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_141.png[/img]{You reach %location% and immediately tell your men to hold and get down. Peasants are afoot, but so are militia. This was not part of the deal and you must reassess the situation accordingly. | As you near %location%, %randombrother% returns to you with a scouting report. Apparently, there are not just peasants there. A few militiamen are in the area. If you are to do this, you\'ll have to fight them, too. What now? | Militia! They were not part of the plan at all! If you are to proceed, you\'ll have to take care of them along with the peasants. Time to think carefully about this... | What is this? You see militiamen marching around %location%. Now you\'ll have to do some real fighting if you want to complete your task. | As you ready to attack %location%, %randombrother% points out something in the distance. Slimming your eyes, you bring into focus a handful of what look like militiamen. This was not part of the agreement! You can still go through with the attack, but there will be some resistance...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Encircle them!",
					function getResult()
					{
						this.Flags.set("IsEncircled", true);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				},
				{
					Text = "Sweep through from one side!",
					function getResult()
					{
						this.Flags.set("IsEncircled", false);
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Done",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_02.png[/img]{The slaughter was a success. You take torches to the place and leave it in smoldering ruin. | A copper smell lingers in the air as you step over and around the bodies of peasants. You nod at your handiwork then look to %randombrother% and give the order.%SPEECH_ON%Burn it all.%SPEECH_OFF% | They put up a little more of a fight than expected, but ultimately you slayed them all. Or, at least, you hope you did. Not wanting to go half-assed on this, you proceed to set fire to every building in sight. | You\'ve brought ruin to the %location%. Its inhabitants are slain, and its buildings set ablaze. A good day\'s work by any sellsword\'s summation. | The dead are everywhere and the fresh, sweet smell of their passing is already turning sour. Not one to linger in a stench, you quickly set the %location% ablaze and depart. | ...and so the \'resistance\' is put down. A few bodies here, a few there. You hope you got them all. All that\'s left to do is burn everything to ashes and make your leave. | Well, this is what you came here for. You have a few men display the dead bodies in a manner that you find \'informative\', and then have a few other sellswords take torches to every building in sight.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We\'re done here. (Decrease Morals)",
					function getResult()
					{
						this.World.Assets.addMoralReputation(-5);
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Settlement, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Betrayal1",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_78.png[/img]{You get to the %location% only to be greeted by a heavily armed group of men. One of them steps forward, his thumbs hooked into a belt holding up a sword.%SPEECH_ON%Well, well, you really are stupid. %employer% does not forget easily - and he hasn\'t forgotten the last time you betrayed %faction%. Consider this a little... return of the favor.%SPEECH_OFF%Suddenly, all the men behind the lieutenant charge forward. Arm yourselves, this was an ambush! | You walk into the %location%, but the villagers seem prepared: you see windows shuttering and doors clapping closed. Just as you are about to order the company to start the slaughter, a group of men walk out from behind a building.\n\nThey are... considerably more armed than a group of laymen. In fact, they\'re carrying %employer%\'s banner. The realization that you\'ve been set up dawns on you just as the men begin to charge and you quickly bark out an order for the men to arm themselves. | A man greets you on the road just outside the %location%. He\'s well armed, well armored, and apparently quite happy, grinning sheepishly as you approach.%SPEECH_ON%Evening, mercenaries. %employer% sends his regards.%SPEECH_OFF%Just then, a group of men swarm out from the sides of the road. It\'s an ambush! That damned nobleman has betrayed you! | You step foot in the %location%, but all there is to greet you is a gust of lonely wind groaning between old woodworks. Thinking you\'ve been had, you draw out your sword.%SPEECH_ON%Good thinking.%SPEECH_OFF%The voice comes from a building, out stepping a man with his own hand unsheathing a blade. A retinue of armed men wearing the colors of %faction% follow behind him in lockstep, their group fanning out to stare at your company.%SPEECH_ON%I\'m going to enjoy prying that sword from your cold grip.%SPEECH_OFF%You shrug and ask why you\'ve been setup.%SPEECH_ON%%employer% doesn\'t forget those who doublecross him or his house. That\'s about all you need to know. Not like anything I say here will do you good when you\'re dead.%SPEECH_OFF%To arms, then, for this is an ambush! | The %location% is empty. Your men scour the buildings and find not a soul. Suddenly, a few men crowd the road behind you, the lieutenant of the group walking forward with ill intent. He\'s got a cloth embroidered with %employer%\'s sigil.%SPEECH_ON%Awfully quiet, isn\'t it? If you\'re wondering why I\'m here, it is to pay a debt owed to %faction%. You promised a task well done. You could not own up to that promise. Now you die.%SPEECH_OFF%You unsheathe your sword and flash its blade at the lieutenant.%SPEECH_ON%Looks like %faction% is about to have another promise broken.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To arms!",
					function getResult()
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().set("Betrayed", false);
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.CombatID = "Defend";
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[this.Contract.m.Destination.getTile().Type];
						p.Tile = this.World.getTile(this.World.worldToTile(this.World.State.getPlayer().getPos()));
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Music = this.Const.Music.NobleTracks;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 150 * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Betrayal2",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img]{You wipe your sword on your pant leg and quickly sheathe it. The ambushers lay dead, skewered into this grotesque pose or that one. %randombrother% walks up and inquires what to do now. It appears that %faction% isn\'t going to be on the friendliest of terms. | You kick the dead body of an ambusher off the end of your sword. It appears %faction% isn\'t going to be on the friendliest of terms from now on. Maybe next time, when I agree to do something for these people, I actually do it. | Well, if nothing else, what can be learned from this is to not agree to a task you can\'t complete. The people of these land are not particularly friendly to those who fall short of their promises... | You betrayed %faction%, but that\'s not something to dwell on. They betrayed you, that\'s what is important now! And going into the future, you best be suspicious of them and anyone who flies their banner. | %employer%, judging by the dead bannermen at your feet, appears to no longer be happy with you. If you were to guess, it\'s because of something you did in the past - doublecross, failure, back-talking, sleeping with a nobleman\'s daughter? It all runs together that you try and think about it. What\'s important now is that this wedge between you two will not be easily healed. You best be wary of %faction%\'s men for a little while.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Damn them!",
					function getResult()
					{
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_61.png[/img]{You return to %employer% and tell him the news. He sits back and nods.%SPEECH_ON%All of them?%SPEECH_OFF%You look around.%SPEECH_ON%You heard anybody come by?%SPEECH_OFF%%employer% smiles and shakes his head.%SPEECH_ON%Only news of some terrible event, of course. Damned brigands.%SPEECH_OFF%He snaps his fingers and a man seemingly steps out of the darkness to pay you your reward. | %employer% welcomes your return, giving you a drink. He smiles warmly for a man who has just ordered the slaughter of peasants.%SPEECH_ON%I hear news on the wind that %location% has been brought to ruin.%SPEECH_OFF%You nod.%SPEECH_ON%Brigands, huh?%SPEECH_OFF%%employer% grins. He hands you a satchel of crowns.%SPEECH_ON%Brigands indeed.%SPEECH_OFF% | With %location% destroyed, you return to tell %employer% of the news. There\'s a few locals standing alongside him, so you turn the \'news\' that \'brigands\' have attacked the place. He nods, concerned, but with a slick sleight of hand slips you a satchel of crowns. He then turns to the locals and says something must be done about a brigand problem... | You tell %employer% of your successes. He smiles and then calls a crowd of commoners to him. He announces that \'brigands\' have destroyed %location% and that he\'ll have to raise taxes to take care of this newfound problem. When he\'s finished talking, he turns and slides a satchel of crowns into your coat. | You enter %employer%\'s abode. There\'s a woman by his side sobbing. When you look at him, he shakes his head. Nodding, you tell him of the \'news.\'%SPEECH_ON%Uh... brigands... have destroyed %location%.%SPEECH_OFF%%employer% nods solemnly.%SPEECH_ON%Yes, yes I know. The widow here has told me everything. Tragic news. Very tragic.%SPEECH_OFF%One of the man\'s employees hands you a satchel of crowns as you leave.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{Honest pay for honest work. | Crowns is crowns.}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess);
						this.World.Contracts.finishActiveContract();
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
		this.m.Screens.push({
			ID = "Success2",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_61.png[/img]{You enter %townname% to find a number of familiar peasants standing around %employer%. Fearing they\'ll recognize you, you stay out of sight. They cry out that brigands have destroyed %location%. %employer% looks concerned.%SPEECH_ON%Have they? Oh, that\'s awful! I will look into this. Fear not, people, I will protect you!%SPEECH_OFF%Just as the man finishes, one of his guards slips you a satchel of crowns. | You enter %employer%\'s abode to find a number of bloodied peasants standing around his desk. You stay hidden as they finish their talk and leave. %employer% waves you in.%SPEECH_ON%Brigands. They said brigands did it. Perfect. Your payment is in the corner.%SPEECH_OFF% | %employer% greets your return with a smile.%SPEECH_ON%There were survivors.%SPEECH_OFF%He waves off your concern.%SPEECH_ON%They think brigands were responsible. A simple raid by vagabonds. You have nothing to worry about. Your payment...%SPEECH_OFF%He slides a satchel across his desk. You take it and nod.%SPEECH_ON%Good doing business with you.%SPEECH_OFF% | %employer% slaps a scroll down on his desk as you enter.%SPEECH_ON%You left some of them alive! But... it\'s alright. They think brigands were responsible.%SPEECH_OFF%You put a hand to your sword\'s hilt and glance at one of %employer%\'s guards.%SPEECH_ON%I still expect to be paid in full.%SPEECH_OFF%%employer% waves his hand to his desk where a satchel is.%SPEECH_ON%Of course. But next time I ask you to do something, I expect you to do it in full, understand?%SPEECH_OFF% | A throng of peasants have circled %employer%. You briefly wonder if they are about to lynch the man, but instead he sends them off. As he watches them turn a corner, he explains that they are survivors from %location%. Before you can say another word, the man waves off your concern.%SPEECH_ON%They still think brigands were responsible, but I\'m not happy about this result. This could have gone very bad for us. For me, I mean.%SPEECH_OFF%You nod and ask if you want these few survivors killed, just to be sure. %employer% shakes his head.%SPEECH_ON%No, no need for that. Here is your payment as promised, sellsword. Next time, though, do be sure to follow my orders.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{Honest pay for honest work. | Crowns is crowns.}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnVictory);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractPoor, "Fulfilled a contract");
						this.World.Contracts.finishActiveContract();
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
		this.m.Screens.push({
			ID = "Failure1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_43.png[/img]{As you enter %employer%\'s abode he turns and slaps a scroll of a drawing on his table.%SPEECH_ON%Recognize this person?%SPEECH_OFF%You pick it up. The sketched face looks remarkably like your own. %employer% leans back.%SPEECH_ON%They know someone hired a hit on the place. Get the fark out of here before I have my men run you through.%SPEECH_OFF% | %SPEECH_ON%Survivors! Survivors! What did I say, \'no survivors\', I believe I said that, right?%SPEECH_OFF%You nod as %employer% curls his knuckles against his desk.%SPEECH_ON%So why in the hell do I get peasants running in here crying that mercenaries stormed their place? Dead people don\'t talk, but who does? Who talks, sellsword?%SPEECH_OFF%You stand.%SPEECH_ON%Survivors.%SPEECH_OFF%%employer% points toward the door.%SPEECH_ON%Right. Now get the hell out of my sight.%SPEECH_OFF% | You nod as %employer% tells you the news: a few peasants escaped and spread word that it was a \'hired job\' to destroy %location%. But you\'re wondering...%SPEECH_ON%Can we still keep all the equipment we\'ve found?%SPEECH_OFF%%employer% laughs.%SPEECH_ON%You can keep whatever the hell you like, but you won\'t be seeing a single crown out of my pockets. Get out of here, sellsword.%SPEECH_OFF% | Unfortunately, it appears that a few peasants survived the slaughter. They told %employer% of very particular details, namely that well-armed and ill-intentioned men destroyed %location%. Not brigands, but sellswords. You were supposed to kill them all, leaving no survivors, but now... well, now you don\'t get paid. | %employer% sits across from you, clenching his fist, his face growing red. He asks how he is to raise taxes to protect people from brigands if everyone thinks mercenaries were hired to destroy %location%. You inquire as to what he means and the man is very blunt with you: a few peasants survived, you farkin\' idiot. Leaving survivors was not part of the job description, it appears, and now %employer%\'s payment won\'t be a part of your treasury.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "They won\'t be welcoming us in %settlementname%...",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail);
						this.Contract.m.Destination.getSettlement().getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationAttacked, "Raided " + this.Flags.get("DestinationName"));
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			]
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location",
			this.m.Flags.get("DestinationName")
		]);
		_vars.push([
			"settlementname",
			this.m.Flags.get("SettlementName")
		]);
		_vars.push([
			"noblehousename",
			this.World.FactionManager.getFaction(this.m.Faction).getNameOnly()
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setFaction(this.m.Destination.getSettlement().getFaction());
				this.m.Destination.setOnCombatWithPlayerCallback(null);
				this.m.Destination.setAttackable(false);
				this.m.Destination.clearTroops();
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (this.World.FactionManager.isGreaterEvil())
		{
			return false;
		}

		if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isActive())
		{
			return false;
		}

		if (this.m.Settlement == null || this.m.Settlement.isNull())
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

		if (this.m.Settlement != null && !this.m.Settlement.isNull())
		{
			_out.writeU32(this.m.Settlement.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local dest = _in.readU32();

		if (dest != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(dest));
		}

		local settlement = _in.readU32();

		if (settlement != 0)
		{
			this.m.Settlement = this.WeakTableRef(this.World.getEntityByID(settlement));
		}

		this.contract.onDeserialize(_in);
	}

});

