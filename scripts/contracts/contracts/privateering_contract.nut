this.privateering_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Item = null,
		CurrentObjective = null,
		Objectives = [],
		LastOrderUpdateTime = 0.0
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

		this.m.Type = "contract.privateering";
		this.m.Name = "Privateering";
		this.m.Description = "As the noble war rages, house lords are looking to hire privateers. Head to other noble house lands to raid, plunder, and squash their armies.";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		local nobleHouses = this.World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);

		foreach( i, h in nobleHouses )
		{
			if (h.getID() == this.getFaction())
			{
				nobleHouses.remove(i);
				break;
			}
		}

		nobleHouses.sort(this.onSortBySettlements);
		this.m.Flags.set("FeudingHouseID", nobleHouses[0].getID());
		this.m.Flags.set("FeudingHouseName", nobleHouses[0].getName());
		this.m.Flags.set("RivalHouseID", nobleHouses[1].getID());
		this.m.Flags.set("RivalHouseName", nobleHouses[1].getName());
		this.m.Payment.Pool = ::Z.Economy.Contracts[this.m.Type];
		local r = ::Math.rand(1, 2);

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
		this.m.Flags.set("StartDay", 0);
		this.m.Flags.set("LastUpdateDay", 0);
		this.m.Flags.set("SearchPartyLastNotificationTime", 0);
		this.contract.start();
	}

	function onSortBySettlements( _a, _b )
	{
		if (_a.getSettlements().len() > _b.getSettlements().len())
		{
			return -1;
		}
		else if (_a.getSettlements().len() < _b.getSettlements().len())
		{
			return 1;
		}

		return 0;
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Flags.set("StartDay", this.World.getTime().Days);
				this.Contract.m.BulletpointsObjectives = [
					"Travel to the lands of %feudfamily%",
					"Raid and burn down places",
					"Destroy any caravans or patrols",
					"Return after 7 days"
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
				local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
				f.addPlayerRelation(-99.0, "Took sides in the war");
				this.Flags.set("StartDay", this.World.getTime().Days);
				local nonIsolatedSettlements = [];

				foreach( s in f.getSettlements() )
				{
					if (s.isIsolated() || !s.isDiscovered())
					{
						continue;
					}

					nonIsolatedSettlements.push(s);
					local a = s.getActiveAttachedLocations();

					if (a.len() == 0)
					{
						continue;
					}

					local obj = a[::Math.rand(0, a.len() - 1)];
					this.Contract.m.Objectives.push(this.WeakTableRef(obj));
					obj.clearTroops();

					if (s.isMilitary())
					{
						if (obj.isMilitary())
						{
							this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Noble, ::Math.rand(90, 120) * this.Contract.getDifficultyMult());
						}
						else
						{
							local r = ::Math.rand(1, 100);

							if (r <= 10)
							{
								this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Mercenaries, ::Math.rand(90, 110) * this.Contract.getDifficultyMult());
							}
							else
							{
								this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Noble, ::Math.rand(70, 100) * this.Contract.getDifficultyMult());
							}
						}
					}
					else if (obj.isMilitary())
					{
						this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Militia, ::Math.rand(80, 110) * this.Contract.getDifficultyMult());
					}
					else
					{
						local r = ::Math.rand(1, 100);

						if (r <= 15)
						{
							this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Mercenaries, ::Math.rand(80, 110) * this.Contract.getDifficultyMult());
						}
						else if (r <= 30)
						{
							obj.getFlags().set("HasNobleProtection", true);
							this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Noble, ::Math.rand(80, 100) * this.Contract.getDifficultyMult());
						}
						else if (r <= 70)
						{
							this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Militia, ::Math.rand(70, 110) * this.Contract.getDifficultyMult());
						}
						else
						{
							this.Contract.addUnitsToEntity(obj, ::Const.World.Spawn.Peasants, ::Math.rand(70, 100));
						}
					}

					if (this.Contract.m.Objectives.len() >= 3)
					{
						break;
					}
				}

				local origin = nonIsolatedSettlements[::Math.rand(0, nonIsolatedSettlements.len() - 1)];
				local party = f.spawnEntity(origin.getTile(), origin.getName() + " Company", true, ::Const.World.Spawn.Noble, 190 * this.Contract.getDifficultyMult());
				party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + f.getBannerString());
				party.setDescription("Professional soldiers in service to local lords.");
				this.Contract.m.UnitsSpawned.push(party.getID());
				party.getLoot().Money = ::Math.rand(50, 200);
				party.getLoot().ArmorParts = ::Math.rand(0, 25);
				party.getLoot().Medicine = ::Math.rand(0, 3);
				party.getLoot().Ammo = ::Math.rand(0, 30);
				local r = ::Math.rand(1, 4);

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

				local c = party.getController();
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				local r = ::Math.rand(1, 100);

				if (r <= 15)
				{
					local rival = this.World.FactionManager.getFaction(this.Flags.get("RivalHouseID"));

					if (!f.getFlags().get("Betrayed"))
					{
						this.Flags.set("IsChangingSides", true);
						local item = this.new("scripts/items/" + ::Const.Items.NamedWeapons[::Math.rand(0, ::Const.Items.NamedWeapons.len() - 1)]);
						item.onAddedToStash("");
						this.Contract.m.Item = item;
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
				this.Contract.m.BulletpointsObjectives = [];

				foreach( obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && obj.isActive())
					{
						this.Contract.m.BulletpointsObjectives.push("Destroy " + obj.getName() + " near " + obj.getSettlement().getName());
						obj.getSprite("selection").Visible = true;
						obj.setAttackable(true);
						obj.setOnCombatWithPlayerCallback(this.onCombatWithLocation.bindenv(this));
					}
				}

				this.Contract.m.BulletpointsObjectives.push("Destroy any caravans or patrols of %feudfamily%");
				this.Contract.m.BulletpointsObjectives.push("Return after %days%");
				this.Contract.m.CurrentObjective = null;
			}

			function update()
			{
				if (this.Flags.get("LastUpdateDay") != this.World.getTime().Days)
				{
					if (this.World.getTime().Days - this.Flags.get("StartDay") >= 7)
					{
						this.Contract.setScreen("TimeIsUp");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("LastUpdateDay", this.World.getTime().Days);
						this.start();
						this.World.State.getWorldScreen().updateContract(this.Contract);
					}
				}

				if (this.Contract.m.UnitsSpawned.len() != 0 && this.Time.getVirtualTimeF() - this.Contract.m.LastOrderUpdateTime > 2.0)
				{
					this.Contract.m.LastOrderUpdateTime = this.Time.getVirtualTimeF();
					local party = this.World.getEntityByID(this.Contract.m.UnitsSpawned[0]);
					local playerTile = this.World.State.getPlayer().getTile();

					if (party != null && party.getTile().getDistanceTo(playerTile) > 3)
					{
						local f = this.World.FactionManager.getFaction(this.Flags.get("FeudingHouseID"));
						local nearEnemySettlement = false;

						foreach( s in f.getSettlements() )
						{
							if (s.getTile().getDistanceTo(playerTile) <= 6)
							{
								nearEnemySettlement = true;
								break;
							}
						}

						if (nearEnemySettlement)
						{
							local c = party.getController();
							c.clearOrders();
							local move = this.new("scripts/ai/world/orders/move_order");
							move.setDestination(this.World.State.getPlayer().getTile());
							c.addOrder(move);
							local wait = this.new("scripts/ai/world/orders/wait_order");
							wait.setTime(this.World.getTime().SecondsPerDay * 1);
							c.addOrder(wait);

							if (party.getTile().getDistanceTo(playerTile) <= 8 && this.Time.getVirtualTimeF() - this.Flags.get("SearchPartyLastNotificationTime") >= 300.0)
							{
								this.Flags.set("SearchPartyLastNotificationTime", this.Time.getVirtualTimeF());
								this.Contract.setScreen("SearchParty");
								this.World.Contracts.showActiveContract();
							}
						}
					}
				}

				if (this.Flags.get("IsChangingSides") && this.Contract.getDistanceToNearestSettlement() >= 5 && this.World.State.getPlayer().getTile().HasRoad && ::Math.rand(1, 1000) <= 1)
				{
					this.Flags.set("IsChangingSides", false);
					this.Contract.setScreen("ChangingSides");
					this.World.Contracts.showActiveContract();
				}

				foreach( i, obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
					{
						obj.getSprite("selection").Visible = false;
						obj.setAttackable(false);
						obj.getFlags().set("HasNobleProtection", false);
						obj.setOnCombatWithPlayerCallback(null);
					}

					if (obj == null || obj.isNull() || !obj.isActive() || obj.getSettlement().getOwner().isAlliedWithPlayer() || obj.isAlliedWithPlayer())
					{
						this.Contract.m.Objectives.remove(i);
						this.Flags.set("LastUpdateDay", 0);
						break;
					}
				}
			}

			function onCombatWithLocation( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.CurrentObjective = _dest;

				if (_dest.getTroops().len() == 0)
				{
					this.onCombatVictory("RazeLocation");
					return;
				}
				else
				{
					local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					p.CombatID = "RazeLocation";
					p.LocationTemplate = clone ::Const.Tactical.LocationTemplate;
					p.LocationTemplate.Template[0] = "tactical.human_camp";
					p.LocationTemplate.Fortification = ::Const.Tactical.FortificationType.None;
					p.LocationTemplate.CutDownTrees = true;
					p.LocationTemplate.AdditionalRadius = 5;

					if (_dest.isMilitary())
					{
						p.Music = ::Const.Music.NobleTracks;
					}
					else
					{
						p.Music = ::Const.Music.CivilianTracks;
					}

					p.EnemyBanners = [];

					if (_dest.getSettlement().isMilitary() || _dest.getFlags().get("HasNobleProtection"))
					{
						p.EnemyBanners.push(_dest.getSettlement().getBanner());
					}
					else
					{
						p.EnemyBanners.push("banner_noble_11");
					}

					if (_dest.getFlags().get("HasNobleProtection"))
					{
						local f = this.Flags.get("FeudingHouseID");

						foreach( e in p.Entities )
						{
							if (e.Faction == _dest.getFaction())
							{
								e.Faction = f;
							}
						}
					}

					this.World.Contracts.startScriptedCombat(p, _isPlayerAttacking, true, true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "RazeLocation")
				{
					this.Contract.m.CurrentObjective.setActive(false);
					this.Contract.m.CurrentObjective.spawnFireAndSmoke();
					this.Contract.m.CurrentObjective.clearTroops();
					this.Contract.m.CurrentObjective.getSprite("selection").Visible = false;
					this.Contract.m.CurrentObjective.setOnCombatWithPlayerCallback(null);
					this.Contract.m.CurrentObjective.setAttackable(false);
					this.Contract.m.CurrentObjective.getFlags().set("HasNobleProtection", false);
					this.Flags.set("Score", this.Flags.get("Score") + 5);

					foreach( i, obj in this.Contract.m.Objectives )
					{
						if (obj.getID() == this.Contract.m.CurrentObjective.getID())
						{
							this.Contract.m.Objectives.remove(i);
							break;
						}
					}

					this.Flags.set("LastUpdateDay", 0);
				}
			}

			function onPartyDestroyed( _party )
			{
				if (_party.getFaction() == this.Flags.get("FeudingHouseID") || this.World.FactionManager.isAllied(_party.getFaction(), this.Flags.get("FeudingHouseID")))
				{
					this.Flags.set("Score", this.Flags.get("Score") + 2);
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
				this.Contract.m.Home.getSprite("selection").Visible = true;

				foreach( obj in this.Contract.m.Objectives )
				{
					if (obj != null && !obj.isNull() && obj.isActive())
					{
						obj.getSprite("selection").Visible = false;
						obj.setOnCombatWithPlayerCallback(null);
					}
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("Score") <= 9)
					{
						this.Contract.setScreen("Failure1");
					}
					else if (this.Flags.get("Score") <= 15)
					{
						this.Contract.setScreen("Success1");
					}
					else
					{
						this.Contract.setScreen("Success2");
					}

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
			Text = "[img]gfx/ui/events/event_45.png[/img]{You step into %employer%\'s room and he immediately begins talking.%SPEECH_ON%{Good seeing you, sellsword. I need a raiding party to make a mess of %feudfamily%\'s pots and pans, if you get my meaning. You don\'t? Well, basically I need you to go into their territories and burn down everything you can get your hands on. I\'d say about %days% of this will do some real damage to their war efforts. And be very, very careful of enemy patrols. | Ah, mercenary. Look, I need some hardy men to go into %feudfamily% territory and burn every caravan and crop they come across. Not the most honorable of work, but efforts like these will help end the war. I\'d say spend %days% out there and then head on back. | I need raiders to dive into %feudfamily% territory for %days% and destroy as many of their resources as can be done. You\'ll be hated and they\'ll come after you hard and fast, but if you can avoid their patrols the job should be quick and easy. What say you? | We\'re at war with %feudfamily%, but wars require a bit more than clashing armies against one another. Sometimes they demand a bit of subterfuge. What I need, sellsword, is for you to raid their territories for %days%. Destroy caravans, burn farms, anything that will help the war cause. Of course, you should be wary of enemy patrols. I know if you were coming after my lands and peoples, I\'d come after you doubly hard. So, what say you? | Let me be brief. I need someone to raid %feudfamily%\'s territories for %days%. Of course, they\'ll be expecting men such as yourself so I\'d work hard to avoid any patrols while you\'re out there. Are you interested? | I got the perfect job for you, sellsword. I need you to raid %feudfamily%\'s territories and destroy as much as you can for about %days%. Efforts such as these can help end wars. Of course, they\'ll understand that little fact, too, and will do everything they can to stop you.}%SPEECH_OFF% | %employer% welcomes you into his room and points at a map stretched across a table.%SPEECH_ON%Did you know that one of the best ways to fight a man, is to ensure that he is unable to fight at all? I read that in an old book.%SPEECH_OFF%A very artsy view of war, but true. You nod. The man continues.%SPEECH_ON%I want you to head into %feudfamily% lands and tear up as much as their territory as possible. Destroy caravans, burn farms, you get the idea. Do as much damage as you can in %days% and then head on back. Oh, one last thing. Be wary of enemy patrols. They will not take kindly to your... excursions.%SPEECH_OFF% | You find %employer% perusing a book. He\'s making notes in it with a quill pen.%SPEECH_ON%My grandfather once defeated an army ten times his size. How did he do it? The historians and scribes, who is paid and fed by my family, tell stories of grandeur on the battlefield. But that is not the truth. Do you know the truth?%SPEECH_OFF%You shrug and guess that his grandfather used subterfuge of some sort. The nobleman claps the book shut and briefly points a finger.%SPEECH_ON%Exactly! He took a mere handful of men and burned down all their farms, granaries, and food stores. Of what use is such a large army if you cannot feed it? I need you to do the same, sellsword. Go into %feudfamily% territories for %days% and destroy as much as you can. Avoid the patrols, of course. They sure as shite will fight hard to have your neck if they catch ya.%SPEECH_OFF% | You step into %employer%\'s room to find him combating with a very old general. The commander straightens up.%SPEECH_ON%I will not sully my family\'s name with such deplorable actions. Get some low born sod to do it if you want to take this route!%SPEECH_OFF%The commander grabs his things and leaves in a huff, turning his nose up at you as he heads out. %employer% smiles as you walk in. He opens his arms and speaks.%SPEECH_ON%Well, speak of a very needed devil. Sellsword, I need someone to raid %feudfamily% territory for %days%. My noble commanders think this is beneath them, but I think you\'ll do it just fine. Of course, our enemies will think it is beneath them, too, and so if they find you be prepared because they\'ll be coming especially hard.%SPEECH_OFF% | %employer% is staring at spilt milk running across his table and dripping off the edge.%SPEECH_ON%Did you ever have a day ruined over something very simple like this?%SPEECH_OFF%You nod. Who hasn\'t? The man continues.%SPEECH_ON%My intentions were to make cheese, but now I cannot because the ingredients have been ruined. Sellsword, this prompt and entirely coincidental adage also applies to war. I need you to raid %feudfamily%\'s territory and, proverbially speaking, spill their milk: destroy caravans, burn farms, collapse mines, whatever it takes. %days% of that kind of work should do the job. Of course, beware their patrols while you\'re out there. I sure as shite would be looking to put your head on a pike if you were doing these things in my territories!%SPEECH_OFF% | A guard leads you to %employer% who is tending to some crops in his garden. The plants are keeled over, their leaves serrated and mottled by the munching of invasive insects. Picking up one of the dead plants, %employer% speaks.%SPEECH_ON%This was looking like it was going to be the strongest season for these crops. And yet, here they are, felled by the smallest of bugs which ran wild through here. I\'m sure it was a grand ol\' time for those tiny bastards.%SPEECH_OFF%He drops the plant and claps you on the shoulder.%SPEECH_ON%Sellsword, I need someone to be the devilish insect in my enemy\'s garden. I need you to raid %feudfamily%\'s territories for at least %days%. Of course, if they catch you, expect them to treat you like a bug and squash you like one, too. So keep clear of the boots on the ground. You know, like a bug would.%SPEECH_OFF% | %employer% is humoring a wench when you walk into his room. She quickly gathers her things and leaves in a hurry, diverting her eyes from yours. The rather smug nobleman pours himself a glass of wine.%SPEECH_ON%Don\'t mind her. She\'s friends with my wife. That\'s all.%SPEECH_OFF%He sets the decanter back on his desk.%SPEECH_ON%Speaking of just friends, why don\'t you be a friend of mine and go and raid %feudfamily%\'s territories?%SPEECH_OFF%The man wobbles as he steps before sitting on the edge of a desk. He sniffs his fingers, shrugs, and drinks the wine.%SPEECH_ON%Go into their lands and destroy as much as you can for %days%. Then head on back. I mean, you can stay out there if you want, but I highly suggest coming back because their armies won\'t be putting up with your shite for long. Noblemen don\'t fancy raiders with much regard. I\'m sure you understand the politics there.%SPEECH_OFF% | %employer% is surrounded by his commanders. He beckons you forth and points a finger as if to accuse you of a crime you didn\'t even know had been committed.%SPEECH_ON%This is our man! This is the one who will do it! Mercenary! I need hard fighters to raid %feudfamily%\'s lands for %days%. Destroy as much as you can, whatever hurts their ability to wage war. Of course, stay nimble on your feet. They\'ll be looking to expediently crush any raids they discover.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{Heading out for seven whole days will cost you. | That\'s something the %companyname% can take care of. | Payment?}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This isn\'t worth it. | We\'re needed elsewhere. | It\'s too long a commitment for the company.}",
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
			ID = "SearchParty",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_90.png[/img]{You near a farmstead when suddenly one of the shutters bursts open. An old lady yells in a scraggly voice while waving a white flag around. %randombrother% goes to check it out, listening to her for a time before quickly hurrying back.%SPEECH_ON%Sir, she said that %feudfamily% knows where we are and there is a large contingent of enemy forces coming for us. And yes, she used the word \'contingent.\'%SPEECH_OFF% | As you pass a homestead a little boy comes running out.%SPEECH_ON%Oooh, are you the ones going to kill the raiders?%SPEECH_OFF%You ask who told him that. The boy shrugs.%SPEECH_ON%I was footsing around the pub and heard that %feudfamily% knew where the raiders were and was sending big men to smash them good!%SPEECH_OFF%The kid claps his hands together as if he was smooshing a bug. You rub the tyke\'s hair.%SPEECH_ON%Sure, that\'s us. Now run on back home.%SPEECH_OFF%You quickly inform the %companyname% of the news. | %randombrother% comes running down one of the hillsides. He seizes up next to you, drawing for air.%SPEECH_ON%Sir, I... they...%SPEECH_OFF%He straightens up.%SPEECH_ON%I need to exercise. But that\'s not what I came to tell you! There is a very large group of enemy soldiers coming our way right this minute. I think they know exactly where we are, sir.%SPEECH_OFF%You nod and tell the men to prepare themselves. | A scouting mission reports that a huge enemy patrol seemingly knows your location and is coming now! The %companyname% should prepare themselves, whether it is to run or stand their ground and fight. | You\'ve been spotted and a large force of %feudfamily% soldiers are coming! Prepare the men as best you can, because reports state that these enemies are well armed. | %randombrother% reports to you what he\'s been hearing from some of the locals. They say a large group of soldiers carrying a banner are heading your way. You ask the mercenary to describe the sigil and he does so in great detail: it belongs to %feudfamily%\'s men. They must\'ve caught up to you somehow. The %companyname% should brace itself for a hell of a fight! | A group of women cleaning clothes in a creek ask what you\'re still doing here. You ask what they mean. One laughs, a barbarous call if there ever was one.%SPEECH_ON%Come again? We asked you what you were still doing here. You know %feudfamily%\'s coming hard for the likes of men such as ye. The way I hear it, they\'ll be on yer arse real soon.%SPEECH_OFF%You ask how they know this. One of the other ladies slaps a shirt in the creek.%SPEECH_ON%Sir, you must be dumber than hell. Rumors travel faster than any horse. Don\'t ask how. Just the way it is.%SPEECH_OFF%If what these harlots say is true, then surely the %companyname% has a great fight before them! | You step atop a hillside and give the surrounding land as good of a look as you can. Ain\'t much to the sight except for a large group of men flying the banner of %feudfamily% who seem to be stepping your way. That is one hell of a sight and pretty soon you\'ll get to see it up close and personal.\n\n Enemies have caught up to the %companyname%! You should prepare yourself for a hell of a fight on account of burning all their shite.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Be on your guard!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "TimeIsUp",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_36.png[/img]{It\'s been nearly %maxdays% now. The company should start heading back to %employer% for payment. | The company has been in the field for %maxdays% now. %employer% will be expecting your return now. | With %maxdays% spent raiding, you\'ve reached the time to return to %employer% for pay. No need to spend another second doing what you won\'t be getting paid for. | %employer% hired you for %maxdays%. The company shouldn\'t spend another moment in the field that it doesn\'t have to. Return to the man for your pay. | The %companyname% has put %maxdays% work into doing %employer%\'s bidding. That\'s all the time he was willing to pay so you\'d best get back to him now. | %employer% paid for %maxdays% and that\'s what you\'ve put in. The %companyname% should return to him quickly for payment. | While ravaging the lands is growing on you, %employer% is only paying for %maxdays% work. You\'d best get back to him now. | You\'ve put in good work, but it\'s time to return %employer% as he\'s only paying you for %maxdays% worth of your services.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Time to head back to %townname%.",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ChangingSides",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_51.png[/img]{While on the road, a man in a dark cloak slowly approaches. His face is hidden behind the hood\'s tuck of darkness. He pauses before you and puts his hands out.%SPEECH_ON%Greetings. I am a messenger of %rivalhouse%. We have an offer for you. Put down your arms for %noblehouse% and join us. You shan\'t run out of business with us and your company will always be first in line for the best contracts. To sweeten the deal, I am to give you this marvellous weapon called %nameditem%.%SPEECH_OFF%You mull the idea over. Flipping sides is part-and-parcel of the mercenary life. Which noble house is treating the company better? Which house is more likely to win? | You step off the path to take a piss. While relieving yourself, a man suddenly appears out of the dripping bush, although ostensibly dry. You leap back and draw a dagger, but the man puts his hands out.%SPEECH_ON%Woe there, sellsword. I\'m a messenger of %rivalhouse%. I am to suggest, and only suggest, to you an offer. Join us. You will assume first priority whenever we are in need of your services, meaning the best contracts with the best pay, and let me tell you, we will always be in need. To help sweeten the deal, I was to offer you this.%SPEECH_OFF%He slowly holds out a masterfully crafted weapon. You tell him to give you a moment and go back to finish pissing. Thoughts rush through your head as something else rushes out your other head. | While getting a lay of the land, a man in a dark cloak approaches. %randombrother% grabs him by the hood and puts a blade to his neck. The man only puts his hands up and says that he\'s there to send a message from %rivalhouse%. You nod and let him speak and he does so.%SPEECH_ON%We have an offer: join us. Abandon these noble failures you are serving and come work for us. You will be given the best contracts and the best pay and, best of all, you will be on the winning side! As a token of good faith, I am to give you this fine weapon called %nameditem%. If you agree, of course.%SPEECH_OFF%You carefully mull the offer as boardflipping should not be taken lightly. | A shadowy, dark figure comes down the path with a scroll outreached in one hand.%SPEECH_ON%Evening, the %companyname%. I come from %rivalhouse% with an offer of service. Abandon your benefactors and join us. You will find better and more plentiful contracts and, even better, you will be on the winning side of this war! If you agree, and as a token of good faith, you will receive this weapon called %nameditem%.%SPEECH_OFF%%randombrother% looks at you and shrugs.%SPEECH_ON%Not to step outside my rank, but I\'d say this is worth thinking over.%SPEECH_OFF%Indeed it is. | You separate from the company to get a good lay of the land. While surveying the fields before you, a cloaked figure suddenly appears with something outreached. %randombrother% appears and tackles him to the ground and readies to put a blade through his face. The stranger puts his hands up, a rolled-up scroll in hand. You tell the man to stand and present himself. He states he is from %rivalhouse% and he has an offer for the %companyname%.%SPEECH_ON%Switch sides. As mercenaries, there is no honor to lose in doing this, and is in fact wholly expected of you. Chase the crowns, correct? Well, we have the most contracts with the best pay. That\'s what you are after, no?%SPEECH_OFF%The messenger fixes his clothes, straightening himself like a temporarily embarrassed ambassador.%SPEECH_ON%Additionally, if you choose to accept our offer, I am to give you this weapon known by the name of %nameditem% as a token of good faith. So, what say you?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "An intriguing offer. I accept.",
					function getResult()
					{
						return "AcceptChangingSides";
					}

				},
				{
					Text = "You waste your time. Begone or you\'ll hang from that tree.",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "AcceptChangingSides",
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_51.png[/img]{You accept the offer. The mysterious messenger takes you to a hidden copse and digs the weapon out from behind some bushes and hands it over.%SPEECH_ON%Good doing business with you, sellsword.%SPEECH_OFF%It\'s fair to say that %employer% and all his family completely hate you now. | After you accept the offer, the messenger takes you off-path to fish the weapon out from behind some bushes. Handing it over, he also shakes your hand.%SPEECH_ON%You made the right choice, sellsword.%SPEECH_OFF%%employer% no doubt hates you now and there\'s no point in returning to him, unless your new benefactors request it, of course.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "The %companyname% shall henceforth work for %rivalhouse%!",
					function getResult()
					{
						this.Contract.m.Item = null;
						local f = this.World.FactionManager.getFaction(this.Contract.getFaction());
						f.addPlayerRelation(-f.getPlayerRelation(), "Changed sides in the war");
						f.getFlags().set("Betrayed", true);
						local a = this.World.FactionManager.getFaction(this.Flags.get("RivalHouseID"));
						a.addPlayerRelationEx(50.0 - a.getPlayerRelation(), "Changed sides in the war");
						a.makeSettlementsFriendlyToPlayer();
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractBetrayal);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.updateAchievement("NeverTrustAMercenary", 1, 1);
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(this.Contract.m.Item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + this.Contract.m.Item.getIcon(),
					text = "You gain " + this.Contract.m.Item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% welcomes you into his room. He gives you a satchel of %reward_completion% crowns.%SPEECH_ON%Good work out there, sellsword. You did just about all that could have been asked of you.%SPEECH_OFF% | %employer% is found tending to a bunch of chickens. You shoo your way through the flock to get to him and tell him the news. He responds positively.%SPEECH_ON%Ah yeah? Well that\'s good. Do you want to be paid in chicken feed or crowns?%SPEECH_OFF%The nobleman stares at you straight-laced before a smirk betrays him.%SPEECH_ON%You can find %reward_completion% crowns being held by that guard standing yonder. He\'ll know to hand it over.%SPEECH_OFF% | %employer% is too busy to meet you, but the %reward_completion% crowns one of his guards hands over seems ample enough measurement of how happy he is about your work. | %employer% stirs a finger in a goblet of wine.%SPEECH_ON%Raiding is messy work, but you did good out there. Gotta admit, a part of me was hoping you\'d bring the apocalypse itself to my enemies, but what you did is fair enough I suppose.%SPEECH_OFF%He takes his finger out and licks it before throwing you a satchel of %reward_completion% crowns. | %employer% sinks into one of his chairs, hands limp over the rests, his feet kicked out.%SPEECH_ON%Your pay of %reward_completion% crowns is yonder.%SPEECH_OFF%He nods to a corner of the room where a bag is leaning against the wall. You go to retrieve it as he continues talking.%SPEECH_ON%I\'d say you did a good enough job. That satchel should weigh heavy with my happiness.%SPEECH_OFF% | You find %employer% out in the kennels feeding his dogs.%SPEECH_ON%Good job, sellsword. If all my soldiers were of your constitution and drive, this war would\'ve been over before it saw its first moon. A shame, isn\'t it?%SPEECH_OFF%He suddenly turns to you, staring intently. You think this is a sly effort to recruit you to his army. You politely give a very political decline before inquiring about the pay. He continues, pointing with a floppy bacon strip to a man standing across the way.%SPEECH_ON%That guard has it. %reward_completion% crowns in total.%SPEECH_OFF% | %employer% thanks you for your service. That\'s about all he says before handing you a sum of %reward_completion% crowns. | You find %employer% surrounded by his commanders. They\'re adjusting the battle map according to the extent of your work. The nobleman straightens up and stares at the results.%SPEECH_ON%It\'s not all that I could ask for, but it\'s good. Very good. My guard standing yonder will have %reward_completion% crowns for you.%SPEECH_OFF% | %employer% is standing before a map hanging from the wall. He\'s using a quill pen to make notes and you notice that these markings follow the path the %companyname% took through %feudfamily%\'s territories. The nobleman hums and nods to himself. He speaks without looking at you.%SPEECH_ON%It\'s not the best, but it\'s good. %reward_completion% crowns is for you in the corner.%SPEECH_OFF% | One of %employer%\'s commanders stops you from entering his room. He hands over a satchel of %reward_completion% crowns.%SPEECH_ON%The lord is busy. Please take your pay and go.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Honest pay for honest work.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationNobleContractSuccess, "Raided the enemy lands");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isCivilWar())
						{
							this.World.FactionManager.addGreaterEvilStrength(::Const.Factions.GreaterEvilStrengthOnCommonContract);
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
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{%employer% and his commanders are getting drunk when you enter their room. One burly general slaps you on the shoulder, looks to say something, then turns and vomits. You hurry your feet away and find %employer% himself.%SPEECH_ON%Ah, sellsword! I -hic- well, here. %reward_completion% crowns.%SPEECH_OFF%He holds out a satchel which you quickly take lest it suffer a fate similarly dispensed by the commander still upchucking behind you. %employer% wobbles backward before leaning against his desk for support.%SPEECH_ON%You damn near punched a hole in %feudfamily%\'s war efforts. A damn -hic- fine job! The damned, finest, jobbest, job I ever did -hic- hear of.%SPEECH_OFF%You retreat from the room, weaving around the festivities and puke cities. | %employer% slams a goblet of wine down, sloshing most of it all over himself.%SPEECH_ON%Excellent! Outstanding! Perfection! That is what I have to say about your work, sellsword. Hell, we even got a few deserters from %feudfamily%\'s armies who are very worried their side has already lost! Here, have %reward_completion% crowns. It\'s on me.%SPEECH_OFF%The man bursts into laughter before taking a long drink. | You step into %employer%\'s room to find him studying a war map. He tickles his chin with a quill pen, humming to himself and nodding now and again.%SPEECH_ON%You know, I just about ran out of ink tracking your movements through %feudfamily%\'s territory. That\'s how damn good of a job you did, sellsword. You can find %reward_completion% crowns in the corner yonder.%SPEECH_OFF% | A man greets you outside %employer%\'s room with a satchel that weighs heavy in your hands.%SPEECH_ON%%reward_completion% crowns for your services. My liege is busy, but most pleased. Hopefully this is a sign of how appreciative he is of your work.%SPEECH_OFF%It\'s a pretty good sign, yes. | A guard leads you to %employer% who is behind a locked door. There\'s a woman in there with him and he seems to be in a bit of a... celebratory mood. The guard knocks on the door, then thinks better of it.%SPEECH_ON%I was supposed to tell him you were here, but he doesn\'t like to be interrupted. Not during times like this. You know. Good times.%SPEECH_OFF%You nod and ask where your pay is. The guard leads you to the treasury. You meet a hawkfaced man sitting behind towers of papers and coins. He pushes a satchel of %reward_completion% crowns your way before noting the exchange on a scroll. | %employer% meets you in his garden. He\'s overseeing some servants putting plants in the fine soil.%SPEECH_ON%What do you have in your garden, sellsword?%SPEECH_OFF%You gently inform the man that you are not the gardening type. He nods as though this was very interesting to him.%SPEECH_ON%I\'m thinking of putting turnips in for the coming season. Anyway, enough of that talk. See the servant over there sweating? He\'s the one holding the heavy satchel. Heavy because it contains %reward_completion% crowns. Your reward for a job well done, sellsword. Maybe you can buy yourself a garden!%SPEECH_OFF% | %employer% and his commanders are crooning over a battle map. One pushes a token with your company\'s sigil on it. He tracks the token all across the map, using an inked stick to dab marks every so often. You cross your arms and speak loudly.%SPEECH_ON%Enjoying my work, are we?%SPEECH_OFF%The nobleman and his commanders look up at you. %employer% grins and quickly crosses the room.%SPEECH_ON%Don\'t you know it! You did an amazing job, mercenary. Truly. That guard standing yonder has %reward_completion% crowns as payment for your services.%SPEECH_OFF% | %employer% is standing amongst his commanders. He whoops as you enter the room.%SPEECH_ON%God, damn, son! You near destroyed all that they had! What more could a man like me ask for aside from a smiting bolt from the heavens? You\'ll get paid %reward_completion% crowns, which I find more than sufficient for a job of this quality!%SPEECH_OFF% | You find %employer% sitting in his room. He looks very happy with you.%SPEECH_ON%{Well well, if it isn\'t the man of the day. I had a flock of my little birds flying through my window to speak of your work. Word travels fast when you do a job as good as that! %feudfamily% will be crippled and the war brought many steps closer to its ending! I\'ve prepared a satchel of %reward_completion% crowns for you in the corner yonder. | You should carry a little more gusto, sellsword. What you did to %feudfamily% was beyond even what I had asked for. I\'m surprised you didn\'t take it one step further and just kill that whole bloodline while you were at it. Ah, all things in good time. Right now, you got %reward_completion% crowns waiting for you over there in that corner.}%SPEECH_OFF% | You find %employer% crouching before a table with a war map on it. His eyes peer over the edge, scanning a horizon of tokens.%SPEECH_ON%Greetings sellsword.%SPEECH_OFF%He jumps to his feet. With one hand, he slowly picks up tokens representing %feudfamily% and begins tossing them aside.%SPEECH_ON%Enjoy your handiwork, sellsword. You managed to cripple my enemies with hardly any effort! I suppose I speak for myself on that front, but what you\'ve done here beats anything a large battle could do! %reward_completion% crowns are waiting for you in the corner yonder. I hope that pay is sufficient, because the job you did certainly was.%SPEECH_OFF% | You find %employer% and his commanders and a bevy of womenfolk that don\'t look properly attired for any war that you know of.%SPEECH_ON%Sellsword! Come on in%SPEECH_OFF%%employer% wheels backward on his heels, a woman notched to each arm. You follow him in as best you can. A woman tries to drag you into the party, but a general commandeers her. %employer% falls into his seat, the women in his lap.%SPEECH_ON%You are the cause for celebration, mercenary. You did such a good job raiding %feudfamily%\'s territories that I think you brought us much closer to ending this war than any big battle ever could have done! Cheers!%SPEECH_OFF%You look around.%SPEECH_ON%Festivities are nice, but I don\'t have to fight for women and drinks. You owe me money.%SPEECH_OFF%Your employer nods.%SPEECH_ON%Of course, of course! Visit my treasurer and give him your sigil. He\'ll have %reward_completion% crowns waiting for you.%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Honest pay for honest work.",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractSuccess * 2);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationNobleContractSuccess * 2, "Raided the enemy lands");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isCivilWar())
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
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_45.png[/img]{You enter %employer%\'s room already resigned to what fury he is going to dish out. And dish it out he does.%SPEECH_ON%Lemme get this straight, sellsword. I offer to pay you to go and raid %feudfamily%\'s territory. You agree to this offer since, as I thought it was, it was a very good offer and both parties had a lot to gain. Now you stand before me saying you have done fark all in regard to our arrangement. Why did you even bother stepping through that door you sorry piece of a dog\'s sack? No, you\'re worse than that, you\'re a sniveling worm trying to steal from a noble man doing noble work. Get out of here before I lose my temper.%SPEECH_OFF%Despite %employer%\'s bravado, he is the one who is sliding into danger. You quickly leave before it is your temper that is lost and a nobleman\'s life that would go with it. | You return to %employer% but a guard stops you outside the door.%SPEECH_ON%He already knows what you have, or should I say have not done. You\'d best not go in there.%SPEECH_OFF%The crashing of a flipped table rattles the door. An incomprehensible scream follows. You take the guard\'s recommendation and leave. | %employer% runs a finger along the rim of his cup. It whines loudly as he coils around it, again and again.%SPEECH_ON%Such a sweet, sweet tune. How could it be that a simple cup would be better than you, mercenary? I suppose that\'s just the way this world is sometimes. I ask someone to do something, and they don\'t do it. What else is there to say? Please, get out.%SPEECH_OFF% | You find %employer% feeding scraps to his dogs. Servants watching nearby look as if they\'d rather be dogs themselves if this sort of treatment is what they\'d get. %employer% turns to you as a dog gently slips a piece of bacon out of his hand.%SPEECH_ON%Dogs have a preference for meat. Here, I feed them the remains of a pig. It was a good pig. A pig that had a good life except for one very bad moment, of course. Now it feeds my dogs. You, sellsword, have brought to me a very bad moment in your own life. Should I also feed you to my dogs? No? Then get out of my room.%SPEECH_OFF% | %employer% refuses to even meet you. Two of his guards explain that he is furious at your failure to inflict any damage at all upon %feudfamily%\'s territories. Fair enough. You thank the guards for saving you from a nobleman\'s pointless barrage of insults and anger.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "To hell with you!",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(::Const.World.Assets.RelationNobleContractFail, "Failed to raid the enemy lands");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.World.FactionManager.getFaction(this.m.Faction).getName()
		]);
		_vars.push([
			"rivalhouse",
			this.m.Flags.get("RivalHouseName")
		]);
		_vars.push([
			"feudfamily",
			this.m.Flags.get("FeudingHouseName")
		]);
		_vars.push([
			"maxdays",
			"seven days"
		]);
		local days = 7 - (this.World.getTime().Days - this.m.Flags.get("StartDay"));
		_vars.push([
			"days",
			days > 1 ? "" + days + " days" : "1 day"
		]);

		if (this.m.Item != null)
		{
			_vars.push([
				"nameditem",
				this.m.Item.getName()
			]);
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			foreach( obj in this.m.Objectives )
			{
				if (obj != null && !obj.isNull() && obj.isActive())
				{
					obj.clearTroops();
					obj.setAttackable(false);
					obj.getSprite("selection").Visible = false;
					obj.getFlags().set("HasNobleProtection", false);
					obj.setOnCombatWithPlayerCallback(null);
				}
			}

			this.m.Item = null;
			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		_out.writeU8(this.m.Objectives.len());

		foreach( o in this.m.Objectives )
		{
			if (o != null && !o.isNull())
			{
				_out.writeU32(o.getID());
			}
			else
			{
				_out.writeU32(0);
			}
		}

		if (this.m.Item != null)
		{
			_out.writeBool(true);
			_out.writeI32(this.m.Item.ClassNameHash);
			this.m.Item.onSerialize(_out);
		}
		else
		{
			_out.writeBool(false);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local numObjectives = _in.readU8();

		for( local i = 0; i != numObjectives; i = i )
		{
			local o = _in.readU32();

			if (o != 0)
			{
				this.m.Objectives.push(this.WeakTableRef(this.World.getEntityByID(o)));
				local obj = this.m.Objectives[this.m.Objectives.len() - 1];

				if (!obj.isMilitary() && !obj.getSettlement().isMilitary() && !obj.getFlags().get("HasNobleProtection"))
				{
					local garbage = [];

					foreach( i, e in obj.getTroops() )
					{
						if (e.ID == ::Const.EntityType.Footman || e.ID == ::Const.EntityType.Greatsword || e.ID == ::Const.EntityType.Billman || e.ID == ::Const.EntityType.Arbalester || e.ID == ::Const.EntityType.StandardBearer || e.ID == ::Const.EntityType.Sergeant || e.ID == ::Const.EntityType.Knight)
						{
							garbage.push(i);
						}
					}

					garbage.reverse();

					foreach( g in garbage )
					{
						obj.getTroops().remove(g);
					}
				}
			}

			i = ++i;
		}

		local hasItem = _in.readBool();

		if (hasItem)
		{
			this.m.Item = this.new(this.IO.scriptFilenameByHash(_in.readI32()));
			this.m.Item.onDeserialize(_in);
		}

		this.contract.onDeserialize(_in);
	}

});

