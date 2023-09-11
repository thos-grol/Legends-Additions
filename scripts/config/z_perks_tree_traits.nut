local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.CalmTree <- { //TODO: plan tree
	ID = "CalmTree",
	Name = "Calm",
	Descriptions = [
		"is calm"
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
			gt.Const.Perks.PerkDefs.BattleFlow  //TODO: calm perk tier 3, merge in perk_rf_unstoppable
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendPeaceful //TODO: calm perk tier 5, rename to inner peace, rework
		],
		[],
		[
			gt.Const.Perks.PerkDefs.PerfectFocus //TODO: calm perk tier 7 add sfx, redo description.
		]
	]
};

///////////////////////////////////////////////////////////////////////////
// Scheduled
///////////////////////////////////////////////////////////////////////////

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
			//TODO: descriptions: Are you a dog or a wolf?
			gt.Const.Perks.PerkDefs.Underdog,
			gt.Const.Perks.PerkDefs.LoneWolf
		],
		[],
		[
			gt.Const.Perks.PerkDefs.FortifiedMind //TODO: rename to Inner Faith. Combine with fortified mind
			//gt.Const.Perks.PerkDefs.LegendTrueBeliever
		],
		[],
		[
			//"Survival Instinct //TODO: Tenacious t3 perk perk_rf_survival_instinct
			// Whenever you are attacked, gain a stacking bonus to Melee and Ranged Defense of +2 on a miss and +5 on a hit. This can stack up to 5 tgimes for misses and up to 2 times for hits.
			// At the start of every turn, the bonus is reset except the bonus gained from getting hit which is retained for the remainder of the combat."
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendMindOverBody //TODO: buff, Ignores the effects of temporary injuries, no morale loss upon being hit
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
			gt.Const.Perks.PerkDefs.HeadHunter
		],
		[],
		[
			//TODO: vicious t3 perk, Sadism
			//gt.Const.Perks.PerkDefs.Fearsome
			//gt.Const.Perks.PerkDefs.Debilitate, strikes have a 10% chance to debilitate. Adds active.
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Berserk
		],
		[],
		[
			
			gt.Const.Perks.PerkDefs.Vengeance  //TODO: vicious t7 perk //Buff: Store hits, every hit taken will increase fatality chance
			
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
			//TODO: fit perk tier 5, "Wears it Well Reduce overall penalty to Max Fatigue by Mainhand, Offhand, Head and Body Gear is reduced by 20%. Stacks with Brawny." perk_rf_wears_it_well
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
			//TODO: sturdy t7 perk, buff indom? make it trigger at hp % automatically?
			gt.Const.Perks.PerkDefs.Indomitable
			//"Indomitable
			// In addition to previous bonuses, now grants immunity to Cull while active.
			//TODO: rework, also fix direwolf indom.
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
			//TODO: devious perk tier 5, //gt.Const.Perks.PerkDefs.Footwork
			
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Ghostlike
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBlendIn
		]
	]
};

///////////////////////////////////////////////////////////////////////////
// Done
///////////////////////////////////////////////////////////////////////////

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
			gt.Const.Perks.PerkDefs.LegendTwirl
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Ghostlike
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
			//TODO: intelligent perk tier 3, port Pattern Recognition. higher intelligence allows one to extrapolate patterns from data
		],
		[],
		[
			//TODO: intelligent perk tier 5
		],
		[],
		[
			//TODO: intelligent perk tier 7
		]
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
			gt.Const.Perks.PerkDefs.LeadByExample
		],
		[],
		[
			gt.Const.Perks.PerkDefs.InspiringPresence //Teamwork Exercises
			
		],
		[],
		[
			gt.Const.Perks.PerkDefs.TrialByFire
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Inspire
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
		[
			gt.Const.Perks.PerkDefs.BagsAndBelts //TODO: description
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBackToBasics
		],
		[
			gt.Const.Perks.PerkDefs.Finesse
		],
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
		if (_flags.has("Huge") && _exclude.find("LargeTree") == null) return gt.Const.Perks.LargeTree;

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