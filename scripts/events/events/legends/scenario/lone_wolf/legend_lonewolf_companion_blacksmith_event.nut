this.legend_lonewolf_companion_blacksmith_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Looted = 0
	},
	function create()
	{
		this.m.ID = "event.legend_lonewolf_companion_blacksmith";
		this.m.Title = "Last stand";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_30.png[/img]{As you wander a common sight comes into view — an isolated gathering of homes with no name is in the process of being raided. Figures of all shapes and sizes dart from home to home, taking anything that isn\'t nailed down or fighting back. In the distance, a stockier figure dressed in a blacksmith\'s apon is holding their ground, cutting bandits down left, right and centre.\n However, they show signs of beginning to slow down.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Loot the houses while you have the chance!",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Ignore the homes, focus on forming a pointed formation to drive a wedge through to the blacksmith.",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "Another normal day — let\'s get out of here.",
					function getResult( _event )
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_132.png[/img]{You order the company to fan out and search all the houses that aren\'t currently on fire. Everyone picks a direction and the lesser equipped looters either run or don\'t put up much of a fight. You enter through the doorway and find what remains of a small family huddled in the corner, covered in their own blood or that of somebody they once knew.\n\n You drag your arm across a table and shovel everything into a nearby grain sack. You don\'t know what you got — but the jingling inside pleases you.\n\n Outside the bedlam has receeded — the once proud blacksmith now lies face first in a puddle of mud and blood, a small blade lodged between their ribs from behind. You peer closer and see their sword is absent from their hands. Pity. The smell of ash, cinder and fire fills your nose as two wild dogs pick at the carcass of a child.\n\n Everyone is back from the raid with no marks on them at all. They have already poured a pile of loot onto the ground and have begun to count through the equipment, food and coin into more orderly piles. You look back towards the village and everything has gone quiet. A few survivors try to scrape back togeather what they can as you spot a small gathering of undead slowly shambling from beyond a nearby hill towards the village — drawn by the screaming and smoke.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We should get out of here.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(150, 500);
				this.World.Assets.addMoney(money);

				if (_event.m.Looted == 1)
				{
					local item = this.new("signet_ring_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					this.World.Assets.addMoney(money);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gained [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_50.png[/img]{The company quickly forms in behind you, staggering their swinging arcs in an oblique order with you at the speartip. You begin a slow but steady forward march, and occasional thrown spear heralding your advance as it foinds a mark in the braver looters. The bandits and scavengers begin to disperse, perhaps mistaking you for a noble patrol coming to save the day.\n\n Another looter throws hismelf at you, who you kick to the ground before %randombrother% finishes them off. The blacksmith is in sight, curved sword in hand slashing down on each looter as they come within reach. The remaining looters lose ground and flee as %companyname% cuts through to the blacksmith, who has collapsed from exhaustion.\n What remains of the militia cheer or grumble as the rest of the looters disappear.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We can introduce ourselves when they wake up.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"legend_blacksmith_background"
				]);
				_event.m.Dude.getSprite("miniboss").setBrush("bust_miniboss");
				_event.m.Dude.getBaseProperties().Hitpoints += 3;
				_event.m.Dude.getBaseProperties().Bravery += 10;
				_event.m.Dude.getBaseProperties().Stamina += 4;
				_event.m.Dude.getBaseProperties().MeleeSkill += 8;
				_event.m.Dude.getBaseProperties().RangedSkill += 0;
				_event.m.Dude.getBaseProperties().MeleeDefense += 5;
				_event.m.Dude.getBaseProperties().RangedDefense += 5;
				_event.m.Dude.getBaseProperties().Initiative += 5;
				_event.m.Dude.m.PerkPoints = 6;
				_event.m.Dude.m.LevelUps = 6;
				_event.m.Dude.m.Level = 7;
				_event.m.Dude.m.XP = ::Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(::Const.Attributes.COUNT, 0);
				talents[::Const.Attributes.MeleeSkill] = 2;
				talents[::Const.Attributes.MeleeDefense] = 3;
				talents[::Const.Attributes.Hitpoints] = 2;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
				_event.m.Dude.items.unequip(this.items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.items.equip(this.new("scripts/items/weapons/shamshir"));
				_event.m.Dude.getBackground().m.RawDescription = "%name% specialised in forging exotic weapons for nobility — however their fighting style and skill tells you there is more to them than initally meets the eye, even if they don\'t want to talk about it.";
				_event.m.Dude.addLightInjury();
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_94.png[/img]I\'m not waiting around for this. It isn\'t our problem.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Life goes on.",
					function getResult( _event )
					{
						return 0;
					}

				}
			]
		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf") return;
		local brothers = this.World.getPlayerRoster().getAll();
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax()) return;
		this.m.Score = 16;
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Looted = null;
	}

});

