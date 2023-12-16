this.dead_lumberjack_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.dead_lumberjack";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 120.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]The forest is home to many curiosities and dead bodies, really, aren\'t even the most curious of those. So when you stumble upon a litter of dead lumberjacks the only thing that piques your interest is the lump of a huge wolf slain beside them. %randombrother% eyes the tracks going back and forth across a cutting field so abruptly interrupted that some axes were left hewn into tree trunks. He spits and nods.%SPEECH_ON%Poor fellas. Looks like some wolf bushwhacked them something fierce.%SPEECH_OFF%You have the men collect what\'s left to be recovered and make your leave.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Rest in peace.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item;

				if (this.Math.rand(1, 100) <= 50)
				{
					item = this.new("scripts/items/weapons/hand_axe");
				}
				else
				{
					item = this.new("scripts/items/weapons/woodcutters_axe");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + ::Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/misc/werewolf_pelt_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + ::Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != ::Const.World.TerrainType.Forest && currentTile.Type != ::Const.World.TerrainType.LeaveForest && currentTile.Type != ::Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= 7)
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
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
	}

});

