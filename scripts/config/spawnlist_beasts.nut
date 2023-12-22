local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.Kraken <- {
	Name = "Kraken",
	IsDynamic = true,
	MovementSpeedMult = 0.0,
	VisibilityMult = 0.5,
	VisionMult = 1.0,
	Body = "figure_kraken_01",
	MaxR = 1,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.Kraken,
			Cost = 1,
			Weight = 100
		}
	],
	Troops = []
};
gt.Const.World.Spawn.Direwolves <- {
	Name = "Direwolves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	MaxR = 535,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Direwolf,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.DirewolfHIGH,
					Cost = 25
				}
			]
		}
	]
};
gt.Const.World.Spawn.Ghouls <- {
	Name = "Ghouls",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_ghoul_01",
	MaxR = 484,
	MinR = 30,
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = ::Const.World.Spawn.Troops.Ghoul,
					Cost = 15
				}
			]
		},
		{
			Weight = 10,
			MinR = 0.6 * 535,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GhoulHIGH,
					Cost = 50
				}
			]
		}
	]
};
gt.Const.World.Spawn.Lindwurm <- {
	Name = "Lindwurm",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_lindwurm_01",
	MaxR = 600,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Lindwurm,
					Cost = 80
				}
			]
		}
	]
};
gt.Const.World.Spawn.Unhold <- {
	Name = "Unhold",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_unhold_01",
	MaxR = 500,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Unhold,
					Cost = 50
				}
			]
		}
	]
};
gt.Const.World.Spawn.UnholdFrost <- {
	Name = "UnholdFrost",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_unhold_02",
	MaxR = 550,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.UnholdFrost,
					Cost = 60
				}
			]
		},
		{
			Weight = 5,
			MinR = 1.0 * 4000,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendRockUnhold,
					Cost = 200
				}
			]
		}
	]
};
gt.Const.World.Spawn.UnholdBog <- {
	Name = "UnholdBog",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_unhold_03",
	MaxR = 500,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.UnholdBog,
					Cost = 50
				}
			]
		}
	]
};

gt.Const.World.Spawn.Spiders <- {
	Name = "Spiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_spider_01",
	MaxR = 384,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Spider,
					Cost = 15
				}
			]
		}
	]
};
gt.Const.World.Spawn.Alps <- {
	Name = "Alps",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_alp_01",
	MaxR = 480,
	Troops = [
		{
			Weight = 85,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Alp,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Direwolf,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			MinR = 1.0 * 4000,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendDemonAlp,
					Cost = 200
				}
			]
		}
	]
};
gt.Const.World.Spawn.Schrats <- {
	Name = "Schrats",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_schrat_01",
	MaxR = 800,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Schrat,
					Cost = 70
				}
			]
		}
	]
};
gt.Const.World.Spawn.HexenAndMore <- {
	Name = "HexenAndMore",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_hexe_01",
	MinR = 100,
	MaxR = 500,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.Hexe,
			Cost = 50,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 66,
			Weight = 0,
			Guards = [
				{
					Type = ::Const.World.Spawn.Troops.DirewolfBodyguard,
					Cost = 20,
					function Weight( scale )
					{
						return 50;
					}

				},
				{
					Type = ::Const.World.Spawn.Troops.SpiderBodyguard,
					Cost = 20,
					function Weight( scale )
					{
						return 50;
					}

				}
			]
		}
	],
	Troops = [
		{
			Weight = 22,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Direwolf,
					Cost = 21
				},
				{
					Type = ::Const.World.Spawn.Troops.DirewolfHIGH,
					MinR = 0.3 * 500,
					Cost = 25
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendBear,
					Cost = 90
				}
			]
		},
		{
			Weight = 25,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Spider,
					Cost = 12
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = ::Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				},
				{
					Type = ::Const.World.Spawn.Troops.GhoulHIGH,
					MinR = 0.6 * 500,
					Cost = 35,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			MinR = 0.75 * 500,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Unhold,
					Cost = 50
				},
				{
					Type = ::Const.World.Spawn.Troops.UnholdBog,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			MinR = 0.75 * 500,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Schrat,
					Cost = 70
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Hexe,
					Cost = 50,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = ::Const.World.Spawn.Troops.DirewolfBodyguard,
							Cost = 20,
							function Weight( scale )
							{
								return 50;
							}

						},
						{
							Type = ::Const.World.Spawn.Troops.SpiderBodyguard,
							Cost = 20,
							function Weight( scale )
							{
								return 50;
							}

						}
					]
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendHexeLeader,
					MinR = 600,
					Cost = 400,
					MinGuards = 2,
					MaxGuards = 3,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = ::Const.World.Spawn.Troops.LegendWhiteDirewolfBodyguard,
							Cost = 400,
							function Weight( scale )
							{
								return 50;
							}

						},
						{
							Type = ::Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard,
							Cost = 250,
							function Weight( scale )
							{
								return 50;
							}

						}
					]
				}
			]
		}
	]
};
gt.Const.World.Spawn.HexenAndNoSpiders <- {
	Name = "HexenAndNoSpiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_hexe_01",
	MinR = 100,
	MaxR = 500,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.Hexe,
			Cost = 50,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 66,
			Weight = 0,
			Guards = [
				{
					Type = ::Const.World.Spawn.Troops.DirewolfBodyguard,
					Cost = 20,
					function Weight( scale )
					{
						return 50;
					}

				}
			]
		}
	],
	Troops = [
		{
			Weight = 35,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Direwolf,
					Cost = 21
				},
				{
					Type = ::Const.World.Spawn.Troops.DirewolfHIGH,
					MinR = 0.3 * 500,
					Cost = 25
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendBear,
					MinR = 0.3 * 100,
					Cost = 30
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = ::Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				},
				{
					Type = ::Const.World.Spawn.Troops.GhoulHIGH,
					MinR = 0.6 * 500,
					Cost = 35,
					Roll = true
				}
			]
		},
		{
			Weight = 10,
			MinR = 0.75 * 500,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Unhold,
					Cost = 50
				},
				{
					Type = ::Const.World.Spawn.Troops.UnholdBog,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			MinR = 0.75 * 500,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Schrat,
					Cost = 70
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Hexe,
					Cost = 50,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = ::Const.World.Spawn.Troops.DirewolfBodyguard,
							Cost = 20,
							function Weight( scale )
							{
								return 50;
							}

						}
					]
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendHexeLeader,
					MinR = 650,
					Cost = 300,
					MinGuards = 2,
					MaxGuards = 3,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = ::Const.World.Spawn.Troops.LegendWhiteDirewolfBodyguard,
							Cost = 400,
							function Weight( scale )
							{
								return 50;
							}

						},
						{
							Type = ::Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard,
							Cost = 250,
							function Weight( scale )
							{
								return 50;
							}

						}
					]
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendHexeLeader <- {
	Name = "LegendHexeLeader",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_hexe_01",
	MinR = 100,
	MaxR = 500,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.LegendHexeLeader,
			Cost = 300,
			MinGuards = 2,
			MaxGuards = 3,
			MaxGuardsWeight = 50,
			Weight = 0,
			Guards = [
				{
					Type = ::Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard,
					Cost = 250,
					function Weight( scale )
					{
						return 50;
					}

				}
			]
		}
	],
	Troops = [
		{
			Weight = 25,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Direwolf,
					Cost = 21
				},
				{
					Type = ::Const.World.Spawn.Troops.DirewolfHIGH,
					Cost = 25
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendWhiteDirewolf,
					Cost = 400
				},
				{
					Type = ::Const.World.Spawn.Troops.Hyena,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.HyenaHIGH,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 25,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Spider,
					Cost = 12
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendRedbackSpider,
					Cost = 250
				},
				{
					Type = ::Const.World.Spawn.Troops.Serpent,
					Cost = 25
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = ::Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				},
				{
					Type = ::Const.World.Spawn.Troops.GhoulHIGH,
					Cost = 35,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Unhold,
					Cost = 50
				},
				{
					Type = ::Const.World.Spawn.Troops.UnholdBog,
					Cost = 50
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendRockUnhold,
					Cost = 400
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Schrat,
					Cost = 70
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendGreenwoodSchrat,
					Cost = 400
				},
				{
					Type = ::Const.World.Spawn.Troops.SandGolem,
					Cost = 18
				},
				{
					Type = ::Const.World.Spawn.Troops.SandGolemMEDIUM,
					MinR = 200,
					Cost = 40
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Hexe,
					Cost = 50,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = ::Const.World.Spawn.Troops.DirewolfBodyguard,
							Cost = 20,
							function Weight( scale )
							{
								return 50;
							}

						},
						{
							Type = ::Const.World.Spawn.Troops.SpiderBodyguard,
							Cost = 20,
							function Weight( scale )
							{
								return 50;
							}

						}
					]
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendHexeLeader,
					MinR = 650,
					Cost = 300,
					MinGuards = 2,
					MaxGuards = 3,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = ::Const.World.Spawn.Troops.LegendWhiteDirewolfBodyguard,
							Cost = 400,
							function Weight( scale )
							{
								return 50;
							}

						},
						{
							Type = ::Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard,
							Cost = 250,
							function Weight( scale )
							{
								return 50;
							}

						}
					]
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendRockUnhold <- {
	Name = "LegendRockUnhold",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_rock_unhold_01",
	MaxR = 1000,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.LegendRockUnhold,
			Cost = 180,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendRockUnhold,
					Cost = 300
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Unhold,
					Cost = 60
				},
				{
					Type = ::Const.World.Spawn.Troops.UnholdBog,
					Cost = 60
				},
				{
					Type = ::Const.World.Spawn.Troops.UnholdFrost,
					Cost = 60
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendSkinGhouls <- {
	Name = "LegendSkinGhouls",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skin_ghoul_01",
	MaxR = 1000,
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendSkinGhoulLOW,
					Cost = 50
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendSkinGhoulMED,
					Cost = 100
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendSkinGhoulHIGH,
					Cost = 200,
					Roll = true
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendWhiteDirewolf <- {
	Name = "LegendWhiteDirewolf",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_white_direwolf_01",
	MaxR = 1000,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.LegendWhiteDirewolf,
			Cost = 150,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendWhiteDirewolf,
					Cost = 400
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Direwolf,
					Cost = 20
				},
				{
					Type = ::Const.World.Spawn.Troops.DirewolfHIGH,
					Cost = 25
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendRedbackSpider <- {
	Name = "LegendRedbackSpider",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_redback_spider_01",
	MaxR = 500,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.LegendRedbackSpider,
			Cost = 250,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendRedbackSpider,
					Cost = 250
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Spider,
					Cost = 12
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendDemonAlp <- {
	Name = "LegendDemonAlp",
	IsDynamic = true,
	MovementSpeedMult = 1.1,
	VisibilityMult = 0.7,
	VisionMult = 1.3,
	Body = "figure_demonalp_01",
	MaxR = 500,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.LegendDemonAlp,
			Cost = 200,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Alp,
					Cost = 30
				}
			]
		},
		{
			Weight = 40,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendDemonAlp,
					Cost = 200
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendStollwurm <- {
	Name = "LegendStollwurm",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.1,
	Body = "figure_stollwurm_01",
	MaxR = 500,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.LegendStollwurm,
			Cost = 500,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Lindwurm,
					Cost = 80
				}
			]
		},
		{
			Weight = 40,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendStollwurm,
					Cost = 500
				}
			]
		}
	]
};
gt.Const.World.Spawn.LegendGreenwoodSchrat <- {
	Name = "LegendGreenwoodSchrat",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 0.9,
	VisionMult = 1.2,
	Body = "figure_greenwood_schrat_01",
	MaxR = 500,
	Fixed = [
		{
			Type = ::Const.World.Spawn.Troops.LegendGreenwoodSchrat,
			Cost = 350,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Schrat,
					Cost = 70
				}
			]
		},
		{
			Weight = 40,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendGreenwoodSchrat,
					Cost = 350
				}
			]
		}
	]
};
gt.Const.World.Spawn.Hyenas <- {
	Name = "Hyenas",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_hyena_01",
	MaxR = 650,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Hyena,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.HyenaHIGH,
					MinR = 400,
					Cost = 20
				}
			]
		}
	]
};
gt.Const.World.Spawn.Serpents <- {
	Name = "Serpents",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_serpent_01",
	MaxR = 560,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Serpent,
					Cost = 50
				}
			]
		}
	]
};
gt.Const.World.Spawn.SandGolems <- {
	Name = "SandGolems",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_golem_01",
	MaxR = 560,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.SandGolem,
					Cost = 18
				},
				{
					Type = ::Const.World.Spawn.Troops.SandGolemMEDIUM,
					MinR = 200,
					Cost = 40
				}
			]
		}
	]
};

