this.return_item_contract2 <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Loot = null,
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.return_item";
		this.m.Name = "Return Item";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
		local orig = this.getDifficultyMult();

		if (this.getDifficultyMult() >= 1.45 && this.getDifficultyMult() <= 1.65)
		{
			local dm = this.Math.rand(155, 175) * 0.01;
			this.m.DifficultyMult = dm > orig ? dm : orig;
		}
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.roll_item();
		local value = this.m.Flags.get("IsLockbox") ? 1000 : this.m.Loot.getValue();
		this.m.Payment.Pool = value * 0.6 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		} else this.m.Payment.Completion = 1.0;
		this.contract.start();
	}

	function roll_item()
	{
		//determine the possible items to roll in the contract and if there are mercenaries
		local roll_tier = this.Math.rand(1, 10);
		local roll_enemies = this.Math.rand(1, 100);
		local range = [0, 1];
		if (roll_tier <= 1 && this.getDifficulty() >= 3) //rare items
		{
			if (roll_enemies <= 75) this.m.Flags.set("IsMercenary", true);
			range = [1, 5]; //FEATURE_1: Remove test code, adding placehoder numbers to skip books
		}
		else if (roll_tier <= 3 && this.getDifficulty() >= 1) //valuable items
		{
			if (roll_enemies <= 40) this.m.Flags.set("IsMercenary", true);
			range = [1, 5];
		}
		else range = [5, 9]; //common items

		//roll the item
		local item_ID = this.Const.Contracts.Return_Item.Pool[this.Math.rand(range[0], range[1])];

		//determine enemies
		roll_enemies = this.Math.rand(1, 100);
		switch(item_ID)
		{
			case "strange_tome":
				if (roll_enemies <= 75) this.m.Flags.set("IsNecromancer", true);
				break;
			case "lockbox":
				if (roll_enemies <= 15) this.m.Flags.set("IsAnatomist", true);
				else if (roll_enemies <= 30) this.m.Flags.set("IsCultist", true);
				break;
			case "scripts/items/weapons/named/legend_staff_ceremonial":
				if (roll_enemies <= 50) this.m.Flags.set("IsNecromancer", true);
				break;
			case "scripts/items/misc/lindwurm_bones_item":
			case "scripts/items/misc/unhold_bones_item":
				if (roll_enemies <= 75) this.m.Flags.set("IsAnatomist", true);
				break;
			case "scripts/items/misc/strange_eye_item":
				this.m.Flags.set("IsCultist", true);
				break;
		}

		//unpack the item
		local is_rune = false;
		switch(item_ID)
		{
			case "strange_tome":
				//FEATURE_1: Fill in book rolls for strange tome after magic made
				break;
			case "lockbox":
				this.m.Flags.set("IsLockbox", true);
				local lst_lockbox = [
					"scripts/items/misc/legend_ancient_scroll_item",
					"scripts/items/accessory/legend_demon_banshee_trophy_item",
					"scripts/items/accessory/berserker_mushrooms_item",
					"scripts/items/loot/bead_necklace_item",
					"scripts/items/accessory/ghoul_trophy_item",
					"rune"
				];
				item_ID = lst_lockbox[this.Math.rand(0, lst_lockbox.len())];
				is_rune = item_ID == "rune";
				if (is_rune) item_ID = "scripts/items/rune_sigils/legend_vala_inscription_token";
				break;
			case "heirloom_sword":
				local lst_swords = [
					"scripts/items/weapons/ancient/ancient_sword",
					"scripts/items/weapons/ancient/legend_gladius",
					"scripts/items/weapons/named/ancient_sword_named",
					"scripts/items/weapons/named/legend_gladius_named"
				];
				item_ID = lst_swords[this.Math.min(lst_swords.len() - 1, this.Math.rand(0, 101) / 25)];
				break;
		}

		//create and set item parameters
		this.m.Loot = this.new(item_ID);
		if (is_rune)
		{
			local runes = [6,11,12,13];
			this.m.Loot.setRuneVariant(runes[this.Math.rand(0, runes.len())]);
			this.m.Loot.setRuneBonus(true);
			this.m.Loot.updateRuneSigilToken();
		}
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return %item% to %townname%"
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
				if (!this.Flags.get("IsNecromancer") && !this.Flags.get("IsAnatomist") && !this.Flags.get("IsCultist") && this.Math.rand(1, 100) <= 30)
				{
					this.Flags.set("IsCounterOffer", true);
					this.Flags.set("Bribe", this.Contract.beautifyNumber(this.Contract.m.Payment.getOnCompletion() * this.Math.rand(200, 300) * 0.01));
				}

				this.Flags.set("StartDay", this.World.getTime().Days);
				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 15, [
					this.Const.World.TerrainType.Mountains
				]);

				local party;
				local party_type;
				local difficulty_modifier = 1.0;
				if (this.Flags.get("IsMercenary"))
				{
					party_type = this.Const.World.Spawn.Mercenaries;
					if (this.getDifficulty() <= 2) difficulty_modifier = 0.75;
				}
				else if (this.Flags.get("IsCultist"))
				{
					party_type = this.Const.World.Spawn.Cultists;
					difficulty_modifier = 1.5;

				} 
				else party_type = this.Const.World.Spawn.BanditRaiders;
				
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Thieves", false, party_type, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult() * difficulty_modifier);

				party.setDescription("A group of thieves.");
				party.setFootprintType(this.Const.World.FootprintsType.Brigands);
				party.setAttackableByAI(false);
				party.getController().getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				party.setFootprintSizeOverride(0.75);

				local chance = 25 + this.gameplay_improved.count_role("trait.tracker") * 10;
				local r = this.Math.rand(1, 100);
				this.Flags.set("INVESTIGATION_CHANCE", chance);
				this.Flags.set("INVESTIGATION_ROLL", r);

				if (r <= chance)
				{
					this.Flags.set("Investigation", 2);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);
				}
				else
				{
					if (r <= chance + 15)
					{
						local party2;
						for (local i = 0 ; i < 3 ; i++) {
							tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 15, [
								this.Const.World.TerrainType.Mountains
							]);
							party2 = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Thieves", false, this.Const.World.Spawn.BanditRaiders, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());

							this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party2.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);

							party2.die();
						}

						this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.GenericFootprints, this.Const.World.FootprintsType.Brigands, 0.75);

						this.Flags.set("Investigation", 1);
					}
					else
					{
						this.Flags.set("Investigation", 0);
					}
				}
				

				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_bandits_0" + this.Math.rand(1, 6));
				local c = party.getController();
				local wait = this.new("scripts/ai/world/orders/wait_order");
				wait.setTime(9000.0);
				c.addOrder(wait);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);

				
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return %item% to %townname%"
				];

				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (!this.Flags.get("HasInvestigated"))
				{
					this.Flags.set("HasInvestigated", true)
					switch(this.Flags.get("Investigation"))
					{
						case 0:
							this.Contract.setScreen("Investigation0");
							break;
						case 1:
							this.Contract.setScreen("Investigation1");
							break;
						case 2:
							this.Contract.setScreen("Investigation2");
							break;
					}
					this.World.Contracts.showActiveContract();
				}
				else if (this.Contract.m.Target == null || this.Contract.m.Target.isNull())
				{
					if (this.Flags.get("IsCounterOffer"))
					{
						this.Contract.setScreen("CounterOffer1");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("BattleDone");
						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.World.getTime().Days - this.Flags.get("StartDay") >= 3 && this.Contract.m.Target.isHiddenToPlayer())
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (!this.Flags.get("IsAttackDialothisriggered"))
				{
					if (this.Flags.get("IsNecromancer"))
					{
						this.Flags.set("IsAttackDialothisriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Necromancer");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsCultist"))
					{
						this.Flags.set("IsAttackDialothisriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Cultists");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsAnatomist"))
					{
						this.Flags.set("IsAttackDialothisriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Anatomist");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Flags.set("IsAttackDialothisriggered", true);
						this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
						this.Contract.setScreen("Bandits");
						this.World.Contracts.showActiveContract();
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return %item% to %townname%"
				];
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
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "Negotiations",
			Text = "[img]gfx/ui/events/event_20.png[/img]{%employer% restlessly walks back and forth while explaining what troubles him.%SPEECH_ON%There has been an audacious act of thievery! My %itemLower%, which is of immeasurable value to me, is missing. I implore you to hunt down those thieves and return that item to me.%SPEECH_OFF%He lowers his voice to an insisting tone.%SPEECH_ON%Not only will you get paid handsomely, but you would also set the worried minds of the good people of %townname% to rest!%SPEECH_OFF% | %employer%\'s reading one of many scrolls. He angrily tosses it onto a pile of others.%SPEECH_ON%The people of %townname% are rightfully furious. Do you know thieves have managed to steal my %itemLower% from us? That artifact is of immeasurable value to me! And... to the people, of course.%SPEECH_OFF%You shrug.%SPEECH_ON%And you want me to get it back for you?%SPEECH_OFF%The man points a finger.%SPEECH_ON%Precisely, smart sellsword! That is exactly what I want you to do. Follow the footprints of thievery and return to me the item which I... the town, rightfully owns!%SPEECH_OFF% | %employer%\'s turning an apple in hand. He seems frustrated with it, almost as if he wishes it were something else like a valuable trinket or perhaps just a tastier fruit.%SPEECH_ON%Have you ever lost something you loved?%SPEECH_OFF%You shrug and answer.%SPEECH_ON%There was this girl...%SPEECH_OFF%The man shakes his head.%SPEECH_ON%No, not some woman. More important. Because I have! Thieves stole my %itemLower%. How they managed to do get beyond my guards is, well, beyond me. But I know if I set you on them I\'ll be having what is rightfully mine back where it belongs. Isn\'t that right? Or have I been mislead as to the quality of your services?%SPEECH_OFF% | A dog is snoring at the feet of %employer%. He leans forward to gently pet the hound behind its ears.%SPEECH_ON%I hear you have a nose for finding people, sellsword. For... solving problems.%SPEECH_OFF%You nod. It is true, after all.%SPEECH_ON%Good... good... I have a task for you. A simple one. Something of great value to me has been stolen, my %itemLower%. I need you to track down those who stole it, kill them, obviously, and then bring back the item.%SPEECH_OFF% | A bird is perched on %employer%\'s window. The man, seated, points at it.%SPEECH_ON%I wonder if that\'s how they got in. The thieves, I mean. I think they must\'ve snuck through a window and then right back out. That\'s how they got away with my %itemLower%.%SPEECH_OFF%The man slowly rises and stalks across the room. He crouches, about ready to pounce on the bird, but the creature scatters before the man can so much as flinch.%SPEECH_ON%Damn.%SPEECH_OFF%He returns to his seat, wiping his hands as if he\'d worked up a sweat during his attempted avian ambush.%SPEECH_ON%My task is simple, sellsword. Bring my property back to me. Kill the thieves, too, if you wouldn\'t mind.%SPEECH_OFF% | Dust covers %employer%\'s table, but there is a spot oddly cleaner than the rest. He gestures to it.%SPEECH_ON%That\'s where my %itemLower% used to sit. If you couldn\'t tell, it\'s gone.%SPEECH_OFF%You nod. It does appear to be missing.%SPEECH_ON%The thieves who took it should be easy to track down. They\'re good thinkers in the night, those thieves, but they make mistakes aplenty during the day. Footprints, crowns ill-spent... you should be able to track them down with ease.%SPEECH_OFF%He looks at you with a stern eye.%SPEECH_ON%Do you understand, mercenary? I want you to get my property back. I want it placed right where it belongs. And... I want those thieves dead in the mud.%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{What\'s this worth to you? | Let\'s talk pay.}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{This doesn\'t sound like our kind of work. | I don\'t think so.}",
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
			ID = "Investigation2",
			Title = "Investigation",
			Text = "[img]gfx/ui/events/event_20.png[/img]Having concluded the negotiations, you and your men investigate the scene of the crime, and the surroundings, as well as questioning the locals.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Onwards!",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]" + "The chance for even a perfect investigation was " + this.Flags.get("INVESTIGATION_CHANCE") + ". You rolled " + this.Flags.get("INVESTIGATION_ROLL") + "[/color]."
				});

				this.List.push({
					id = 10,
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.PositiveEventValue + "]" + "You find some tracks and determine the group that must've carried away the item." + "[/color]."
				});

				this.List.push({
					id = 10,
					icon = "ui/icons/warning.png",
					text = "Find more mercenaries with the tracker trait to improve investigation."
				});
			}
		});
		this.m.Screens.push({
			ID = "Investigation1",
			Title = "Investigation",
			Text = "[img]gfx/ui/events/event_20.png[/img]Having concluded the negotiations, you and your men investigate the scene of the crime, and the surroundings, as well as questioning the locals.)",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Well that sucks.",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.NegativeEventValue + "]" + "The chance for even a partially successful investigation was " + (this.Flags.get("INVESTIGATION_CHANCE") + 15) + ". You rolled " + this.Flags.get("INVESTIGATION_ROLL") + "[/color]."
				});

				this.List.push({
					id = 10,
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.NegativeEventValue + "]" + "You fail to find any tracks at all. Good luck catching the thieves!" + "[/color]."
				});

				this.List.push({
					id = 10,
					icon = "ui/icons/warning.png",
					text = "Find more mercenaries with the tracker trait to improve investigation."
				});
			}
		});
		this.m.Screens.push({
			ID = "Investigation0",
			Title = "Investigation",
			Text = "[img]gfx/ui/events/event_20.png[/img]Having concluded the negotiations, you and your men investigate the scene of the crime, and the surroundings, as well as questioning the locals.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Well that sucks.",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/hitchance.png",
					text = "[color=" + this.Const.UI.Color.NegativeEventValue + "]" + "The chance for even a partially successful investigation was " + (this.Flags.get("INVESTIGATION_CHANCE") + 15) + ". You rolled " + this.Flags.get("INVESTIGATION_ROLL") + "[/color]."
				});

				this.List.push({
					id = 10,
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.NegativeEventValue + "]" + "You fail to find any tracks at all. Good luck catching the thieves!" + "[/color]."
				});

				this.List.push({
					id = 10,
					icon = "ui/icons/warning.png",
					text = "Find more mercenaries with the tracker trait to improve investigation."
				});
			}
		});
		this.m.Screens.push({
			ID = "Bandits",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_80.png[/img]You catch the group of thieves lugging your employer\'s property around. No time is wasted trying to parlay - they arm themselves and you order the %companyname% to charge.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To Arms!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Necromancer",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_76.png[/img]{There\'s brigands here, just as expected, but they are handing the %itemLower% to a man in dark, ragged clothes. Your presence, unsurprisingly, brings a halt to the transaction and both the thugs and the ghoulish figure take up weapons. | You catch brigands trading %employer%\'s property to what appears to be a necromancer! Maybe he wanted it to cast some sort of vicious spell upon the house. In some light, the notion doesn\'t seem that bad... but, the man\'s paying you for a reason. Charge! | %employer%\'s property is being sold off by brigands to a pale man in black! He glares at you before anyone else, his beady black eyes narrowing on your company in an instant.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To Arms!",
					function getResult()
					{
						this.Const.World.Common.addTroop(this.Contract.m.Target, {
							Type = this.Const.World.Spawn.Troops.Necromancer
						});
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Cultists",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_140.png[/img]{Up ahead, you see a bunch of men donned in strange masks and attire. Without a word, they silently draw their weapons and attack.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To Arms!",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Anatomist",
			Title = "As you approach...",
			Text = "[img]gfx/ui/events/event_133.png[/img]{The thieves are here, just as expected, but they are handing the %itemLower% to anatomist and his bodyguard. Your presence, unsurprisingly, brings a halt to the transaction and both the thugs and the figure take up weapons.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "To Arms!",
					function getResult()
					{
						this.Const.World.Common.addTroop(this.Contract.m.Target, {
							Type = this.Const.World.Spawn.Troops.Anatomist
						});
						this.Const.World.Common.addTroop(this.Contract.m.Target, {
							Type = this.Const.World.Spawn.Troops.BanditThugPotioned
						});
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CounterOffer1",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_76.png[/img]{You clean the blood off your sword and then go to retrieve the item. As you bend over to pick it up, you spot a man watching you in the distance. He comes forth, his two hands totemed together with long sleeves.%SPEECH_ON%I see you\'ve killed my benefactor\'s men.%SPEECH_OFF%Sheathing your sword, you nod at the man. He continues.%SPEECH_ON%My benefactor paid good money for that artifact. It appears those he paid are no longer owed, so maybe I can speak to you directly. I will give you %bribe% crowns for the item.%SPEECH_OFF%That... is a good amount of money. %employer%, however, will not be happy if you decide to accept... | After the battle, a man emerges from a tree line, clapping his hands together.%SPEECH_ON%I paid those men a great deal of crowns, but it appears I should have paid you. And now that all these skeevy brigands are dead, I can!%SPEECH_OFF%You tell the man to get to the point before you run him through with a sword. He gestures toward the artifact.%SPEECH_ON%I\'ll pay you %bribe% crowns (originally %reward_completion% crowns) for the item. It was what was originally owed to these thieves, plus a little more. What do you say?%SPEECH_OFF%%employer% won\'t take kindly to your betrayal, but that is a good bit of money... | The battle over, you pick up the %itemLower% and look it over. Was this really worth the lives of so many people?%SPEECH_ON%I know what you\'re thinking, sellsword.%SPEECH_OFF%The voice breaks in. You draw your sword and aim it at a stranger who has seemingly appeared from nowhere.%SPEECH_ON%You\'re thinking, what if someone paid good money to steal that there artifact? What if that someone would pay me a good deal of money? Perhaps... more than the man who paid you to retrieve it in the first place.%SPEECH_OFF%You lower your weapon and nod.%SPEECH_ON%An interesting thought.%SPEECH_OFF%The man smiles.%SPEECH_ON%%bribe% crowns (originally %reward_completion% crowns). That\'s how much I\'ll give you for it. That was the thieves\' share plus extra. A more than fair deal. Of course, your employer will be most unhappy, but... well, that\'s not my choice to make.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "I know a good deal when I see one. Hand over the crowns.",
					function getResult()
					{
						this.updateAchievement("NeverTrustAMercenary", 1, 1);
						return "CounterOffer2";
					}

				},
				{
					Text = "We\'re paid %reward_completion% to return it, and that\'s what we\'ll do.",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CounterOffer2",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_76.png[/img]You hand over the %itemLower% and the stranger slips you a very heavy, very drooping satchel. The deal is done. It\'s safe to assume that %employer%, your employer, won\'t be happy about this.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Good pay.",
					function getResult()
					{
						local temp = this.Flags.get("IsLockbox") ? "lockbox" : this.Contract.m.Loot.getName();
						this.World.Assets.addMoney(this.Flags.get("Bribe"));
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "Failed to return stolen " + temp);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Flags.get("Bribe") + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "BattleDone",
			Title = "After the battle...",
			Text = "[img]gfx/ui/events/event_22.png[/img]{The battle over, you retrieve the %itemLower% from the wasted clutches of your enemies and prepare to return to %employer%. He will surely be happy to see of your success! | Those who stole the %itemLower% are dead, and thankfully you were able to find the item itself. %employer% will be most pleased with your work here. | Well, you found those responsible for stealing the %itemLower% and put them to the sword. Now you just need to put the %itemLower% back into %employer%\'s hands and get your reward! | The battle is done and the %itemLower% was easy to find amongst the corpses of your enemies. You should probably return it to %employer% for your just reward!}",
			Image = "",
			List = [],
			Options = [],
			function start()
			{
				if (!this.Flags.get("IsLockbox"))
				{
					this.List.push({
						id = 10,
						icon = "ui/items/" + this.Contract.m.Loot.getIcon(),
						text = "What to do with " + this.Contract.m.Loot.getName() + "?"
					});
				}
				
				this.Options.push({
					Text = "Let\'s take it for ourselves.",
					function getResult()
					{
						//change reputation
						this.updateAchievement("NeverTrustAMercenary", 1, 1);
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
						local temp = this.Flags.get("IsLockbox") ? "lockbox" : this.Contract.m.Loot.getName();
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationBetrayal, "Betrayed them and did not return the " + temp);

						//set flag for future ambush event
						if (this.World.Statistics.getFlags().has("StolenItemRevenge")) this.World.Statistics.getFlags().increment("StolenItemRevenge");
						else this.World.Statistics.getFlags().add("StolenItemRevenge", 1);
						
						if (this.Flags.get("IsLockbox")) return "Lockbox";
						this.World.Assets.getStash().add(this.Contract.m.Loot);

						this.World.Contracts.finishActiveContract(true);
						return 0;
					}
				});
				this.Options.push({
					Text = "Let\'s return the item.",
					function getResult()
					{
						this.Contract.setState("Return");
						return 0;
					}
				});
			}
		});
		this.m.Screens.push({
			ID = "Lockbox",
			Title = "Opening the lockbox...",
			Text = "[img]gfx/ui/events/event_22.png[/img]{You crack open the lockbox and find...}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Onwards.",
					function getResult()
					{
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.World.Assets.getStash().add(this.Contract.m.Loot);
				this.List.push({
					id = 10,
					icon = "ui/items/" + this.Contract.m.Loot.getIcon(),
					text = "You gain " + this.Contract.m.Loot.getName()
				});
			}
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "On your return...",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% takes the %itemLower% from you, hugging it close as though he\'d retrieved a lost child. His eyes get a little teary just looking at his artifact.%SPEECH_ON%Thank you, sellsword. This means a lot to me... I mean, uh, the town. You have our gratitude!%SPEECH_OFF%He pauses as you stare at him. His eyes bounce to a corner of the room.%SPEECH_ON%Our... gratitude, sellsword...%SPEECH_OFF%A large wooden chest is opened by a guard. You count the crowns and go. | When you return to %employer% he is playing with a bird in a cage.%SPEECH_ON%Ah, the sellsword returns... and?%SPEECH_OFF%You hold up the artifact and then set it on his desk. He takes it, turns it, nods, then puts it away.%SPEECH_ON%Excellent. And for your troubles...%SPEECH_OFF%He waves his hand to a wooden chest filled with crowns. | %employer%\'s resting his legs on two dogs, each one passed out atop the other.%SPEECH_ON%These beasts could rip my throat out, yet... look at them. How does that happen? I didn\'t even train them. Someone else did. I\'m a stranger to them yet there they are.%SPEECH_OFF%You place the artifact on the man\'s table and slide it across. He leans forward, takes it, then places it under his desk. When his hand returns, he\'s got a satchel in hand. He tosses it over.%SPEECH_ON%As promised. Good work, sellsword.%SPEECH_OFF% | When you enter %employer%\'s room, there are a host of guards surrounding him. For a second, you think you\'ve stumbled upon a coup, but the men clear out, leaving behind dice and cards. %employer% waves you in.%SPEECH_ON%Come, come. I just lost a good deal of crowns, sellsword. Perhaps you\'ve brought something to help ease my pains...?%SPEECH_OFF%You take out the %itemLower% and hold it in your hand. Rather gingerly, the man takes it.%SPEECH_ON%Good... very good... your pay, of course, is here.%SPEECH_OFF%He hands over a satchel of crowns before turning around in his chair. He seems too consumed by the artifact to say anything else. | %employer% grins as you enter.%SPEECH_ON%Sellsword, sellsword, will you sell me word of your success?%SPEECH_OFF%You take out the artifact and place it on his table.%SPEECH_ON%Sure.%SPEECH_OFF%The man jolts forward in his chair and takes the item away. He turns back to you, calming himself returning his composure.%SPEECH_ON%Good. You did good. Very good. %reward_completion% crowns, as promised.%SPEECH_OFF%He hands over a sack of coins.}",
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
						local temp = this.Flags.get("IsLockbox") ? "lockbox" : this.Contract.m.Loot.getName();
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "Returned stolen " + temp);
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
			Title = "Along the way...",
			Text = "[img]gfx/ui/events/event_75.png[/img]{You lower yourself to the earth, letting some dirt filter through your fingers. But it is only dirt - there are no footprints that have crossed its path. In fact, you haven\'t seen any footprints in a good while. %randombrother% joins you, crouching low and shrugging.%SPEECH_ON%Sir, I think we lost \'em.%SPEECH_OFF%You nod. %employer% won\'t be happy about this, but it is what it is. | You\'ve been following the trail of the stolen %itemLower% for a good while now, but the leads have dried up. The commoners you pass know nothing, and the earth shows no footprints with which to track. For all intents and purposes, the %itemLower% is gone. %employer% will not be pleased. | A footprint left long enough is soon stepped on by another. And another. And another. You spent so long catching up to the thieves who stole the %itemLower% that the circuitry of the world, ever busy, has covered their tracks. You\'ve no hope of finding them now and %employer% will be most displeased. | The tracks of the %itemLower%\'s thieves have gone dry. The last set of footprints you followed took you to a homestead, and they didn\'t look like the thieving sort, nor did they know of any such fellows. %employer% won\'t be happy about the loss of his goods, but there\'s little you can do here now.}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Damn this contract!",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						local temp = this.Flags.get("IsLockbox") ? "lockbox" : this.Contract.m.Loot.getName();
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "Failed to return stolen " + temp);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
	}

	function onPrepareVariables( _vars )
	{
		local test = this.m.Loot.getName();
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
		_vars.push([
			"item",
			this.m.Loot.getName()
		]);
		_vars.push([
			"itemLower",
			this.m.Loot.getName().tolower()
		]);
		_vars.push([
			"bribe",
			this.m.Flags.get("Bribe")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

