local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.Cultists <- {
	Name = "Cultists",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_civilian_03",
	MaxR = 105,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CultistAmbush,
					Cost = 15
				}
			]
		}
	]
};

gt.Const.World.Spawn.Peasants <- {
	Name = "Peasants",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_civilian_03",
	MaxR = 160,
	MinR = 30,
	Troops = [
		{
			Weight = 85,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Peasant,
					Cost = 5
				}
			]
		}
	]
};
gt.Const.World.Spawn.PeasantsArmed <- {
	Name = "PeasantsArmed",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_civilian_03",
	MaxR = 160,
	Troops = [
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.PeasantArmed,
					Cost = 10
				}
			]
		},
	]
};
gt.Const.World.Spawn.BountyHunters <- {
	Name = "BountyHunters",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 525,
	MinR = 103,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BountyHunter,
					Cost = 25
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BountyHunterRanged,
					Cost = 20
				}
			]
		}
	]
};
gt.Const.World.Spawn.Mercenaries <- {
	Name = "Mercenaries",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 690,
	MinR = 97,
	Troops = [
		{
			Weight = 75,
			Types = [
				{
					MaxR = 250,
					Type = this.Const.World.Spawn.Troops.MercenaryLOW,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.Mercenary,
					Cost = 25
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				},
				{
					MinR = 250,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					MinR = 250,
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40
				},
				{
					MinR = 250,
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}
	]
};

gt.Const.World.Spawn.MercenariesLow <- {
	Name = "Second-Rate Mercenaries",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 690,
	MinR = 97,
	Troops = [
		{
			Weight = 75,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MercenaryLOW,
					Cost = 25
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				}
			]
		}
	]
};

gt.Const.World.Spawn.Militia <- {
	Name = "Militia",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_militia_01",
	MaxR = 326,
	MinR = 60,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Militia,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaVeteran,
					Cost = 12
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaRanged,
					Cost = 10
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaCaptain,
					Cost = 20,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.PeasantsSouthern <- {
	Name = "PeasantsSouthern",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_civilian_06",
	MaxR = 160,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SouthernPeasant,
					Cost = 10
				}
			]
		}
	]
};


gt.Const.World.Spawn.CultistPatrol <- {
	Name = "Cultist Patrol",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_civilian_03",
	MaxR = 326,
	MinR = 60,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Cultist,
					Cost = 15
				}
			]
		}
	]
};

gt.Const.World.Spawn.CultistRaiders <- {
	Name = "Cultist Raiders",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_civilian_03",
	MaxR = 326,
	MinR = 60,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Cultist,
					Cost = 15
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CultistPriest,
					Cost = 30
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CultistKnight,
					Cost = 60
				}
			]
		}
	]
};

gt.Const.World.Spawn.CultistDefenders <- {
	Name = "CultistDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 1,
			Weight = 30,
			Type = this.Const.World.Spawn.Troops.CultistChosen,
			Cost = 0
		}
	],
	MinR = 45,
	MaxR = 600,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Cultist,
					Cost = 15
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CultistPriest,
					Cost = 30
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CultistKnight,
					Cost = 60
				}
			]
		}
	]
};


gt.Const.World.Spawn.CultistDefenderss <- {
	Name = "CultistDefenderss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	MinR = 45,
	MaxR = 600,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Cultist,
					Cost = 15
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CultistPriest,
					Cost = 30
				}
			]
		}
	]
};
