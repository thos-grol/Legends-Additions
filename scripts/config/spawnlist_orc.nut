local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.OrcRoamers <- {
	Name = "OrcRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	MaxR = 260,
	MinR = 64,
	Body = "figure_orc_02",
	Troops = [
		{
			Weight = 80,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoungLOW,
					MaxR = 1.0 * 360,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					MinR = 200,
					Cost = 24
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcBerserker,
					MinR = 200,
					Cost = 25
				}
			]
		},
		{
			Weight = 5,
			MinR = 0.5 * 260,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendOrcBehemoth,
					MinR = 400,
					Cost = 60,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.OrcScouts <- {
	Name = "OrcScouts",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 300,
	MinR = 52,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoungLOW,
					MaxR = 1.0 * 176,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					MinR = 200,
					Cost = 24
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcWarriorLOW,
					MaxR = 1.0 * 176,
					Cost = 30
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcWarrior,
					MinR = 300,
					Cost = 40
				}
			]
		}
	]
};
gt.Const.World.Spawn.OrcRaiders <- {
	Name = "OrcRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 822,
	MinR = 72,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoungLOW,
					MaxR = 0.75 * 822,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					MinR = 200,
					Cost = 24
				}
			]
		},
		{
			Weight = 30,
			MinR = 0.2 * 822,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcWarriorLOW,
					MaxR = 0.8 * 822,
					Cost = 30
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcWarrior,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcBerserker,
					MinR = 200,
					Cost = 40
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcWarlord,
					MinR = 400,
					Cost = 60
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendOrcBehemoth,
					MinR = 0.5 * 1115,
					Cost = 60,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.OrcDefenders <- {
	Name = "OrcDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 720,
	MinR = 52,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoungLOW,
					MaxR = 0.75 * 822,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					MinR = 200,
					Cost = 24
				}
			]
		},
		{
			Weight = 30,
			MinR = 0.2 * 822,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcWarriorLOW,
					MaxR = 0.8 * 822,
					Cost = 30
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcWarrior,
					MinR = 300,
					MinR = 0.25 * 1115,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcBerserker,
					MinR = 200,
					Cost = 25
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcWarlord,
					MinR = 400,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendOrcBehemoth,
					MinR = 0.5 * 1115,
					Cost = 80,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.OrcBoss <- {
	Name = "OrcBoss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 798,
	MinR = 164,
	Fixed = [
		{
			Weight = 100,
			Type = ::Const.World.Spawn.Troops.OrcWarlord,
			Cost = 50
		}
	],
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					Cost = 24
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcWarrior,
					MinR = 200,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcBerserker,
					Cost = 25
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcWarlord,
					MinR = 400,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendOrcBehemoth,
					MinR = 400,
					Cost = 80,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.YoungOrcsOnly <- {
	Name = "YoungOrcsOnly",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 350,
	MinR = 50,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoungLOW,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					MinR = 200,
					Cost = 24
				}
			]
		}
	]
};
gt.Const.World.Spawn.YoungOrcsAndBerserkers <- {
	Name = "YoungOrcsAndBerserkers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 388,
	MinR = 50,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoungLOW,
					MaxR = 1.0 * 288,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					MinR = 200,
					Cost = 24
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcBerserker,
					MinR = 200,
					Cost = 25
				}
			]
		},
		{
			Weight = 20,
			MinR = 1.0 * 288,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendOrcBehemoth,
					MinR = 300,
					Cost = 80,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.BerserkersOnly <- {
	Name = "BerserkersOnly",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_01",
	MaxR = 448,
	MinR = 50,
	Troops = [
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcYoungLOW,
					MaxR = 1.0 * 288,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.OrcYoung,
					MinR = 200,
					Cost = 24
				}
			]
		},
		{
			Weight = 70,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.OrcBerserker,
					Cost = 25
				}
			]
		},
		{
			Weight = 10,
			MinR = 1.0 * 288,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendOrcBehemoth,
					MinR = 300,
					Cost = 80,
					Roll = true
				}
			]
		}
	]
};

