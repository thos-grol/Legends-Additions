local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.GoblinRoamers <- {
	Name = "GoblinRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_goblin_01",
	MaxR = 480,
	MinR = 50,
	Troops = [
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisherLOW,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisher,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusherLOW,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusher,
					MinR = 400,
					Cost = 25
				}
			]
		},
		{
			Weight = 49,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinWolfrider,
					MinR = 800,
					Cost = 40
				}
			]
		}
	]
};
gt.Const.World.Spawn.GoblinScouts <- {
	Name = "GoblinScouts",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_goblin_02",
	MinR = 75,
	MaxR = 400,
	Troops = [
		{
			Weight = 30,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisherLOW,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisher,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 40,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusherLOW,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusher,
					MinR = 400,
					Cost = 25
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinWolfrider,
					MinR = 800,
					Cost = 40
				}
			]
		}
	]
};
gt.Const.World.Spawn.GoblinRaiders <- {
	Name = "GoblinRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_goblin_05",
	MinR = 55,
	MaxR = 695,
	Troops = [
		{
			Weight = 45,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisherLOW,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisher,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 25,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusherLOW,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusher,
					MinR = 400,
					Cost = 25
				}
			]
		},
		{
			Weight = 25,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinWolfrider,
					MinR = 800,
					Cost = 40
				}
			]
		},
		{
			Weight = 3,
			MinR = 1000,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinOverseer,
					Cost = 35
				}
			]
		},
		{
			Weight = 3,
			MinR = 1200,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinShaman,
					Cost = 35
				}
			]
		}
	]
};
gt.Const.World.Spawn.GoblinDefenders <- {
	Name = "GoblinDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_goblin_04",
	MinR = 40,
	MaxR = 585,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisherLOW,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisher,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusherLOW,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusher,
					MinR = 400,
					Cost = 25
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinWolfrider,
					MinR = 800,
					Cost = 40
				}
			]
		},
		{
			Weight = 3,
			MinR = 1000,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinOverseer,
					Cost = 35
				}
			]
		},
		{
			Weight = 3,
			MinR = 1200,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinShaman,
					Cost = 35
				}
			]
		}
	]
};
gt.Const.World.Spawn.GoblinBoss <- {
	Name = "GoblinBoss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_goblin_04",
	MinR = 215,
	MaxR = 585,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.GoblinOverseer,
			Weight = 0,
			Cost = 35
		}
	],
	Troops = [
		{
			Weight = 55,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisher,
					Cost = 15
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinAmbusher,
					Cost = 20
				}
			]
		},
		{
			Weight = 8,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinWolfrider,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinOverseer,
					Cost = 35
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GoblinShaman,
					MinR = 600,
					Cost = 35
				}
			]
		}
	]
};

