::Const.World.Spawn.BanditScouts <- {
	Name = "BanditScouts",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	MinR = 61,
	MaxR = 340,
	Fixed = [],
	Troops = [
		{
			Weight = 60,
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
					MinR = 250,
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 340,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 130,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					MinR = 340,
					Cost = 15
				},
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 10,
			MinR = 170,
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