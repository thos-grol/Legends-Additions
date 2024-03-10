local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

///////////////////////////////////////////////////////////////////////////
// Trees
///////////////////////////////////////////////////////////////////////////

gt.Const.Perks.FastTree <- {
	ID = "FastTree",
	Name = "Fast",
	Descriptions = [
		"is fast"
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
			gt.Const.Perks.PerkDefs.QuickHands
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Overwhelm
		]
	]
};

gt.Const.Perks.AgileTree <- {
	ID = "AgileTree",
	Name = "Agile",
	Descriptions = [
		"is agile"
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Pathfinder
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Agile
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendTwirl
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendEscapeArtist
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Colossus
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SunderingStrikes
		],
		[],
		[
			gt.Const.Perks.PerkDefs.DeathDealer
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendMuscularity
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Underdog,
			gt.Const.Perks.PerkDefs.LoneWolf
		],
		[],
		[
			gt.Const.Perks.PerkDefs.FortifiedMind
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SurvivalInstinct
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendMindOverBody
		]
	]
};

gt.Const.Perks.CalmTree <- {
	ID = "CalmTree",
	Name = "Calm",
	Descriptions = [
		"is calm"
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendRecuperation
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendPeaceful
		],
		[],
		[
			gt.Const.Perks.PerkDefs.BattleFlow
		],
		[],
		[
			gt.Const.Perks.PerkDefs.PerfectFocus
		]
	]
};

gt.Const.Perks.DeviousTree <- {
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Backstabber
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Footwork
		],
		[],
		[
			gt.Const.Perks.PerkDefs.PocketDirt
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBlendIn
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.HeadHunter
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Fearsome
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Berserk
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Vengeance
		]
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendRecuperation
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Steadfast
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Fitness
		],
		[],
		[
			gt.Const.Perks.PerkDefs.FreshAndFurious
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Colossus
		],
		[],
		[
			gt.Const.Perks.PerkDefs.HoldOut
		],
		[],
		[
			gt.Const.Perks.PerkDefs.NineLives
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Indomitable
		]
	]
};

///////////////////////////////////////////////////////////////////////////
// Special
///////////////////////////////////////////////////////////////////////////

gt.Const.Perks.IntelligentTree <- {
	ID = "IntelligentTree",
	Name = "Intelligent",
	Descriptions = [
		"is intelligent"
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Student
		],
		[],
		[
			gt.Const.Perks.PerkDefs.PatternRecognition

		],
		[],
		[
			gt.Const.Perks.PerkDefs.ArcaneInsight
		],
		[],
		[]
	]
};

gt.Const.Perks.InspirationalTree <- {
	ID = "InspirationalTree",
	Name = "Officer",
	Descriptions = [
		"is good at commanding"
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LeadByExample
		],
		[],
		[
			gt.Const.Perks.PerkDefs.TrialByFire
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Inspire
		],
		[],
		[
			gt.Const.Perks.PerkDefs.InspiringPresence //Teamwork Exercises
		]
	]
};

gt.Const.Perks.TrainedTree <- {
	ID = "TrainedTree",
	Name = "Trained",
	Descriptions = [
		"is trained"
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
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.Rotation
		],
		[
			gt.Const.Perks.PerkDefs.LegendAdaptive
		],
		[
			gt.Const.Perks.PerkDefs.BagsAndBelts,
			gt.Const.Perks.PerkDefs.LegendFieldTriage,
			gt.Const.Perks.PerkDefs.LegendSpecBandage,
		],
		[
		],
		[
			gt.Const.Perks.PerkDefs.LegendBackToBasics
		],
		[],
		[]
	]
};

gt.Const.Perks.OrganisedTree <- { //Unused
	ID = "OrganisedTree",
	Name = "Organized",
	Descriptions = [
		"is organized"
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
	},
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

gt.Const.Perks.MartyrTree <- { //Unused
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
	},
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[]
	]
};

///////////////////////////////////////////////////////////////////////////
// Done
///////////////////////////////////////////////////////////////////////////

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

	function getRandom( _exclude, _flags )
	{
		if (_flags.has("Intelligent") && _exclude.find("IntelligentTree") == null) return gt.Const.Perks.IntelligentTree;
		if (_flags.has("Commander") && _exclude.find("InspirationalTree") == null) return gt.Const.Perks.InspirationalTree;
		if (_flags.has("Large") && _exclude.find("LargeTree") == null) return gt.Const.Perks.LargeTree;
		if (_flags.has("Vicious") && _exclude.find("ViciousTree") == null) return gt.Const.Perks.ViciousTree;
		if (_flags.has("Devious") && _exclude.find("DeviousTree") == null) return gt.Const.Perks.DeviousTree;
		if (_flags.has("Fast") && _exclude.find("FastTree") == null) return gt.Const.Perks.FastTree;
		if (_flags.has("Sturdy") && _exclude.find("SturdyTree") == null) return gt.Const.Perks.SturdyTree;
		if (_flags.has("Tenacious") && _exclude.find("IndestructibleTree") == null) return gt.Const.Perks.IndestructibleTree;
		if (_flags.has("Fit") && _exclude.find("FitTree") == null) return gt.Const.Perks.FitTree;


		local L = [];
		foreach( i, t in this.Tree )
		{
			if (t.ID == "OrganisedTree") continue; //unused
			if (t.ID == "MartyrTree") continue; //unused
			if (t.ID == "LargeTree" && _flags.has("Tiny")) continue; //Tiny cannot be large. Duh
			if (t.ID == "TrainedTree") continue; //background unlocks it
			if (t.ID == "IntelligentTree") continue; //needs bright trait to unlock
			if (t.ID == "InspirationalTree") continue; //needs team player trait to unlock

			if (_exclude != null && _exclude.find(t.ID) != null) continue;
			L.push(i);
		}

		local r = ::Math.rand(0, L.len() - 1);
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

		local r = ::Math.rand(0, L.len() - 1);
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