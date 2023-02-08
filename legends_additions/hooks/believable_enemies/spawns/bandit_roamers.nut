::Const.World.Spawn.BanditRoamers <- {
	Name = "BanditRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	MinR = 56,
	MaxR = 220,
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
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					MinR = 125,
					Cost = 13
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
					Cost = 18
				},
				{
					MinR = 480,
					Type = ::Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 130,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					MinR = 400,
					Cost = 18
				}
			]
		},
		{
			Weight = 15,
			MinR = 0.5 * 385,
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