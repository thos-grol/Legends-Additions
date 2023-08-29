this.greenskins_outro_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_outro";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]You come across a handful of soldiers from %randomnoblehouse%. They tilt their caps at you.%SPEECH_ON%Evening, mercenaries.%SPEECH_OFF%Not sure if they\'re about to attack, you make a subtle nod toward %dude%. He puts his weapon within hand\'s reach and nods back. You return your attention to the soldiers, giving them a friendly wave. Their lieutenant steps forward, grinning.%SPEECH_ON%Oy\' mercenary, we\'ve little use for you in this world now.%SPEECH_OFF%Slowly, you lower your hand, hovering it above the pommel of your sword. You ask what the man means by that. He laughs.%SPEECH_ON%You haven\'t heard? War\'s over. The greenskins were routed from %randomtown% just a few days ago. Scouts report seeing them bastards running for the hills every which way, fighting amongst themselves, the orcs killing the goblins, goblins killing the orcs, just a full on rout. So, yeah, noble houses need not pay your sorry arse for nothing now because us real soldiers got it under control. Now why don\'t you and your pathetic lot clear out of the way. Us fighters got places to be, understand?%SPEECH_OFF%",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "Let\'s move to let these heroes of the realm pass.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "You handle him, %dude%.",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.updateAchievement("GreenskinSlayer", 1, 1);

				if (this.World.Assets.isIronman())
				{
					this.updateAchievement("ManOfIron", 1, 1);
				}

				if (this.World.Assets.isIronman())
				{
					local defeated = this.getPersistentStat("CrisesDefeatedOnIronman");
					defeated = defeated | this.Const.World.GreaterEvilTypeBit.Greenskins;
					this.setPersistentStat("CrisesDefeatedOnIronman", defeated);

					if (defeated == this.Const.World.GreaterEvilTypeBit.All)
					{
						this.updateAchievement("Savior", 1, 1);
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]%dude% reaches for his weapon, but you shake your head. The lieutenant nods toward the mercenary.%SPEECH_ON%Best keep that dog on its leash, aye?%SPEECH_OFF%You fan your arm out, inviting the soldiers a \'passage\' they knew they already had. The soldiers gear up and the lieutenant smirks.%SPEECH_ON%I knew you\'d make the right choice. We\'re just \'aving a bit of fun, yeah? You ladies stay tight.%SPEECH_OFF%The man blows a kiss as he walks by. %dude% stands up looking like someone just socked his mother. You tell him to sit back down and he begrudgingly does so. It\'s all bullshit, these theatrics, but you\'re not one to lose your temper and get people killed over it.\n\nThe incident does make you wonder if maybe it\'s time to turn it all in. The greenskins are beaten back and you\'ve made enough money to leave the life for good, but then again you\'d hate to live out the rest of your days wondering \'what if\'...\n\n%OOC%Something burns down inside of you. Something that struggles to be free. Perhaps it is the success you have have had along the way, or the failings that you couldn\'t stop in time. Maybe there is more out there to see?%OOC_OFF%",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "The %companyname% needs their commander!",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "It\'s time to retire from mercenary life. (End Campaign)",
					function getResult( _event )
					{
						this.World.State.getMenuStack().pop(true);
						this.World.State.showGameFinishScreen(true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]The soldiers\' lieutenant glares at you.%SPEECH_ON%Do as I said, sellsword, or there will be trouble.%SPEECH_OFF%Ignoring him, you give another nod to %dude%. He gets up, the blade of his weapon loudly scraping off the dirt. The soldiers turn to the mercenary. He hefts his weapon into both hands and stares back. As the lieutenant starts to talk, %dude% bluntly interrupts.%SPEECH_ON%Shush, little man. I see softness in your skin. Not a scar to be seen. Eyes as fresh as the day they were born. Hands as smooth as untouched candles. If you was of the fightin\' sort, you\'d be out there in those battles you speak of, not out here pissing into the wind. I\'ll give you two options because I\'m feeling nice. First option, are you listening? First option is this. Go where you are going and don\'t say another goddam word.%SPEECH_OFF%He pauses to hold up two fingers.%SPEECH_ON%Option two is a mystery. Speak and ye shall learn of it.%SPEECH_OFF%The lieutenant\'s eyes have gotten a little wider, and his mouth infinitely quieter. He glances at you, but all you can do is shrug. After another moment, the soldiers hurry away with determined silence.\n\n%dude% laughs it up, but the incident has you wondering if perhaps it is finally the time to retire. How many more of these cockups are in your future? How many more battles? How many more dead men will you have to bury? The company would do well standing on the foundations you\'ve built for it. But on the other hand, if you retired now, what adventures would you miss out on?\n\n%OOC%Something burns down inside of you. Something that struggles to be free. Perhaps it is the success you have have had along the way, or the failings that you couldn\'t stop in time. Maybe there is more out there to see?.%OOC_OFF%",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "The %companyname% needs their commander!",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "It\'s time to retire from mercenary life. (End Campaign)",
					function getResult( _event )
					{
						this.World.State.getMenuStack().pop(true);
						this.World.State.showGameFinishScreen(true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.hasNews("crisis_greenskins_end"))
		{
			local currentTile = this.World.State.getPlayer().getTile();

			if (!currentTile.HasRoad)
			{
				return;
			}

			if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.15)
			{
				return;
			}

			local brothers = this.World.getPlayerRoster().getAll();
			local most_days_with_company = -9000.0;
			local most_days_with_company_bro;

			foreach( bro in brothers )
			{
				if (bro.getDaysWithCompany() > most_days_with_company)
				{
					most_days_with_company = bro.getDaysWithCompany();
					most_days_with_company_bro = bro;
				}
			}

			this.m.Dude = most_days_with_company_bro;
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_greenskins_end");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dude",
			this.m.Dude.getNameOnly()
		]);
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		_vars.push([
			"randomnoblehouse",
			nobles[this.Math.rand(0, nobles.len() - 1)].getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

