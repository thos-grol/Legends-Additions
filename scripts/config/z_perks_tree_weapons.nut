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
			gt.Const.Perks.PerkDefs.Dismemberment
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
	Name = "Sword",
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
		[],
		[
			gt.Const.Perks.PerkDefs.Quickstep
		],
		[
			gt.Const.Perks.PerkDefs.SpecSword,
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage,

		],
		[
			gt.Const.Perks.PerkDefs.StanceTheStrongest,
			gt.Const.Perks.PerkDefs.StanceWrath,
		]
	]
};

gt.Const.Perks.MaceTree <- {
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
			gt.Const.Perks.PerkDefs.DeepImpact
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecMace
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage

		],
		[
			gt.Const.Perks.PerkDefs.StanceBoneBreaker
		]
	]
};

gt.Const.Perks.HammerTree <- {
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
		[],
		[
			gt.Const.Perks.PerkDefs.Rattle
		],
		[
			gt.Const.Perks.PerkDefs.SpecHammer
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage,
		],
		[
			gt.Const.Perks.PerkDefs.StanceSeismicSlam,
		]
	]
};

gt.Const.Perks.FlailTree <- {
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
		[
			//TODO: "Strange Strikes
			// Gain 10 melee skill. Does not trigger riposte
		],
		[
			gt.Const.Perks.PerkDefs.SpecFlail //TODO: spec flail
			//"Flail Proficiency
			// Attacks with flails have a 75% chance to do a free extra attack.

			// "
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage,

		],
		[
			//TODO: Prisoner's Stance (requires Flail)
			// Until your next turn any opponent who misses an attack against you in melee has a chance equal to the miss chance to be Disarmed. The effect expires after your next attack.
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
		[],
		[
			//TODO: "Intimidate
			// Attacks reduce the Resolve and damage of the target by 10% of your Melee Skill."
		],
		[
			gt.Const.Perks.PerkDefs.SpecSpear
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist
		],
		[
			//TODO: Sovereign (Spear only)
			// On turn end, attack all surrounding enemies
		]
	]
};

gt.Const.Perks.PolearmTree <- {
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
		[
			//TODO: // "Poke Poke
			//Decrease the AP cost of spear and polearm attacks by 1.
		],
		[
			gt.Const.Perks.PerkDefs.SpecPolearm //TODO: followup + followup AI
		],
		[],
		[
			gt.Const.Perks.PerkDefs.ReachAdvantage
		],
		[
			//TODO: stance polearm use followup for free upon ending turn
		]
	]
};

///////////////////////////////////////////////////////////////////////////
// Special - Melee
///////////////////////////////////////////////////////////////////////////

gt.Const.Perks.ShieldTree <- {
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
			gt.Const.Perks.PerkDefs.ShieldBash
		],
		[],
		[
			gt.Const.Perks.PerkDefs.ShieldExpert
		],
		[],
		[],
		[]
	]
};

/////////////////////////////////////////////////////////////////////////////////////////////
// Ranged
/////////////////////////////////////////////////////////////////////////////////////////////

gt.Const.Perks.BowTree <- { //TODO: plan ranged weaponry tree
	ID = "Bow",
	Name = "Ranged",
	Descriptions = [
		"ranged"
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
		[],
		[
			//TODO: 2 ranged free perks
			//gt.Const.Perks.PerkDefs.Ballistics combine
			//Scavenger //TODO: pick up ammo from corpses
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecBow //TODO specbow
			//gt.Const.Perks.PerkDefs.Bullseye
			//ballistics
		],
		[],
		[],
		[
			//TODO: Divine Hands
			//Reduce the ap cost of any ranged weapon skill to 3. Does not apply to sling heavy stones.

			//TODO: Divine Eyes
			//Ranged attacks gain X armor piercing
			//If ranged skill is below 120, +10 ranged skill

			//TODO: David
			//Improve sling skills somehow

		]
	]
};

/////////////////////////////////////////////////////////////////////////////////////////////
// Disabled
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
gt.Const.Perks.DaggerTree <- {
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
		[],
		[],
		[],
		[],
		[],
		[]
	]
};
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

gt.Const.Perks.CrossbowTree <- {
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

