this.giant_tree_in_forest_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null
	},
	function create()
	{
		this.m.ID = "event.giant_tree_in_forest";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]You pass through a wall of shrubs and find yourself stopped by quite a sight. To call it a tree would seem insulting. The trees about it are so low beneath their neighbor they appear to be bending at midtrunk, swearing fealty to that which is arboreally suzerain, a domain rippled with roots as thick as any man, and enough shade above to lose time between the days and night.\n\n You walk to the base of the enormity and run a hand along its bark, but then you stop, fearing that your flesh may have just trespassed upon holy ground like a child tumbling playfully into a church of one wholly quiet crowd. %monk% the monk comes to your side nodding and with hands firmly behind back.%SPEECH_ON%This is a godtree. The roots go through the earth and into the realm of the gods. It is said they once listened, but now... we are not so sure.%SPEECH_OFF%You stare at the holy one, and this particularly withheld posture, and ask if the religious fear the tree. He smiles at you with a shaking head.%SPEECH_ON%I respect it like one would the sea, for the waters of the oceans hold many things to fear and, yet, the sailor sails anyway. Were the ocean a docile beast, would we refer to it so lovingly?%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fascinating.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Monk.improveMood(2.0, "Saw a godtree with their own eyes");

				if (_event.m.Monk.getMoodState() >= ::Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = ::Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + ::Const.MoodStateEvent[_event.m.Monk.getMoodState()]
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

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != ::Const.World.TerrainType.Forest && currentTile.Type != ::Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 6)
			{
				return false;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local monk_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.monk_turned_flagellant" || bro.getBackground().getID() == "background.legend_nun" || bro.getBackground().getID() == "background.legend_herbalist" || bro.getBackground().getID() == "background.legend_nun" || bro.getBackground().getID() == "background.legend_ranger" || bro.getBackground().getID() == "background.legend_ranger_commander" || bro.getBackground().getID() == "background.legend_vala" || bro.getBackground().getID() == "background.legend_vala_commander")
			{
				monk_candidates.push(bro);
			}
		}

		if (monk_candidates.len() == 0)
		{
			return;
		}

		this.m.Monk = monk_candidates[this.Math.rand(0, monk_candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Monk = null;
	}

});

