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
		[],
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
			//TODO: axe stance: Executioner
			// +50 Headshot chance
			// Cull now triggers at 44% HP
			// If enemy is immune to cull, increase damage by X%

			//TODO: axe stance
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
			//TODO: cleaver stance: Gourmet
			//Prepare the meat...
			// + "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "[u]Improves Weakness:[/u] (Duration: 3)")
			// + "\n " + ::MSU.Text.color(::Z.Log.Color.BloodRed, "-10X% damage. X is the number of bleed stacks. Caps at 75%")

			//TODO: cleaver stance: Skull Collector
			//Skulls for the skull throne
			//Decapitate has a chance to detonate blood stacks. This chance increases with the number of blood stacks.
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
			gt.Const.Perks.PerkDefs.Feint //TODO: replace with Kata
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecSword,
			gt.Const.Perks.PerkDefs.LegendSpecGreatSword //TODO: update 5% -> 15% chance to hit
			// LegendSpecGreatSword = "Master the art of fighting with a large unwieldy sword. Skills build up [color=" + this.Const.UI.Color.NegativeValue + "]25%[/color] less Fatigue.\n\nSplit, Swing, Overhead Strike, Great Lunge and Great Slash gain [color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit.",
			// "There\'s wolves, bears, nachzehrers and you. All beings of vicious slaughter.\n\nGain [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] chance to hit for all Melee area of effect attacks.",
			//gt.Const.Perks.PerkDefs.BloodyHarvest
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

			//TODO: rework stagger? reduces defenses. Grapple applies stagger.
		]
	]
};

gt.Const.Perks.MaceTree <- { //TODO: tree mace
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
			//TODO: stances
		]
	]
};

gt.Const.Perks.HammerTree <- { //TODO: tree hammer
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
			//TODO: stances
		]
	]
};

gt.Const.Perks.FlailTree <- { //TODO: tree flail
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
			//TODO: stances
		]
	]
};

gt.Const.Perks.SpearTree <- { //TODO: tree spear
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
			gt.Const.Perks.PerkDefs.LegendSpecSpearWall
			gt.Const.Perks.PerkDefs.LegendSpecSpearThrust
			//TODO: Merge

			// "Two for One (requires Spear)
			// When using a Spear, the action post cost of Thrust, Glaive Slash and Prong is reduced by 1. When using a 1h Spear with offhand free, the range of Thrust is increased to 2 tiles. When used at this range, it does 20% reduced Damage, has no bonus Chance-to-Hit, and has -20% Chance-to-Hit per character between you and the target."

			// "King of all Weapons (requires Spear)
			// When using a Spear, the first Thrust or Prong during your turn costs 0 Action Points, builds 0 Fatigue, but does -25% Damage."
		],
		[

		],
		[
			gt.Const.Perks.PerkDefs.Duelist,
			gt.Const.Perks.PerkDefs.ReachAdvantage
		],
		[
			// 			"Spear Advantage (requires Spear)
			//  When using a Spear, every successful hit against an opponent increases your Melee Skill and Melee Defense against that opponent by +5 up to a maximum of +20. This bonus does not expire on its own but is lost upon taking Damage from that opponent."
		]
	]
};

gt.Const.Perks.PolearmTree <- { //TODO: tree polearm
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

gt.Const.Perks.DaggerTree <- { //TODO: tree dagger
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
		],
		[],
		[
			gt.Const.Perks.PerkDefs.SpecDagger
		],
		[],
		[
			gt.Const.Perks.PerkDefs.Duelist
		],
		[]
	]
};

gt.Const.Perks.ShieldTree <- { //TODO: tree shield
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
			gt.Const.Perks.PerkDefs.ShieldExpert
			//gt.Const.Perks.PerkDefs.LegendSpecialistShieldPush //TODO merge
			//gt.Const.Perks.PerkDefs.ShieldBash //TODO: rework and merge, knockback, + chance to hit
		],
		[
			gt.Const.Perks.PerkDefs.LegendSpecialistShieldSkill
			//TODO: replace with rebuke
		],
		[],
		[]
	]
};

// "Rebuke
// Gain a 25% chance to perform a free attack against an adjacent opponent who misses a melee attack against you. The chance is increased by an additional +10% when equipped with a shield."
//Rework, to while weilding shield

/////////////////////////////////////////////////////////////////////////////////////////////
// Ranged
/////////////////////////////////////////////////////////////////////////////////////////////
gt.Const.Perks.GreatSwordTree <- { //TODO: tree firearm
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

gt.Const.Perks.CrossbowTree <- { //TODO: tree crossbow
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

gt.Const.Perks.BowTree <- { //TODO: tree bow
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

gt.Const.Perks.SlingTree <- { //TODO: tree sling
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

