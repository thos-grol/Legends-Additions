local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

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
			gt.Const.Perks.PerkDefs.LegendOnslaught
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecMace
		],
		[],
		[
			gt.Const.Perks.PerkDefs.ReturnFavor
		],
		[]
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
		[],
		[
			gt.Const.Perks.PerkDefs.SpecFlail
		],
		[],
		[
			gt.Const.Perks.PerkDefs.HeadHunter
		],
		[
			gt.Const.Perks.PerkDefs.BattleFlow
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
		[
			gt.Const.Perks.PerkDefs.LegendSmackdown
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecHammer
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SunderingStrikes
		],
		[]
	]
};
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
		[
			gt.Const.Perks.PerkDefs.LegendSmashingShields
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecAxe
		],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.KillingFrenzy
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
		[],
		[
			gt.Const.Perks.PerkDefs.SpecCleaver
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendBloodbath
		],
		[
			gt.Const.Perks.PerkDefs.Fearsome
		]
	]
};
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
		[
			gt.Const.Perks.PerkDefs.BloodyHarvest
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSpecGreatSword
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendForcefulSwing
		],
		[]
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
			gt.Const.Perks.PerkDefs.Feint
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecSword
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist
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
		[
			gt.Const.Perks.PerkDefs.Backstabber
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecDagger
		],
		[
			gt.Const.Perks.PerkDefs.DoubleStrike
		],
		[],
		[]
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
		[
			gt.Const.Perks.PerkDefs.CoupDeGrace
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecPolearm
		],
		[
			gt.Const.Perks.PerkDefs.ReachAdvantage
		],
		[],
		[]
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
			gt.Const.Perks.PerkDefs.LegendSpecSpearWall
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecSpear
		],
		[
			gt.Const.Perks.PerkDefs.LegendSpecSpearThrust
		],
		[],
		[]
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
		[],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.PushTheAdvantage
		]
	]
};
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
		[
			gt.Const.Perks.PerkDefs.LegendSpecialistShieldPush
		],
		[
			gt.Const.Perks.PerkDefs.ShieldExpert
		],
		[
			gt.Const.Perks.PerkDefs.LegendSpecialistShieldSkill
		],
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

