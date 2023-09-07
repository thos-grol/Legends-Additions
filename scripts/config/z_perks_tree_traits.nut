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
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Footwork
		],
		[

		],
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
			gt.Const.Perks.PerkDefs.FortifiedMind //TODO: rename to Inner Faith
			//gt.Const.Perks.PerkDefs.LegendTrueBeliever //Combine with fortified mind
		],
		[],
		[
			//"Survival Instinct //TODO: port over
			// Whenever you are attacked, gain a stacking bonus to Melee and Ranged Defense of +2 on a miss and +5 on a hit. This can stack up to 5 tgimes for misses and up to 2 times for hits.
			// At the start of every turn, the bonus is reset except the bonus gained from getting hit which is retained for the remainder of the combat."
		],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendAssuredConquest
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
			//"Indomitable
			// In addition to previous bonuses, now grants immunity to Cull while active.
			//TODO: rework, also fix direwolf indom.
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
			gt.Const.Perks.PerkDefs.Backstabber //TODO: Backstabber + CoupDeGrace
			//"Backstabber (requires Melee Attack)
			// The bonus to hitchance in melee is doubled to +10% for each ally surrounding and distracting your target.
			// Melee Piercing type attacks gain +5% damage per ally surrounding the target."
			//gt.Const.Perks.PerkDefs.CoupDeGrace
		],
		[],
		[
			//TODO: borderlands 2 skills trees ideas
			//TODO: stone shard
			//TODO: dead cells.
			//TODO: pokemon
			//TODO: FF Tactics and Tactics Ogre handle classes
			//TODO: Dungeon crawl stone soup
			//TODO: nethack
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendEvasion
			//gt.Const.Perks.PerkDefs.Anticipation //TODO: rework to 15%, buff anticipation, rename something involving reflexes
			// give mdef and rdef
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBlendIn
			//TODO: Merge Reforged Sneak attack: when entering a zoc or ranged attacking an enemy engaged in melee, gain damage increase and armor pen
		]
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
			gt.Const.Perks.PerkDefs.InspiringPresence //TODO: InspiringPresence + RallyTheTroops
			//gt.Const.Perks.PerkDefs.RallyTheTroops
		],
		[],
		[
			//Exude confidence.


		],
		[],
		[
			gt.Const.Perks.PerkDefs.Inspire
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
			gt.Const.Perks.PerkDefs.Student
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


gt.Const.Perks.OrganisedTree <- { //TODO: remake and rename tree? Combat
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
			gt.Const.Perks.PerkDefs.LegendRecuperation
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Steadfast
		],
		[],
		[
			//TODO: missing perk
		],
		[],
		[
			//TODO: missing perk //Vigourous Assault
		]
	]
};

gt.Const.Perks.LargeTree <- { //Complete
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
			gt.Const.Perks.PerkDefs.Adrenaline
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendAlert //TODO: redo description
		],
		[],
		[
			gt.Const.Perks.PerkDefs.QuickHands
			// "Looking for this? Swapping any item in battle except for shields becomes a free action with no Action Point cost once every turn.", //TODO: redo description
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Overwhelm //TODO: Overwhelm + DoubleStrike
			//gt.Const.Perks.PerkDefs.DoubleStrike
		]
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
			//"Pattern Recognition
			// Every time an opponent attacks you or you attack an opponent, gain stacking Melee Skill and Melee Defense against that opponent for the remainder of the combat. Every subsequent attack gives a larger bonus, with the first attack giving +1, the second +2, the third +3, and so on. Once the bonus reaches 10, all subsequent attacks increase it by +1 only. Only works with dealing or receiving Melee Attacks."

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

