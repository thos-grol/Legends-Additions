::Const.World.Spawn.BanditBoss <- {
	Name = "BanditBoss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.BanditLeader,
			Weight = 1,
			Cost = 25,
			Roll = true
		},
		{
			MinR = 600,
			Weight = 1,
			Type = ::Const.World.Spawn.Troops.BanditWarlord,
			Cost = 50,
			Roll = true
		}
	],
	MinR = 145,
	MaxR = 600,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
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
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
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
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.BanditWarlord,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			Types = [
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			Types = [
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
				}
			]
		}
	]
};
::Const.World.Spawn.BanditArmy <- {
	Name = "BanditArmy",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	MaxR = 1,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.BanditWarlord,
			Weight = 100,
			Cost = 1,
			Roll = true
		}
	],
	MaxR = 12,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.BanditLeader,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = ::Const.World.Spawn.Troops.BanditLeader,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = ::Const.World.Spawn.Troops.BanditVeteran,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = ::Const.World.Spawn.Troops.BanditMarksman,
			Weight = 45,
			Cost = 2
		}
	],
	MinR = 145,
	MaxR = 600,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
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
			Weight = 20,
			Types = [
				{
					MinR = 400,
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
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
			Weight = 3,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.HedgeKnight,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			Types = [
				{
					MinR = 600,
					Type = ::Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
				}
			]
		}
	]
};
::Const.World.Spawn.BanditsDisguisedAsDirewolves <- {
	Name = "BanditsDisguisedAsDireWolves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	MinR = 75,
	MaxR = 475,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditRaiderWolf,
					Cost = 25
				}
			]
		}
	]
};
::Const.World.Spawn.BanditVermes <- {
	Name = "BanditsVermes",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	MaxR = 475,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditVermes,
					Cost = 7
				}
			]
		}
	]
};