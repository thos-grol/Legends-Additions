this.kings_guard_1_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.kings_guard_1";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 9999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{The snowy wastes are home to not much of anything, so to find someone half-naked in its frigid geography is rather unusual. That the frozen figure is actually alive even more so. You crouch beside the frigid body, their eyes are hollow and rime frosts make blinking them a struggle, lips are jagged and purple and nose a deep red bordering on black. You ask if the pitiful wretch can speak, and are greeted with nods.%SPEECH_ON%Barbarians. Took. Me.%SPEECH_OFF%You ask where the kidnappers are, the figure shrugs and continues the cold cadence.%SPEECH_ON%They. Got. Bored. And. Left.%SPEECH_OFF%It does seem in tune with the primitives to up and leave a prisoner in the ice. The shivering prisoner explains they were once a sturdy swordfighter. A smile squeezes through the pain.%SPEECH_ON%A. King\'s. Guard. In. The. Kingless. Land. Things. Could. Be. Worse?%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We have a place for you, friend.",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "You\'re on your own in this world.",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");

				if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
				{
					_event.m.Dude.getFlags().add("PlayerSkeleton");
					_event.m.Dude.getFlags().add("undead");
					_event.m.Dude.getFlags().add("skeleton");
					_event.m.Dude.setStartValuesEx([
						"cripple_background"
					], false);
					_event.m.Dude.getSkills().add(this.new("scripts/skills/racial/skeleton_racial"));
					_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/legend_fleshless_trait"));
				}
				else
				{
					_event.m.Dude.setStartValuesEx([
						"cripple_background"
					], false);
				}

				_event.m.Dude.setTitle("");
				_event.m.Dude.getBackground().m.RawDescription = "You found %name% frozen half to death in the north, claiming to have been a King\'s Guard once, but looking at the wretch now you see but a cripple.";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getFlags().set("IsSpecial", true);
				_event.m.Dude.getBaseProperties().Bravery += 15;
				_event.m.Dude.getSkills().update();
				_event.m.Dude.m.PerkPoints = 2;
				_event.m.Dude.m.LevelUps = 2;
				_event.m.Dude.m.Level = 3;
				_event.m.Dude.m.XP = this.Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);
				talents[this.Const.Attributes.MeleeSkill] = 2;
				talents[this.Const.Attributes.MeleeDefense] = 3;
				talents[this.Const.Attributes.RangedDefense] = 3;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.worsenMood(1.5, "Got taken by barbarians and left to die in the cold");
				_event.m.Dude.getFlags().set("IsKingsGuard", true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%{You pat the wretch on the head, but say it\'s already over. The downtrodden prisoner nods.%SPEECH_ON%Speak. For. Yourself. Mercenary.%SPEECH_OFF% The purple lips smile again, but this time it does release. It sticks. Literally. The crippled figure leans forward with eyes open that do not blink and in this state the mind is gone. You get the company back on the road, or what one can make of a road in these snowed stretches.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It\'s already over for you.",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
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
			Text = "%terrainImage%{The nearly frozen figure joins the company. The prisoner\'s a ragged wreck, but if what was said is true maybe the frozen body will someday become the fighter it once was.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We\'ll see.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type != this.Const.World.TerrainType.Snow)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

