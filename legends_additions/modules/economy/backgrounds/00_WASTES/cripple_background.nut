//Cripple background - starts with daytaler stats and a permanent injury
//permenant injuries encourage the cultist playstyle - especially brain damage
//cripple backgrounds cannot get many traits that improve the body,
//making it more likely they can get bright traits - bright can become mages
//they cannot be lucky, because it's hard for the lucky to become crippled

::mods_hookExactClass("skills/backgrounds/cripple_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree
			],
			Defense = [],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};

		this.m.Excluded = [
			"trait.tough",
			"trait.strong",
			"trait.quick",
			"trait.cocky",
			"trait.fat",
			"trait.dexterous",
			"trait.sure_footing",
			"trait.iron_lungs",
			"trait.greedy",
			"trait.athletic",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.iron_jaw",
			"trait.swift",
			"trait.huge",
			"trait.lucky",
			"trait.steady_hands",
			"trait.aggressive",
			"trait.sureshot"
		];
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			]
		]));
		local helm = ::Const.World.Common.pickHelmet([
			[
				1,
				"hood",
				38
			],
			[
				3,
				""
			]
		]);
		items.equip(helm);

		this.m.Container.add(::new(::MSU.Array.rand(::Const.Injury.Permanent).Script));


	}

	//Use daytaler stat rolls
	o.onChangeAttributes = function()
	{
		local c = {
			Hitpoints = [
				4,
				8
			],
			Bravery = [
				-2,
				-3
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				0,
				2
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
		return c;
	}

});
