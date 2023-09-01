this.ball_on_roof_event <- this.inherit("scripts/events/event", {
	m = {
		Surefooted = null,
		Other = null,
		OtherOther = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.ball_on_roof";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 140.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]The company comes across a small boy who has climbed up a tree and out to the edge of a branch. He\'s reaching for a ball that\'s gotten stuck on the roof of his home. There\'s not a parent in sight to help him. When he sees you, he asks if you can help get the ball. Seems simple enough.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "I guess we can help him.",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 70)
						{
							return "Good";
						}
						else
						{
							return "Bad";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Surefooted != null)
				{
					this.Options.push({
						Text = "%surefooted%, you\'re sure-footed. Give him a hand.",
						function getResult( _event )
						{
							return "Surefooted";
						}

					});
				}

				this.Options.push({
					Text = "We have no time for this.",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Good",
			Text = "[img]gfx/ui/events/event_97.png[/img]You send %otherbrother% to try and retrieve the ball. Using %otherother% as a stepstool, he launches himself onto the roof and gets the toy. The boy is ecstatic and the smile on his face warms even the most cynical of your mercenaries. \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What a good sword sellin\' samaritan. ",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				_event.m.Other.improveMood(1.0, "Helped a little boy");

				if (_event.m.Other.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Bad",
			Text = "[img]gfx/ui/events/event_97.png[/img]You send %otherbrother% to try and retrieve the ball. He climbs the tree and jumps across a branch to land atop the roof. Mission complete, he tosses the ball to the kid. Unfortunately, the boy lets go of the tree branch to try and catch it. He slips off the branch and falls a good fifteen feet to the earth. The wallop of his landing has the whole company cringing. When you check on him he isn\'t moving and his back has taken a new shape. %otherother% yells at the idiot still standing in shock on the roof.%SPEECH_ON%What the hell were you thinking? Holy shit, man!%SPEECH_OFF%The mercenary climbs down off the roof. He looks at the kid and then nervously looks around.%SPEECH_ON%Well he, uh, he\'s got the ball. Let\'s get the hell out of here. Our... our work here is done.%SPEECH_OFF%What a goatfuck of a situation. You and the company quickly leave the scene before the parents get back. \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation decreases slightly",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nobody saw nothing.",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				this.Characters.push(_event.m.OtherOther.getImagePath());
				_event.m.Other.worsenMood(1.5, "Accidentally crippled a little boy");

				if (_event.m.Other.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Surefooted",
			Text = "[img]gfx/ui/events/event_97.png[/img]%surefooted% clears his throat and steps forward.%SPEECH_ON%I\'ll be your hero, kid.%SPEECH_OFF%He opens his arms and the kid jumps down into them. The boy is set aside and the sellsword points a finger to the earth.%SPEECH_ON%Stay down here.%SPEECH_OFF%The surefooted mercenary easily clambers up the tree and jumps over to the roof. He picks the ball up and spins it on a finger before he pirouettes off the eave like a tornado, landing right on his toes with rather feminine grace. The boy claps excitedly and takes the toy and even the most cynical of men in the company are warmed by his happiness. \n\n [img]gfx/ui/icons/asset_moral_reputation.png[/img] The company\'s Moral reputation increases slightly",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Show off.",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Surefooted.getImagePath());
				_event.m.Surefooted.improveMood(1.5, "Impressed everyone with his talents");

				if (_event.m.Surefooted.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Surefooted.getMoodState()],
						text = _event.m.Surefooted.getName() + this.Const.MoodStateEvent[_event.m.Surefooted.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_surefooted = [];
		local candidates_other = [];

		foreach( b in brothers )
		{
			if (b.getSkills().hasSkill("trait.sure_footing"))
			{
				candidates_surefooted.push(b);
			}
			else if (b.getSkills().hasSkill("trait.player"))
			{
				candidates_other.push(b);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_surefooted.len() != 0)
		{
			this.m.Surefooted = candidates_surefooted[this.Math.rand(0, candidates_surefooted.len() - 1)];
		}

		do
		{
			this.m.OtherOther = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
		while (this.m.OtherOther == null || this.m.OtherOther.getID() == this.m.Other.getID());

		this.m.Town = town;
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
		_vars.push([
			"otherother",
			this.m.OtherOther.getName()
		]);
		_vars.push([
			"surefooted",
			this.m.Surefooted != null ? this.m.Surefooted.getName() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Other = null;
		this.m.OtherOther = null;
		this.m.Surefooted = null;
		this.m.Town = null;
	}

});

