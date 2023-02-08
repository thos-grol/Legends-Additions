::Const.World.Spawn.BanditDefenders <- {
	Name = "BanditDefenders",
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
			Weight = 59,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					MinR = 130,
					Cost = 16
				},
				{
					MinR = 320,
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 18,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 110,
					Cost = 14
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					MinR = 400,
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
			Weight = 4,
			MinR = 500,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditWarlord,
					Cost = 100,
					Roll = true
				}
			]
		},
		{
			Weight = 12,
			MinR = 150,
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
		},
		{
			Weight = 1,
			MinR = 600,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.HedgeKnight,
					Cost = 80,
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
					Cost = 40,
					Roll = true
				}
			]
		}
	]
};