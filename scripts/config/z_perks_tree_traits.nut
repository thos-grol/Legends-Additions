//TODO: each tree needs 3-4 perks
local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.AgileTree <- {
	ID = "AgileTree",
	Name = "Agile",
	Descriptions = [
		"is agile"
	],
	Attributes = {
		Hitpoints = [
			-4,
			-4
		],
		Bravery = [
			-2,
			-2
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			-2,
			-2
		],
		RangedSkill = [
			4,
			4
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			2,
			2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Pathfinder,
			//gt.Const.Perks.PerkDefs.Sprint //TODO: add sprint to pathfinder
			//gt.Const.Perks.PerkDefs.LegendClimb //TODO: add climb to pathfinder
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Footwork
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendEscapeArtist
		]
	]
};
gt.Const.Perks.IndestructibleTree <- {
	ID = "IndestructibleTree",
	Name = "Tenacious",
	Descriptions = [
		"is tenacious"
	],
	Attributes = {
		Hitpoints = [
			4,
			4
		],
		Bravery = [
			2,
			2
		],
		Stamina = [
			-2,
			-2
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			-2,
			-2
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			-4,
			-4
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.FortifiedMind
			//gt.Const.Perks.PerkDefs.LegendTrueBeliever //Combine with fortified mind
		],
		[],
		[
			
		],
		[],
		[],
		[
			
		],
		[
			gt.Const.Perks.PerkDefs.LegendMindOverBody
		]
	]
};

gt.Const.Perks.SturdyTree <- {
	ID = "SturdyTree",
	Name = "Sturdy",
	Descriptions = [
		"is sturdy"
	],
	Attributes = {
		Hitpoints = [
			2,
			2
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			2,
			2
		],
		MeleeSkill = [
			-2,
			-2
		],
		RangedSkill = [
			-2,
			-2
		],
		MeleeDefense = [
			4,
			4
		],
		RangedDefense = [
			-4,
			-4
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.NineLives,
			//gt.Const.Perks.PerkDefs.LegendSecondWind //TODO: merge
		],
		[],
		[
			gt.Const.Perks.PerkDefs.HoldOut //TODO: rework
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.Indomitable
		]
	]
};

gt.Const.Perks.MartyrTree <- {
	ID = "MartyrTree",
	Name = "Martyr",
	Descriptions = [
		"has martyr complex"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			2,
			2
		],
		MeleeSkill = [
			-2,
			-2
		],
		RangedSkill = [
			-4,
			-4
		],
		MeleeDefense = [
			4,
			4
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			-2,
			-2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Underdog
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LoneWolf
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LastStand
			
		]
	]
};
gt.Const.Perks.ViciousTree <- {
	ID = "ViciousTree",
	Name = "Vicious",
	Descriptions = [
		"is vicious"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			2,
			2
		],
		Stamina = [
			-2,
			-2
		],
		MeleeSkill = [
			4,
			4
		],
		RangedSkill = [
			2,
			2
		],
		MeleeDefense = [
			-2,
			-2
		],
		RangedDefense = [
			-4,
			-4
		],
		Initiative = [
			2,
			2
		]
	},
	Tree = [
		[
			//gt.Const.Perks.PerkDefs.Fearsome
			gt.Const.Perks.PerkDefs.Vengeance
			//TODO: merge
		],
		[],
		[
			gt.Const.Perks.PerkDefs.HeadHunter
			//gt.Const.Perks.PerkDefs.Debilitate
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Berserk
		],
		[
			
		],
		[
			gt.Const.Perks.PerkDefs.KillingFrenzy
		]
	]
};
gt.Const.Perks.DeviousTree <- { //TODO: devious tree needs improvement
	ID = "DeviousTree",
	Name = "Devious",
	Descriptions = [
		"is devious"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			-4,
			-4
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			2,
			2
		],
		RangedSkill = [
			2,
			2
		],
		MeleeDefense = [
			-2,
			-2
		],
		RangedDefense = [
			4,
			4
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Backstabber
			//gt.Const.Perks.PerkDefs.CoupDeGrace //TODO: Merge
		],
		[
			
		],
		[
			gt.Const.Perks.PerkDefs.LegendBlendIn
			//TODO: Merge Reforged Sneak attack: when entering a zoc or ranged attacking an enemy engaged in melee, gain damage increase and armor pen

		],
		[],
		[
			//gt.Const.Perks.PerkDefs.LegendEvasion
			
		],
		[],
		[]
	]
};
gt.Const.Perks.InspirationalTree <- {
	ID = "InspirationalTree",
	Name = "Inspirational",
	Descriptions = [
		"is inspirational"
	],
	Attributes = {
		Hitpoints = [
			-2,
			-2
		],
		Bravery = [
			4,
			4
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			2,
			2
		],
		RangedSkill = [
			-4,
			-4
		],
		MeleeDefense = [
			2,
			2
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			-2,
			-2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendAssuredConquest
			gt.Const.Perks.PerkDefs.Inspire //TODO: merge
		],
		[],
		[
			gt.Const.Perks.PerkDefs.InspiringPresence
			//gt.Const.Perks.PerkDefs.RallyTheTroops //TODO: becomes passive 25%
			//TODO: give active as well
		],
		[],
		[
			
		],
		[],
		[
			
		]
	]
};
gt.Const.Perks.IntelligentTree <- {
	ID = "IntelligentTree",
	Name = "Intelligent",
	Descriptions = [
		"is intelligent"
	],
	Attributes = {
		Hitpoints = [
			-2,
			-2
		],
		Bravery = [
			4,
			4
		],
		Stamina = [
			-2,
			-2
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			-4,
			-4
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			2,
			2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Gifted
			//gt.Const.Perks.PerkDefs.Student //TODO: merge gifted into student
		],
		[],
		[
			gt.Const.Perks.PerkDefs.FastAdaption
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.PerfectFocus
		]
	]
};
gt.Const.Perks.CalmTree <- {
	ID = "CalmTree",
	Name = "Calm",
	Descriptions = [
		"is calm",
		"is soothingly relaxed",
		"projects peace of mind",
		"seems unflustered",
		"goes with the flow",
		"is unworried"
	],
	Attributes = {
		Hitpoints = [
			-2,
			-2
		],
		Bravery = [
			2,
			2
		],
		Stamina = [
			-2,
			-2
		],
		MeleeSkill = [
			-4,
			-4
		],
		RangedSkill = [
			4,
			4
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			2,
			2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendPeaceful
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendClarity
		],
		[],
		[
			gt.Const.Perks.PerkDefs.BattleFlow
		]
	]
};


gt.Const.Perks.OrganisedTree <- { //TODO: rework tree
	ID = "OrganisedTree",
	Name = "Organized",
	Descriptions = [
		"is organized"
	],
	Attributes = {
		Hitpoints = [
			2,
			2
		],
		Bravery = [
			-2,
			-2
		],
		Stamina = [
			4,
			4
		],
		MeleeSkill = [
			-4,
			-4
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			-2,
			-2
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			2,
			2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendHelpful
		],
		[
			
		],
		[
			
		],
		[],
		[
			
		],
		[],
		[]
	]
};

gt.Const.Perks.FitTree <- {
	ID = "FitTree",
	Name = "Fit",
	Descriptions = [
		"is fit"
	],
	Attributes = {
		Hitpoints = [
			2,
			2
		],
		Bravery = [
			-4,
			-4
		],
		Stamina = [
			4,
			4
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			-2,
			-2
		],
		MeleeDefense = [
			2,
			2
		],
		RangedDefense = [
			-2,
			-2
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendRecuperation,
			//gt.Const.Perks.PerkDefs.Recover //TODO: recup grants recover
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Relentless
			//gt.Const.Perks.PerkDefs.Steadfast //TODO: merge
		],
		[],
		[
			
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Rebound
		]
	]
};

gt.Const.Perks.LargeTree <- {
	ID = "LargeTree",
	Name = "Large",
	Descriptions = [
		"is large"
	],
	Attributes = {
		Hitpoints = [
			4,
			4
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			2,
			2
		],
		MeleeSkill = [
			2,
			2
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			-4,
			-4
		],
		RangedDefense = [
			-2,
			-2
		],
		Initiative = [
			-2,
			-2
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Colossus
			gt.Const.Perks.PerkDefs.SteelBrow
			//TODO: Merge
		],
		[
			
		],
		[
			gt.Const.Perks.PerkDefs.SunderingStrikes
			gt.Const.Perks.PerkDefs.CripplingStrikes
			//TODO: merge, heavy strikes
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendMuscularity
		]
	]
};

gt.Const.Perks.FastTree <- {
	ID = "FastTree",
	Name = "Fast",
	Descriptions = [
		"is fast"
	],
	Attributes = {
		Hitpoints = [
			-2,
			-2
		],
		Bravery = [
			-2,
			-2
		],
		Stamina = [
			-4,
			-4
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			2,
			2
		],
		MeleeDefense = [
			0,
			0
		],
		RangedDefense = [
			2,
			2
		],
		Initiative = [
			4,
			4
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendAlert
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Adrenaline
		],
		[],
		[
			gt.Const.Perks.PerkDefs.DoubleStrike
			gt.Const.Perks.PerkDefs.Anticipation //TODO: rework to 15%, buff anticipation
		],
		[
			gt.Const.Perks.PerkDefs.Overwhelm
		],
		[]
	]
};














///////////////////////////////////////////////////////////////////////////
// Done
///////////////////////////////////////////////////////////////////////////


gt.Const.Perks.TrainedTree <- {
	ID = "TrainedTree",
	Name = "Trained",
	Descriptions = [
		"is trained"
	],
	Attributes = {
		Hitpoints = [
			-2,
			-2
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			4,
			4
		],
		RangedSkill = [
			2,
			2
		],
		MeleeDefense = [
			2,
			2
		],
		RangedDefense = [
			-2,
			-2
		],
		Initiative = [
			-4,
			-4
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Rotation
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBackToBasics
		],
		[
			gt.Const.Perks.PerkDefs.Finesse
		],
		[

		]
	]
};
gt.Const.Perks.TraitsTrees <- {
	Tree = [
		gt.Const.Perks.AgileTree,
		gt.Const.Perks.IndestructibleTree,
		gt.Const.Perks.MartyrTree,
		gt.Const.Perks.ViciousTree,
		gt.Const.Perks.DeviousTree,
		gt.Const.Perks.InspirationalTree,
		gt.Const.Perks.IntelligentTree,
		gt.Const.Perks.CalmTree,
		gt.Const.Perks.FastTree,
		gt.Const.Perks.LargeTree,
		gt.Const.Perks.OrganisedTree,
		gt.Const.Perks.SturdyTree,
		gt.Const.Perks.FitTree,
		gt.Const.Perks.TrainedTree
	],
	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude != null && _exclude.find(t.ID) != null)
			{
				continue;
			}

			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

	function getRandomPerk()
	{
		local tree = this.getRandom(null);
		local L = [];

		foreach( row in tree.Tree )
		{
			foreach( p in row )
			{
				L.push(p);
			}
		}

		local r = this.Math.rand(0, L.len() - 1);
		return L[r];
	}

	function getBaseAttributes()
	{
		return {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
	}

};

