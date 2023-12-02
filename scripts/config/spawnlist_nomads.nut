local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.NomadRoamers <- {
	Name = "NomadRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_03",
	Fixed = [],
	MinR = 56,
	MaxR = 188,
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					MinR = 200,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				}
			]
		}
	]
};
gt.Const.World.Spawn.NomadRaiders <- {
	Name = "NomadRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_01",
	Fixed = [],
	MinR = 63,
	MaxR = 600,
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					MinR = 100,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker,
					MinR = 420,
					Cost = 65,
					Roll = true
				}
			]
		},
		{
			Weight = 6,
			MinR = 250,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 60,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 65,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 420,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 65,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.NomadDefenders <- {
	Name = "NomadDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_01",
	Fixed = [],
	MinR = 63,
	MaxR = 600,
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					Cost = 18
				}
			]
		},
		{
			Weight = 21,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker,
					MinR = 420,
					Cost = 45,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			MinR = 250,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			MinR = 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 55,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			MinR = 420,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 50,
					Roll = true
				}
			]
		}
	]
};

