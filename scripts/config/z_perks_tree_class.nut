local gt = this.getroottable();

if (!("Perks" in gt.Const))
{
	gt.Const.Perks <- {};
}

gt.Const.Perks.BeastClassTree <- {
	ID = "BeastClassTree",
	Name = "Nets",
	Descriptions = [
		"catching beasts"
	],
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendNetRepair
		],
		[],
		[],
		[
			// gt.Const.Perks.PerkDefs.LegendMasteryNets
			gt.Const.Perks.PerkDefs.LegendNetCasting
		],
		[
		],
		[],
		[]
	]
};
gt.Const.Perks.BardClassTree <- {
	ID = "BardClassTree",
	Name = "Bard",
	Descriptions = [
		"entertaining"
	],
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
gt.Const.Perks.HealerClassTree <- {
	ID = "HealerClassTree",
	Name = "Healing",
	Descriptions = [
		"healing"
	],
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
gt.Const.Perks.FaithClassTree <- {
	ID = "FaithClassTree",
	Name = "Faith",
	Descriptions = [
		"faith"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[
			// gt.Const.Perks.PerkDefs.LegendPrayerOfFaith
		],
		[
			// gt.Const.Perks.PerkDefs.LegendPrayerOfLife
		],
		[
			// gt.Const.Perks.PerkDefs.LegendHolyFlame
		]
	]
};
gt.Const.Perks.FistsClassTree <- {
	ID = "FistsClassTree",
	Name = "Basics",
	Descriptions = [
		"basics"
	],
	Tree = [
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendAmbidextrous
		],
		[
			gt.Const.Perks.PerkDefs.LegendSpecFists,
			gt.Const.Perks.PerkDefs.LegendKnifeplay
		],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.StanceAsura
		]
	]
};
gt.Const.Perks.ChefClassTree <- {
	ID = "ChefClassTree",
	Name = "Chef",
	Descriptions = [
		"cooking"
	],
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
gt.Const.Perks.RepairClassTree <- {
	ID = "RepairClassTree",
	Name = "Repair",
	Descriptions = [
		"repairs"
	],
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
gt.Const.Perks.BarterClassTree <- {
	ID = "BarterClassTree",
	Name = "Barter",
	Descriptions = [
		"bartering"
	],
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
gt.Const.Perks.KnifeClassTree <- {
	ID = "KnifeClassTree",
	Name = "Knives",
	Descriptions = [
		"knives"
	],
	Tree = [
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendAssassinate
		],
		[],
		[],
		[]
	]
};
gt.Const.Perks.ButcherClassTree <- {
	ID = "ButcherClassTree",
	Name = "Butcher",
	Descriptions = [
		"butchery"
	],
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
gt.Const.Perks.HammerClassTree <- {
	ID = "HammerClassTree",
	Name = "Blacksmith",
	Descriptions = [
		"hammers"
	],
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
gt.Const.Perks.MilitiaClassTree <- {
	ID = "MilitiaClassTree",
	Name = "Militia",
	Descriptions = [
		"militia"
	],
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
gt.Const.Perks.PickaxeClassTree <- {
	ID = "PickaxeClassTree",
	Name = "Miner",
	Descriptions = [
		"pickaxes"
	],
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
gt.Const.Perks.PitchforkClassTree <- {
	ID = "PitchforkClassTree",
	Name = "Farmer",
	Descriptions = [
		"pitchforks"
	],
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
gt.Const.Perks.ShortbowClassTree <- {
	ID = "ShortbowClassTree",
	Name = "Shortbow",
	Descriptions = [
		"shortbows"
	],
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
gt.Const.Perks.ShovelClassTree <- {
	ID = "ShovelClassTree",
	Name = "Gravedigger",
	Descriptions = [
		"shovels"
	],
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
gt.Const.Perks.WoodaxeClassTree <- {
	ID = "WoodaxeClassTree",
	Name = "Lumberjack",
	Descriptions = [
		"axes"
	],
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
gt.Const.Perks.SickleClassTree <- {
	ID = "SickleClassTree",
	Name = "Sickle",
	Descriptions = [
		"sickles"
	],
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
gt.Const.Perks.NinetailsClassTree <- {
	ID = "NinetailsClassTree",
	Name = "Cat O\' Nine Tails",
	Descriptions = [
		"ninetails"
	],
	Tree = [
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSpecCultHood
		],
		[],
		[],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSpecCultArmor
		],
		[]
	]
};
gt.Const.Perks.JugglerClassTree <- {
	ID = "JugglerClassTree",
	Name = "Juggler",
	Descriptions = [
		"acrobatics"
	],
	Tree = [
		[],
		[],
		[],
		[],
		[],
		[],
		[],
	]
};
gt.Const.Perks.HoundmasterClassTree <- {
	ID = "HoundmasterClassTree",
	Name = "Hound Master",
	Descriptions = [
		"training dogs"
	],
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
gt.Const.Perks.ScytheClassTree <- {
	ID = "ScytheClassTree",
	Name = "Scythe",
	Descriptions = [
		"scythes"
	],
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
gt.Const.Perks.ClassTrees <- {
	Tree = [
		gt.Const.Perks.BeastClassTree,
		gt.Const.Perks.BardClassTree,
		gt.Const.Perks.HealerClassTree,
		gt.Const.Perks.FaithClassTree,
		gt.Const.Perks.FistsClassTree,
		gt.Const.Perks.ChefClassTree,
		gt.Const.Perks.RepairClassTree,
		gt.Const.Perks.BarterClassTree,
		gt.Const.Perks.KnifeClassTree,
		gt.Const.Perks.ButcherClassTree,
		gt.Const.Perks.HammerClassTree,
		gt.Const.Perks.MilitiaClassTree,
		gt.Const.Perks.PickaxeClassTree,
		gt.Const.Perks.PitchforkClassTree,
		gt.Const.Perks.ShortbowClassTree,
		gt.Const.Perks.WoodaxeClassTree,
		gt.Const.Perks.SickleClassTree,
		gt.Const.Perks.NinetailsClassTree,
		gt.Const.Perks.JugglerClassTree,
		gt.Const.Perks.HoundmasterClassTree,
		gt.Const.Perks.ScytheClassTree
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

};

