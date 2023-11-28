//remove camping influence, but also nerf heal and repair
::Const.Difficulty.HealMult = [
    0.33,
    0.33,
    0.33,
    0.33,
];
::Const.Difficulty.RepairMult = [
    0.33,
    0.33,
    0.33,
    0.33,
];

::Const.World.Assets.ArmorPartsPerArmor /= 2.0;

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