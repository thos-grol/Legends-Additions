::Const.World.Spawn.BanditRaiders <- {
	Name = "BanditRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	MinR = 63,
	MaxR = 600,
	Troops = [
		{
			Weight = 54,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRabble,
					MaxR = 130,
					Cost = 7
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditThug,
					MinR = 110,
					Cost = 8
				},
				{
					MinR = 160,
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 320,
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.BanditRaiderWolf,
					Cost = 30
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 90,
					Cost = 10
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 11
				},
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 18
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			MinR = 250,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 600,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.HedgeKnight,
					Cost = 60,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 600,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Swordmaster,
					Cost = 60,
					Roll = true
				}
			]
		},
		{
			Weight = 14,
			MinR = 200,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendPeasantBlacksmith,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendPeasantPoacher,
					Cost = 20
				}
			]
		}
	]
};