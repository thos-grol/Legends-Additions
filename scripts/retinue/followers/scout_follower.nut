this.scout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scout";
		this.m.Name = "Pathfinder";
		this.m.Description = "The Scout is an expert in finding mountain passes, navigating through treacherous swamps, and guiding anyone safely through the darkest of forests... and keeping a lookout";
		this.m.Image = "ui/campfire/lookout_01";
		this.m.Cost = 150;
		this.m.Effects = [
			"Increases your sight radius by 50%",
			"Reveals extended information about footprints",
			"Reduces the movement penalty of difficult terrain by 15%",
			"Prevents sickness and accidents due to terrain",
		];
	}

	function onUpdate()
	{
		if ("VisionRadiusMult" in this.World.Assets.m)
		{
			this.World.Assets.m.VisionRadiusMult = 1.5;
		}

		if ("IsShowingExtendedFootprints" in this.World.Assets.m)
		{
			this.World.Assets.m.IsShowingExtendedFootprints = true;
		}

		for( local i = 0; i < this.World.Assets.m.TerrainTypeSpeedMult.len(); i = i )
		{
			if (::Const.World.TerrainTypeSpeedMult[i] <= 0.65 && ::Const.World.TerrainTypeSpeedMult[i] > 0.0)
			{
				this.World.Assets.m.TerrainTypeSpeedMult[i] *= (::Const.World.TerrainTypeSpeedMult[i] + 0.15) / ::Const.World.TerrainTypeSpeedMult[i];
			}

			i = ++i;
		}
	}

});

