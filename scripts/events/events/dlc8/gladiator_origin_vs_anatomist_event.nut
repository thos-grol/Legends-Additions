this.gladiator_origin_vs_anatomist_event <- this.inherit("scripts/events/event", {
	m = {
		Gladiator = null
	},
	function create()
	{
		this.m.ID = "event.gladiator_origin_vs_anatomist";
		this.m.Title = "During camp...";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{You see the anatomist and %gladiator% sitting together near the campfire. They seem ill-suited for conversation, and in little time does the latter rise to his feet with great fury.%SPEECH_ON%Enhancements? You think I take enhancements? You foolish, stick-shaped, daisy-pulling, corpse-chasing fool! My muscles are made out of sweat and blood! No pain, no gain!%SPEECH_OFF%They kick a pile of ash onto the anatomist and storm off. The anatomist cleans himself off, then takes out a ream of notes. He remarks that the \'subject\' is experiencing flashes of hot anger. You ask the man if he\'s secretly doing something to them. The anatomist snaps his notebook closed.%SPEECH_ON%Captain! I would never!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A strangely terse retort...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
				_event.m.Gladiator.getFlags().set("IsJuiced", true);
				_event.m.Gladiator.getBaseProperties().Hitpoints += 5;
				_event.m.Gladiator.getBaseProperties().Bravery += 5;
				_event.m.Gladiator.getBaseProperties().Stamina += 5;
				_event.m.Gladiator.getBaseProperties().Initiative += 5;
				_event.m.Gladiator.getBaseProperties().MeleeSkill += 3;
				_event.m.Gladiator.getBaseProperties().RangedSkill += 3;
				_event.m.Gladiator.getBaseProperties().MeleeDefense += 3;
				_event.m.Gladiator.getBaseProperties().RangedDefense += 3;
				_event.m.Gladiator.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+5[/color] Hitpoints"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+5[/color] Resolve"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+5[/color] Fatigue"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+5[/color] Initiative"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+3[/color] Melee Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+3[/color] Ranged Skill"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+3[/color] Melee Defense"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.Gladiator.getName() + " gains [color=" + ::Const.UI.Color.PositiveEventValue + "]+3[/color] Ranged Defense"
				});
				_event.m.Gladiator.worsenMood(0.5, "Was accused of taking artificial enhancements");

				if (_event.m.Gladiator.getMoodState() < ::Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = ::Const.MoodStateIcon[_event.m.Gladiator.getMoodState()],
						text = _event.m.Gladiator.getName() + ::Const.MoodStateEvent[_event.m.Gladiator.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!::Const.DLC.Paladins) return;
		if (!this.World.Retinue.hasFollower("follower.surgeon")) return;

		local brothers = this.World.getPlayerRoster().getAll();
		local gladiator_candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getFlags().has("IsJuiced")) gladiator_candidates.push(bro);
		}

		if (gladiator_candidates.len() == 0) return;
		this.m.Gladiator = gladiator_candidates[::Math.rand(0, gladiator_candidates.len() - 1)];
		this.m.Score = 3 * gladiator_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gladiator",
			this.m.Gladiator.getName()
		]);
	}

	function onClear()
	{
		this.m.Gladiator = null;
	}

});

