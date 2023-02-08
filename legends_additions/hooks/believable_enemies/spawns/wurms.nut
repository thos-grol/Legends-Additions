::Const.World.Spawn.Troops.Lindwurm.Strength = 500;
::Const.World.Spawn.Troops.Lindwurm.Cost = 90;

::Const.World.Spawn.Troops.LegendStollwurm.Strength = 750;
::Const.World.Spawn.Troops.LegendStollwurm.Cost = 270;

::Const.World.Spawn.Lindwurm = {
	Name = "Lindwurm",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_lindwurm_01",
	MaxR = 500,
    Fixed = [
		{
			MaxCount = 1,
            Type = ::Const.World.Spawn.Troops.Lindwurm,
			Cost = 90,
			Weight = 0
		}
        //FEATURE_6: Add dragon minions?
	]
};

::Const.World.Spawn.LegendStollwurm = {
	Name = "LegendStollwurm",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.1,
	Body = "figure_stollwurm_01",
	MaxR = 500,
	Fixed = [
		{
			MaxCount = 1,
            Type = ::Const.World.Spawn.Troops.LegendStollwurm,
			Cost = 270,
			Weight = 0
		}
	]
    //FEATURE_6: Add dragon minions?
};