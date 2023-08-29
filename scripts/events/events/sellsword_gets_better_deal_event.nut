this.sellsword_gets_better_deal_event <- this.inherit("scripts/events/event", {
	m = {
		Sellsword = null,
		Amount = 0,
		OldPay = 0
	},
	function create()
	{
		this.m.ID = "event.sellsword_gets_better_deal";
		this.m.Title = "During camp...";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]While counting inventory, %sellsword% joins your side, mindlessly picking at this sword or that shield. You set your quill pen down and ask what\'s up for the hired blade sure as shit isn\'t here to count anything. The sellsword explains that another company wishes to use the mercenary\'s swordhand - and they\'re willing to pay more. You ask how much and the sellsword holds up hands to count.%SPEECH_ON%They\'re talking %newpay% crowns a day.%SPEECH_OFF% %sellsword%\'s earning %pay% crowns a day with you.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I see, time to part ways then.",
					function getResult( _event )
					{
						_event.m.Sellsword.getSkills().onDeath(this.Const.FatalityType.None);
						this.World.Statistics.addFallen(_event.m.Sellsword, "Got a better paying offer");
						this.World.getPlayerRoster().remove(_event.m.Sellsword);
						return 0;
					}

				},
				{
					Text = "There must be a way I can talk you out of this.",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= _event.m.Sellsword.getLevel() * 10 ? "B" : "C";
					}

				},
				{
					Text = "Then I shall match their offer.",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sellsword.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img] You turn around, crossing your arms and jacking a boot against a crate. Staring out across the land, you tell %sellsword% that the company has been through a lot together and everyone, yourself especially, would hate to say farewell. There is a second family here with the %companyname% and that\'s a rare treat in the mercenary world. In other companies there is no guarantee of what may be found. You know, because you\'ve been there. You\'ve been in the sellsword\'s very shoes, and you took those shoes and walked. And regretted it.\n\nThe sellsword looks at the ground, thinking your words over. Finally the hired blade nods and agrees to stay. You reaffirm that it is definately the right choice. The mercenary turns and taps a quiver of arrows while walking away.%SPEECH_ON%Might want to refill that.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Glad you\'re staying with us.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sellsword.getImagePath());
				_event.m.Sellsword.getFlags().add("convincedToStayWithCompany");
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_16.png[/img] You turn around, crossing your arms and jacking a boot against a crate. Staring out across the land, you tell %sellsword% that the company has been through a lot together and everyone, yourself especially, would hate to say farewell. There is a second family here with the  %companyname% and that\'s a rare treat in the mercenary world. In other companies there is no guarantee of what may be found. You know, because you\'ve been there. You\'ve been in the sellsword\'s very shoes, and you took those shoes and walked. And regretted it.\n\n The sellsword looks at the ground, thinking your words over. Finally the hired blade\'s head shakes slowly, with pursed lips and a look of \'sorry\'. You argue that it is the wrong choice, but %sellsword%\'s having none of it. The mercenary turns and taps a quiver of arrows while walking away.%SPEECH_ON%Might want to refill that.%SPEECH_OFF%The arrows are a little low, but all you can think about is figuring out how to replace such a good swordhand",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A damn shame.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Sellsword.getName() + " leaves the " + this.World.Assets.getName()
				});
				_event.m.Sellsword.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Sellsword.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.Statistics.addFallen(_event.m.Sellsword, "Got a better paying offer");
				this.World.getPlayerRoster().remove(_event.m.Sellsword);
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_04.png[/img] You sigh. %sellsword% nods and starts to leave, but you stop the mercenary. You\'ll pay the amount to stay the move. The %companyname% simply cannot afford to lose a blade like that.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A good sword doesn\'t come cheap.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sellsword.getImagePath());
				_event.m.Sellsword.getBaseProperties().DailyWage += _event.m.Amount;
				_event.m.Sellsword.getSkills().update();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Sellsword.getName() + " is now paid " + _event.m.Sellsword.getDailyCost() + " crowns a day"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Retinue.hasFollower("follower.paymaster"))
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 4 && bro.getLevel() <= 9 && this.Time.getVirtualTimeF() - bro.getHireTime() > this.World.getTime().SecondsPerDay * 25.0 && bro.getBackground().getID() == "background.sellsword" && !bro.getFlags().has("convincedToStayWithCompany"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Sellsword = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Amount = this.Math.rand(5, 15);
		this.m.OldPay = this.m.Sellsword.getDailyCost();
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"sellsword",
			this.m.Sellsword.getName()
		]);
		_vars.push([
			"newpay",
			this.m.OldPay + this.m.Amount
		]);
		_vars.push([
			"pay",
			this.m.OldPay
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Sellsword = null;
		this.m.Amount = 0;
		this.m.OldPay = 0;
	}

});

