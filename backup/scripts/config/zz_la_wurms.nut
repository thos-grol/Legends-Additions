local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

::Const.World.Spawn.Troops.Lindwurm.Strength = 1000;
::Const.World.Spawn.Troops.LegendStollwurm.Strength = 1500;

gt.Const.World.Spawn.LegendStollwurm = {
	Name = "LegendStollwurm",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.1,
	Body = "figure_stollwurm_01",
	MaxR = 500,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendStollwurm,
					Cost = 270
				}
			]
		}
	]
};