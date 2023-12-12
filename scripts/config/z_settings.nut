//remove camping influence, but also nerf heal and repair

::Const.AI.ParallelizationMode = false;
::Const.Difficulty.HealMult = [
    0.75,
    0.75,
    0.75,
    0.75,
];
::Const.Difficulty.RepairMult = [
    0.75,
    0.75,
    0.75,
    0.75,
];

::Const.Contracts.CategoryLimits <- {
	Economy = [
		1,
		1,
		1
	],
	Battle = [
		2,
		2,
		2
	],
	Hunt = [
		1,
		1,
		1
	],
	Legendary = [
		1,
		1,
		1
	],
	Wildcard = [
		1,
		2,
		3
	]
};

::Const.Contracts.ScrollOptions <- [
	::Const.Perks.AgileTree.ID,
	::Const.Perks.IndestructibleTree.ID,
	::Const.Perks.ViciousTree.ID,
	::Const.Perks.DeviousTree.ID,
	::Const.Perks.InspirationalTree.ID,
	::Const.Perks.CalmTree.ID,
	::Const.Perks.FastTree.ID,
	::Const.Perks.LargeTree.ID,
	::Const.Perks.SturdyTree.ID,
	::Const.Perks.FitTree.ID,
];