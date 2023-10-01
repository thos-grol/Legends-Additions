local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

///////////////////////////////////////////////////////////////////////////
// Melee
///////////////////////////////////////////////////////////////////////////

gt.Const.Perks.AxeTree <- {
	ID = "Axe",
	Name = "Axe",
	Descriptions = [
		"axes"
	],
	Attributes = {
		Hitpoints = [
			3,
			3
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
			3,
			3
		],
		RangedSkill = [
			-3,
			-3
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
			-3,
			-3
		]
	},
	Tree = [
		[],
		[],
		[
			//TODO: axe free perk
		],
		[
			gt.Const.Perks.PerkDefs.SpecAxe
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage
		],
		[
			gt.Const.Perks.PerkDefs.StanceExecutioner
		]
	]
};

gt.Const.Perks.CleaverTree <- {
	ID = "Cleaver",
	Name = "Cleaver",
	Descriptions = [
		"cleavers"
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
			3,
			3
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
			-3,
			-3
		],
		RangedDefense = [
			-3,
			-3
		],
		Initiative = [
			3,
			3
		]
	},
	Tree = [
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendLacerate
		],
		[
			gt.Const.Perks.PerkDefs.SpecCleaver
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage
		],
		[
			gt.Const.Perks.PerkDefs.StanceGourmet
		]
	]
};

gt.Const.Perks.SwordTree <- {
	ID = "Sword",
	Name = "One-Handed Sword",
	Descriptions = [
		"swords"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			-3,
			-3
		],
		Stamina = [
			3,
			3
		],
		MeleeSkill = [
			3,
			3
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
			-3,
			-3
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[
			//TODO: perk idea, Quickstep
			//gives the footwork active skill
			//hitting an attack has a 25% chance to make the AP cost of the next use of footwork to 0
			//Having the footwork perk increases this chance to 75%
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecSword,
		],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage,
		],
		[
			//[Stance] The Strongest
				//The strongest are undeterred no matter what they face.
				//At the end of the turn, riposte.
				//Upon the first melee attack hit per turn at 1 tile range, negate the attack and riposte it. Then remove riposte.

			//[Stance] Wrath
				//Sacrifice defense to gain the ultimate offense.
				// Area-of-Effect attacks cost -2 Action points and build 20% less Fatigue."
				// Gain x% increased damage
				// Reduce melee defense by x%
		]
	]
};

gt.Const.Perks.MaceTree <- { //FEATURE_0: tree mace
	ID = "Mace",
	Name = "Mace",
	Descriptions = [
		"maces"
	],
	Attributes = {
		Hitpoints = [
			3,
			3
		],
		Bravery = [
			3,
			3
		],
		Stamina = [
			-3,
			-3
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			-3,
			-3
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
		[

		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecMace
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReturnFavor
		],
		[
			//FEATURE_0: stances
		]
	]
};

gt.Const.Perks.HammerTree <- { //FEATURE_0: tree hammer
	ID = "Hammer",
	Name = "Hammer",
	Descriptions = [
		"hammers"
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
			3,
			3
		],
		MeleeSkill = [
			0,
			0
		],
		RangedSkill = [
			-3,
			-3
		],
		MeleeDefense = [
			3,
			3
		],
		RangedDefense = [
			0,
			0
		],
		Initiative = [
			-3,
			-3
		]
	},
	Tree = [
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSmackdown
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecHammer
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage,
		],
		[
			//FEATURE_0: stances
		]
	]
};

gt.Const.Perks.FlailTree <- { //FEATURE_0: tree flail
	ID = "Flail",
	Name = "Flail",
	Descriptions = [
		"flails"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			-3,
			-3
		],
		Stamina = [
			-3,
			-3
		],
		MeleeSkill = [
			3,
			3
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
			3,
			3
		]
	},
	Tree = [
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecFlail
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage,

		],
		[
			//FEATURE_0: stances
		]
	]
};

gt.Const.Perks.SpearTree <- {
	ID = "Spear",
	Name = "Spear",
	Descriptions = [
		"spears"
	],
	Attributes = {
		Hitpoints = [
			-3,
			-3
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			-3,
			-3
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
			3,
			3
		],
		RangedDefense = [
			3,
			3
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[],
		[

		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecSpear
		],
		[
			//TODO: // "Poke Poke
			//Decrease the AP cost of spear and polearm attacks by 1.

		],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage
		],
		[
			//TODO: Soveriegn
			//Poke poke poke poke
			// On turn end, attack all adjacent enemies once
		]
	]
};

gt.Const.Perks.PolearmTree <- { //FEATURE_0: tree polearm
	ID = "Polearm",
	Name = "Polearm",
	Descriptions = [
		"polearms"
	],
	Attributes = {
		Hitpoints = [
			-3,
			-3
		],
		Bravery = [
			3,
			3
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
			-3,
			-3
		],
		RangedDefense = [
			3,
			3
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
		[
			gt.Const.Perks.PerkDefs.SpecPolearm
		],
		[],
		[
			gt.Const.Perks.PerkDefs.ReachAdvantage
		],
		[]
	]
};

///////////////////////////////////////////////////////////////////////////
// Special - Melee
///////////////////////////////////////////////////////////////////////////

gt.Const.Perks.DaggerTree <- { //FEATURE_0: dagger becomes a sidearm tree (2 perks, no stance or mastery)
	ID = "Dagger",
	Name = "Dagger",
	Descriptions = [
		"daggers"
	],
	Attributes = {
		Hitpoints = [
			3,
			3
		],
		Bravery = [
			-3,
			-3
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
			-3,
			-3
		],
		Initiative = [
			3,
			3
		]
	},
	Tree = [
		[],
		[
			//TODO: Puncture, unlocks the ability to puncture with daggers.
		],
		[],
		[
			//TODO: Finish them, if the enemy is sleeping or stunned, puncture has 100% to hit.
		],
		[],
		[],
		[]
	]
};

gt.Const.Perks.ShieldTree <- { //FEATURE_0: tree shield
	ID = "ShieldTree",
	Name = "Shield",
	Descriptions = [
		"shields"
	],
	Attributes = {
		Hitpoints = [
			3,
			3
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
			-3,
			-3
		],
		MeleeDefense = [
			3,
			3
		],
		RangedDefense = [
			-3,
			-3
		],
		Initiative = [
			3,
			3
		]
	},
	Tree = [
		[],
		[
			gt.Const.Perks.PerkDefs.Taunt
		],
		[

		],
		[
			gt.Const.Perks.PerkDefs.ShieldExpert //FEATURE_0: rework shield
			//increase shield damage reduction
			//provides some damage reduction to the user
			//remove defence bonus
			//gt.Const.Perks.PerkDefs.LegendSpecialistShieldPush
			//gt.Const.Perks.PerkDefs.ShieldBash
		],
		[],
		[],
		[]
	]
};

/////////////////////////////////////////////////////////////////////////////////////////////
// Ranged
/////////////////////////////////////////////////////////////////////////////////////////////
gt.Const.Perks.GreatSwordTree <- {
	ID = "GreatSword",
	Name = "Two-Handed Sword",
	Descriptions = [
		"greatswords"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			3,
			3
		],
		Stamina = [
			-3,
			-3
		],
		MeleeSkill = [
			-3,
			-3
		],
		RangedSkill = [
			0,
			0
		],
		MeleeDefense = [
			3,
			3
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

gt.Const.Perks.CrossbowTree <- { //TODO: ranged weaponry tree
	ID = "Crossbow",
	Name = "Crossbow",
	Descriptions = [
		"crossbows"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			3,
			3
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			-3,
			-3
		],
		RangedSkill = [
			3,
			3
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
			-3,
			-3
		]
	},
	Tree = [
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecCrossbow
		],
		[
			gt.Const.Perks.PerkDefs.LegendHeightenedReflexes
		],
		[
			gt.Const.Perks.PerkDefs.Ballistics
		],
		[
			gt.Const.Perks.PerkDefs.LegendPiercingShot
		]
	]
};

gt.Const.Perks.BowTree <- {
	ID = "Bow",
	Name = "Bow",
	Descriptions = [
		"bows"
	],
	Attributes = {
		Hitpoints = [
			-3,
			-3
		],
		Bravery = [
			0,
			0
		],
		Stamina = [
			3,
			3
		],
		MeleeSkill = [
			-3,
			-3
		],
		RangedSkill = [
			3,
			3
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
			gt.Const.Perks.PerkDefs.Lookout
		],
		[
			gt.Const.Perks.PerkDefs.Bullseye
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecBow
		],
		[
			gt.Const.Perks.PerkDefs.LegendWindReader
		],
		[],
		[]
	]
};

gt.Const.Perks.SlingTree <- {
	ID = "Sling",
	Name = "Sling",
	Descriptions = [
		"slings"
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
			-3,
			-3
		],
		RangedSkill = [
			3,
			3
		],
		MeleeDefense = [
			-3,
			-3
		],
		RangedDefense = [
			3,
			3
		],
		Initiative = [
			0,
			0
		]
	},
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendSpecialistSlingSkill
		],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendMasterySlings
		],
		[
			gt.Const.Perks.PerkDefs.LegendSpecialistSlingDamage
		],
		[],
		[]
	]
};

/////////////////////////////////////////////////////////////////////////////////////////////
// Disabled
/////////////////////////////////////////////////////////////////////////////////////////////

gt.Const.Perks.ThrowingTree <- {
	ID = "Throwing",
	Name = "Throwing",
	Descriptions = [
		"throwing weapons"
	],
	Attributes = {
		Hitpoints = [
			0,
			0
		],
		Bravery = [
			-3,
			-3
		],
		Stamina = [
			0,
			0
		],
		MeleeSkill = [
			3,
			3
		],
		RangedSkill = [
			3,
			3
		],
		MeleeDefense = [
			-3,
			-3
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
		[
			gt.Const.Perks.PerkDefs.QuickHands
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecThrowing
		],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.CloseCombatArcher
		]
	]
};

gt.Const.Perks.StaffTree <- {
	ID = "Staff",
	Name = "Staff",
	Descriptions = [
		"staves"
	],
	Attributes = {
		Hitpoints = [
			-3,
			-3
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
			3,
			3
		],
		RangedDefense = [
			3,
			3
		],
		Initiative = [
			-3,
			-3
		]
	},
	Tree = [
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSpecStaffSkill
		],
		[
			gt.Const.Perks.PerkDefs.LegendMasteryStaves
		],
		[
			gt.Const.Perks.PerkDefs.LegendSpecStaffStun
		],
		[],
		[
			gt.Const.Perks.PerkDefs.PushTheAdvantage
		]
	]
};

/////////////////////////////////////////////////////////////////////////////////////////////
// End
/////////////////////////////////////////////////////////////////////////////////////////////

gt.Const.Perks.WeaponTrees <- {
	Tree = [
		gt.Const.Perks.MaceTree,
		gt.Const.Perks.FlailTree,
		gt.Const.Perks.HammerTree,
		gt.Const.Perks.AxeTree,
		gt.Const.Perks.CleaverTree,
		gt.Const.Perks.GreatSwordTree,
		gt.Const.Perks.SwordTree,
		gt.Const.Perks.DaggerTree,
		gt.Const.Perks.PolearmTree,
		gt.Const.Perks.SpearTree,
		gt.Const.Perks.CrossbowTree,
		gt.Const.Perks.BowTree,
		gt.Const.Perks.ThrowingTree,
		gt.Const.Perks.SlingTree,
		gt.Const.Perks.ShieldTree,
		gt.Const.Perks.StaffTree
	],
	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude.find(t.ID) != null)
			{
				continue;
			}

			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

};
gt.Const.Perks.MeleeWeaponTrees <- {
	Tree = [
		gt.Const.Perks.MaceTree,
		gt.Const.Perks.FlailTree,
		gt.Const.Perks.HammerTree,
		gt.Const.Perks.AxeTree,
		gt.Const.Perks.CleaverTree,
		gt.Const.Perks.GreatSwordTree,
		gt.Const.Perks.SwordTree,
		gt.Const.Perks.DaggerTree,
		gt.Const.Perks.PolearmTree,
		gt.Const.Perks.SpearTree,
		gt.Const.Perks.ShieldTree,
		gt.Const.Perks.StaffTree
	],
	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude.find(t.ID))
			{
				continue;
			}

			L.push(i);
		}

		local r = this.Math.rand(0, L.len() - 1);
		return this.Tree[L[r]];
	}

};
gt.Const.Perks.RangedWeaponTrees <- {
	Tree = [
		gt.Const.Perks.CrossbowTree,
		gt.Const.Perks.BowTree,
		gt.Const.Perks.ThrowingTree,
		gt.Const.Perks.SlingTree
	],
	function getRandom( _exclude )
	{
		local L = [];

		foreach( i, t in this.Tree )
		{
			if (_exclude != null && _exclude.find(t.ID))
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

};

//Test

