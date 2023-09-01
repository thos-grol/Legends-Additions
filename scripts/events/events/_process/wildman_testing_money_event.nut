this.wildman_testing_money_event <- this.inherit("scripts/events/event", {
	m = {
		Wildman = null,
		OtherGuy = null,
		Item = null
	},
	function create()
	{
		this.m.ID = "event.wildman_testing_money";
		this.m.Title = "During camp...";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_04.png[/img]You find %wildman% the wildling stacking crowns into towers. %wildman% leans back from these moneyed manifestations with a wide grin, but then suddenly launches forward, knocking the towers over like a child would their blocks. %wildman% laughs maniacally as the coins scatter, seeing someone playing with money like this is a curious sight. Perhaps the wildling has no real conception of what crowns are good for? If so, maybe... maybe you could take them back?",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Let\'s see if %wildman% will trade it all away for something else.",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "Better to leave the wildling crowns alone.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				_event.m.Wildman.getFlags().set("IsConceptionOfMoneyTested", true);
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_04.png[/img]You crouch down.%SPEECH_ON%Hey there %wildman%. Mind if I take one of these?%SPEECH_OFF%Carefully, you pick up a coin and measure the wildling\'s reaction. %wildman% shrugs and grunts as if to say \'it\'s yours\'. You take another crown. And then another. The wildling glares at you, but you slowly produce a stick with a frilly bow tied to the top. Its whirly nature captures the wildling\'s eye. When %wildman% reaches out for it, you draw it back and shake your head. You then point at the crowns, and then at the stick.%SPEECH_ON%One for the other, yes?%SPEECH_OFF%The wildman looks at the crowns, mulling them over like an accountant, but you know their thoughts are far more chaotic than that. Suddenly, %wildman% growls and pushes the crowns forward and takes the stick away from you. Looks like the trade is done.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That went well.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				this.Characters.push(_event.m.Wildman.getImagePath());
				local money = 10 * _event.m.Wildman.getDaysWithCompany();
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_06.png[/img]You crouch down and look at the mess of crowns.%SPEECH_ON%Those are real shiny, huh?%SPEECH_OFF%The wildling grunts and tries to shoo you away. Resisting, you pick up a crown. %wildman%\'s hands drop and head jerks up, glaring at you. Slowly, you put the coin down and then produce a stick with a string wrapped around its top. %wildman% stare slackens, the sturdy stick a slick treat to the unkempt wildling. You motion that you\'ll give it in exchange for the crowns. %wildman% takes the stick. You take the crowns.\n\n But when the wildling plays with the string, it falls off and blows away in the wind. %wildman% cries out, then stares murderously at you, yourself standing there with both arms barreled to try and hold all the crowns. The wildling screams. You drop the crowns and run as fast as you can. There is all manner of chaos going on behind you - tools and weapons being broke, mercenaries running for their lives, and the absolute bedlam of a bunch of confused people beset by a wildling - but you dare not look.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Probably should not have done that.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				this.Characters.push(_event.m.Wildman.getImagePath());
				_event.m.Wildman.worsenMood(1.0, "Did a bad trade");

				if (_event.m.Wildman.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Wildman.getMoodState()],
						text = _event.m.Wildman.getName() + this.Const.MoodStateEvent[_event.m.Wildman.getMoodState()]
					});
				}

				local injury = _event.m.OtherGuy.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.OtherGuy.getName() + " suffers " + injury.getNameOnly()
				});

				if (_event.m.Item != null)
				{
					this.World.Assets.getStash().remove(_event.m.Item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + _event.m.Item.getIcon(),
						text = "You lose " + this.Const.Strings.getArticle(_event.m.Item.getName()) + _event.m.Item.getName()
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if ((bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.wildwoman") && !bro.getFlags().get("IsConceptionOfMoneyTested"))
			{
				candidates.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		this.m.Wildman = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.OtherGuy = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates.len() * 3;
	}

	function onPrepare()
	{
		local items = this.World.Assets.getStash().getItems();
		local candidates = [];

		foreach( item in items )
		{
			if (item == null)
			{
				continue;
			}

			if (item.isItemType(this.Const.Items.ItemType.Legendary) || item.isIndestructible())
			{
				continue;
			}

			if (item.isItemType(this.Const.Items.ItemType.Weapon) || item.isItemType(this.Const.Items.ItemType.Shield) || item.isItemType(this.Const.Items.ItemType.Armor) || item.isItemType(this.Const.Items.ItemType.Helmet))
			{
				candidates.push(item);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Item = candidates[this.Math.rand(0, candidates.len() - 1)];
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Wildman = null;
		this.m.OtherGuy = null;
		this.m.Item = null;
	}

});

