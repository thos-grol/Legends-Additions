local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

//TODO: take the nerf hammer after to balance trees.
//Philosophy try to remove damage buffs from lower tiers.

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
			//TODO: Agile t3 perk
			//gt.Const.Perks.PerkDefs.Footwork
		],
		[],
		[
			//TODO: Agile t5 perk
		],
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
			gt.Const.Perks.PerkDefs.FortifiedMind //TODO: rename to Inner Faith. Combine with fortified mind
			//gt.Const.Perks.PerkDefs.LegendTrueBeliever
		],
		[],
		[
			//TODO: Tenacious t3 perk
			//"Survival Instinct //TODO: port over
			// Whenever you are attacked, gain a stacking bonus to Melee and Ranged Defense of +2 on a miss and +5 on a hit. This can stack up to 5 tgimes for misses and up to 2 times for hits.
			// At the start of every turn, the bonus is reset except the bonus gained from getting hit which is retained for the remainder of the combat."
		],
		[],
		[],
		[
			//TODO: Tenacious t5 perk
			//gt.Const.Perks.PerkDefs.LegendAssuredConquest
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
			//TODO: sturdy t1 perk
			gt.Const.Perks.PerkDefs.NineLives,
			//gt.Const.Perks.PerkDefs.LegendSecondWind
		],
		[],
		[
			//TODO: sturdy t3 perk
			gt.Const.Perks.PerkDefs.HoldOut //TODO: rework " resists being overwhelmed thanks to his unnatural physiology"
		],
		[],
		[
			//TODO: sturdy t5 perk
		],
		[],
		[
			//TODO: sturdy t7 perk, buff indom? make it trigger at hp % automatically?
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
			//TODO: martyr t1 perk
			gt.Const.Perks.PerkDefs.Underdog
		],
		[],
		[
			//TODO: martyr t3 perk
			gt.Const.Perks.PerkDefs.LoneWolf
		],
		[],
		[
			//TODO: martyr t5 perk
		],
		[],
		[
			//TODO: martyr t7 perk
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
			//TODO: vicious t1
		],
		[],
		[
			//TODO: vicious t3 perk
			gt.Const.Perks.PerkDefs.HeadHunter
			//gt.Const.Perks.PerkDefs.Debilitate
		],
		[],
		[
			//TODO: vicious t5 perk
			gt.Const.Perks.PerkDefs.Berserk
		],
		[],
		[
			//TODO: vicious t7 perk
			gt.Const.Perks.PerkDefs.KillingFrenzy
			gt.Const.Perks.PerkDefs.Vengeance
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
		],
		[],
		[
			//TODO: devious perk tier 3

		],
		[],
		[
			//TODO: devious perk tier 5, rethink
			gt.Const.Perks.PerkDefs.LegendEvasion
			//gt.Const.Perks.PerkDefs.Anticipation //TODO: rework to 15%, buff anticipation, rename something involving reflexes
			// give mdef and rdef
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBlendIn
		]
	]
};
gt.Const.Perks.InspirationalTree <- { //TODO: move to commanding tree
	ID = "InspirationalTree",
	Name = "Commanding",
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
			//TODO: inspirational perk tier 1
			
		],
		[],
		[
			//TODO: inspirational perk tier 3 rework
			// Lead By Example
			// Gives all bros within vision 5% of attack, defense, and resolve. 
			// Only one bro in the party can have this perk at a time. Selecting it will refund that bro's perk. 
			//gt.Const.Perks.PerkDefs.InspiringPresence //Use code
		],
		[],
		[
			//TODO: inspirational perk tier 5: Trial By Fire + RallyTheTroops
			// Trial By Fire
				// Any soldiers below level 5 will be automatically promoted after a successful mission with this officer.
				// On battle start, give all bros meeting criteria perk effect.
				// On battle won, give bros level up.
				// Only one bro in the party can have this perk at a time. Selecting it will refund that bro's perk. 
			//gt.Const.Perks.PerkDefs.RallyTheTroops
		],
		[],
		[
			//TODO: inspirational perk tier 7
			//gt.Const.Perks.PerkDefs.Inspire //Rename to command
				//End your turn to grant +4 AP to any visible unit.
				//Only one bro in the party can have this perk at a time. Selecting it will refund that bro's perk. 
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
			//TODO: inspirational perk tier 3, port Pattern Recognition. higher intelligence allows one to extrapolate patterns from data
		],
		[],
		[
			//TODO: inspirational perk tier 5
		],
		[],
		[
			//TODO: inspirational perk tier 7
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
			//TODO: calm perk tier 1
		],
		[],
		[
			gt.Const.Perks.PerkDefs.BattleFlow  //TODO: calm perk tier 3 port over unstoppable?, also keep fat buff
		],
		[],
		[
			//TODO: calm perk tier 5
			gt.Const.Perks.PerkDefs.LegendPeaceful //TODO: rename to inner peace
			//TODO: rework
		],
		[],
		[

			gt.Const.Perks.PerkDefs.PerfectFocus //TODO: calm perk tier 7 add sfx, redo description.
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
			//TODO: calm perk tier 5
		],
		[],
		[
			//TODO: calm perk tier 7
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

gt.Const.Perks.FastTree <- { //Complete
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
			gt.Const.Perks.PerkDefs.QuickHands
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Overwhelm
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
			//TODO: trained tree tier 7
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
	function getRandom( _exclude, _flags )
	{
		if (_flags.has("Intelligent") && !_flags.has("IntelligentAdded"))
		{
			_flags.set("IntelligentAdded", true)
			return gt.Const.Perks.IntelligentTree;
		}
		
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (t.ID == "InspirationalTree") continue;
			if (t.ID == "OrganisedTree") continue;
			if (t.ID == "IntelligentTree") continue;
			if (_exclude != null && _exclude.find(t.ID) != null) continue;
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