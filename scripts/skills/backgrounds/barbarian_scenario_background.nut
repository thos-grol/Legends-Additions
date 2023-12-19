this.barbarian_scenario_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin;
		this.character_background.create();
		this.m.ID = "background.barbarian";
		this.m.Name = "Barbarian";
		this.m.Icon = "ui/backgrounds/background_58.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the barbarian took all the coin he earned with the company and ventured north. With his money, he gathered a band of warriors and conquered so many tribes that, last you heard, he had been ordained \'king of the north\'.";
		this.m.BadEnding = "With things the way they were, %name% departed. Last you heard he was traveling north. Penniless with little to his name but an axe, and not looking anything like the natives or speaking their tongue, you figure the barbarian did not get far. Based upon what you\'ve seen happen to his ilk, he\'s either been killed already or captured as a slave.";
		this.m.HiringCost = 24;
		this.m.DailyCost = 12;
		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_undead",

			"trait.fear_beasts",
			"trait.fear_nobles",
			"trait.fear_undead",
			"trait.fear_greenskins",

			"trait.greedy",
			"trait.gluttonous",
			"trait.superstitious",
			"trait.paranoid",
			"trait.aggressive",
			"trait.dumb",
			"trait.cocky",
			"trait.pragmatic",
			"trait.disloyal",
			"trait.double_tongued",

			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure",
			"trait.slack",
			"trait.frail",
			"trait.gift_of_people",
			"trait.seductive"
		];
		this.m.Titles = this.Const.Strings.BarbarianTitles;
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.Ethnicity = 0;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Druid | this.Const.BackgroundType.ExpertHunter;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Terrain = [
			0.0,
			0.0,
			0.0,
			0.0,
			0.0,
			0.05,
			0.05,
			0.01,
			0.01,
			0.0,
			0.0,
			0.0,
			0.05,
			0.0,
			0.05,
			0.0,
			0.0,
			0.0,
			0.0
		];

		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.AxeTree,
				::Const.Perks.HammerTree,
				::Const.Perks.ShieldTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.FastTree,
				::Const.Perks.TrainedTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

	function setGender( _gender = -1 )
	{
		if (_gender == -1)
		{
			_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);
		}

		if (_gender != 1)
		{
			return;
		}

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "%name% the barbarian took all the coin she earned with the company and ventured north. With her money, she gathered a band of warriors and conquered so many tribes that, last you heard, she had been ordained \'queen of the north\'.";
		this.m.BadEnding = "With things the way they were, %name% departed. Last you heard she was traveling north. Penniless with little to her name but an axe, and not looking anything like the natives or speaking their tongue, you figure the barbarian did not get far. Based upon what you\'ve seen happen to her ilk, she\'s either been killed already or captured as a slave.";
	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name% survived the battle between yourself and her own tribe of warriors. She offered herself to your company or to your sword. Impressed by his bravery, you chose to take her in. A foreign brute, she hardly speaks your native tongue and she is not well liked by the rest of the company. But if anything can bond two people it is fighting beside one another, killing when it counts, and drinking the night away at the tavern.}";
		}
		else
		{
			return "{%name% survived the battle between yourself and his own tribe of warriors. He offered himself to your company or to your sword. Impressed by his bravery, you chose to take him in. A foreign brute, he hardly speaks your native tongue and he is not well liked by the rest of the company. But if anything can bond two men it is fighting beside one another, killing when it counts, and drinking the night away at the tavern.}";
		}
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Tattoo = tattoos[this.Math.rand(0, tattoos.len() - 1)];
			local tattoo_body = actor.getSprite("tattoo_body");
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_head = actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				15,
				20
			],
			Bravery = [
				20,
				25
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				10,
				5
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
				5,
				10
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(::new("scripts/items/weapons/barbarians/crude_axe"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"barbarians/thick_furs_armor"
			],
			[
				1,
				"barbarians/reinforced_animal_hide_armor"
			],
			[
				1,
				"barbarians/hide_and_bone_armor"
			],
			[
				1,
				"barbarians/scrap_metal_armor"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/bear_headpiece"
			],
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/leather_helmet"
			]
		]));
	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});

