this.archery_stunt_event <- this.inherit("scripts/events/event", {
	m = {
		Clown = null,
		Archer = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.archery_stunt";
		this.m.Title = "During camp...";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]Something of a commotion draws you from your tent. The company are sitting on a few stumps or on the ground, eagerly watching something in the distance. With squinting eyes, you spot %clown% and %archer% doing something odd. An apple rests on one mercenary\'s head, while the other is walking away - a bow in hand.\n\nYou ask %otherguy% what is going on, who explains that the two are going to try some sort of stunt or trick that involves shooting a piece of fruit off a person\'s head. Shocked, you exclaim that\'s not safe at all, to which the mercenary grins and explains that is the point.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Stop at once!",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "Well... this should be interesting.",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= _event.m.Archer.getCurrentProperties().RangedSkill)
						{
							return "C";
						}
						else
						{
							return "B1";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_10.png[/img]You mull the situation over. The company look to you, expecting a stoppage, but instead you take a seat amongst them. This spurs a brief cheer from the crowd which quickly quiets to hushed whispers as %clown% and %archer% get ready.%SPEECH_ON%Make sure to hit the apple!%SPEECH_OFF%One comrade shouts. Laughter ripples through the group.%SPEECH_ON%From that distance %clown_short%\'s nose kinda looks like an apple to me.%SPEECH_OFF%More laughter, but it is ever nervous as the stunt is about to unfold.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ohh!",
					function getResult( _event )
					{
						return "B2";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_10.png[/img]%archer% angles shoulders to %clown% and draws the bow, the silhouette forming a crescent of wood, string, and arm. You can\'t see %clown%\'s face, but you assume eyes are closed. The shot is released. It zips. It disappears. %clown% rocks backward, clutching at their face. This isn\'t looking good. The mercenary screams. The crowd oohs. %archer% slowly lowers the bow and looks at it as though it is at fault.\n\n Eventually, %clown% is carried past you, a shaft of an arrow sticking out of their head. Another comrade lingers behind, quietly eating an apple in the wake of the chaos.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s going to leave a mark...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
				local injury = _event.m.Clown.addInjury(this.Const.Injury.Archery);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Clown.getName() + " suffers " + injury.getNameOnly()
				});
				_event.m.Archer.worsenMood(2.0, "Severely injured " + _event.m.Clown.getName() + " by accident");

				if (_event.m.Archer.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer.getMoodState()],
						text = _event.m.Archer.getName() + this.Const.MoodStateEvent[_event.m.Archer.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Clown.getID() || bro.getID() == _event.m.Archer.getID())
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.fainthearted"))
					{
						bro.worsenMood(1.0, "Felt for " + _event.m.Clown.getName());

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_10.png[/img]The company cheer as you give an affirming nod. You take a seat amongst them as %archer% and %clown% get ready, the former nocking an arrow while the latter balances an apple atop their head. When the fruit is good and steady, the archer draws back the bow, forming but a silhouette of arm, wood, and string, a crescent of determination while aiming downfield. The company are exchanging bets on whether or not the archer misses. You want to look away, but the spectacle truly is too much.\n\n A great gasp follows the arrow\'s release, as though some ominous event long foretold had finally happened. Mercenaries reel back in their seats, wincing and gritting their teeth. The apple is shot off %clown%\'s head, fruit and arrow spinning away. After a brief silence, the company erupts in cheers. %clown% takes a bow, while %archer% slackens draw and looks a bit relieved.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nailed it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
				_event.m.Clown.getBaseProperties().Bravery += 1;
				_event.m.Clown.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Clown.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Resolve"
				});
				_event.m.Archer.getBaseProperties().RangedSkill += 1;
				_event.m.Archer.getSkills().update();
				this.List.push({
					id = 17,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.Archer.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Ranged Skill"
				});
				_event.m.Clown.improveMood(1.0, "Took part in a show");

				if (_event.m.Clown.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Clown.getMoodState()],
						text = _event.m.Clown.getName() + this.Const.MoodStateEvent[_event.m.Clown.getMoodState()]
					});
				}

				_event.m.Archer.improveMood(1, "Displayed his archery skills");

				if (_event.m.Archer.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer.getMoodState()],
						text = _event.m.Archer.getName() + this.Const.MoodStateEvent[_event.m.Archer.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Clown.getID() || bro.getID() == _event.m.Archer.getID())
					{
						continue;
					}

					if (bro.getMoodState() >= this.Const.MoodState.Neutral && this.Math.rand(1, 100) <= 10 && !bro.getSkills().hasSkill("trait.bright"))
					{
						bro.improveMood(1.0, "Felt entertained");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "You shake your head \'no\' as you walk out into the field and step between the two men.%SPEECH_ON%If y\'all wanted to play tricks, you should\'ve joined a circus. Now get back to work before someone gets seriously hurt.%SPEECH_OFF%A wave of disappointment washes over the men. A few even boo and give you a thumbs down or other, rowdier, gestures.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It\'s for their own good.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Clown.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
				_event.m.Clown.worsenMood(1.0, "Was denied a request");

				if (_event.m.Clown.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Clown.getMoodState()],
						text = _event.m.Clown.getName() + this.Const.MoodStateEvent[_event.m.Clown.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Clown.getID())
					{
						continue;
					}

					if (bro.getMoodState() >= this.Const.MoodState.Neutral && this.Math.rand(1, 100) <= 10 && !bro.getSkills().hasSkill("trait.bright") && !bro.getSkills().hasSkill("trait.fainthearted"))
					{
						bro.worsenMood(1.0, "Didn\'t get the entertainment he had hoped for");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
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

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local clown_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.hesitant") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.insecure"))
			{
				continue;
			}

			if ((bro.getBackground().getID() == "background.minstrel" || bro.getBackground().getID() == "background.female_minstrel" || bro.getBackground().getID() == "background.juggler" || bro.getBackground().getID() == "background.vagabond") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				clown_candidates.push(bro);
			}
		}

		if (clown_candidates.len() == 0)
		{
			return;
		}

		local archer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.bright") || bro.getSkills().hasSkill("trait.hesitant") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.insecure"))
			{
				continue;
			}

			if ((bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.bowyer" || bro.getBackground().getID() == "background.female_bowyer" || bro.getBackground().getID() == "background.female_adventurous_noble") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				archer_candidates.push(bro);
			}
		}

		if (archer_candidates.len() == 0)
		{
			return;
		}

		this.m.Clown = clown_candidates[this.Math.rand(0, clown_candidates.len() - 1)];
		this.m.Archer = archer_candidates[this.Math.rand(0, archer_candidates.len() - 1)];
		this.m.Score = clown_candidates.len() * 3;

		do
		{
			this.m.OtherGuy = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
		while (this.m.OtherGuy == null || this.m.OtherGuy.getID() == this.m.Clown.getID() || this.m.OtherGuy.getID() == this.m.Archer.getID());
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"clown",
			this.m.Clown.getName()
		]);
		_vars.push([
			"clown_short",
			this.m.Clown.getNameOnly()
		]);
		_vars.push([
			"archer",
			this.m.Archer.getName()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.Clown = null;
		this.m.Archer = null;
		this.m.OtherGuy = null;
	}

});

