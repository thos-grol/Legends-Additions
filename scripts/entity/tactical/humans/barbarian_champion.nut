this.barbarian_champion <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.BarbarianChampion;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BarbarianChampion.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.WildMale;
		this.m.Hairs = ::Const.Hair.WildMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (::Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BarbarianChampion);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
	}

	function pickOutfit()
	{
		local armor = [
			[
				33,
				"barbarians/rugged_scale_armor"
			],
			[
				34,
				"barbarians/heavy_iron_armor"
			],
			[
				33,
				"barbarians/thick_plated_barbarian_armor"
			]
		];
		armor.push([
			5,
			"barbarians/reinforced_heavy_iron_armor"
		]);
		this.m.Items.equip(::Const.World.Common.pickArmor(armor));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::Const.World.Common.pickHelmet([
				[
					1,
					"barbarians/crude_faceguard_helmet"
				],
				[
					1,
					"barbarians/closed_scrap_metal_helmet"
				],
				[
					1,
					"barbarians/crude_metal_helmet"
				]
			]));
		}
	}

	function pickNamed()
	{
		local r = ::Math.rand(1, 3);
		if (r == 1) this.m.IsMinibossWeapon <- true;
		else if (r == 2)
		{
			local weightName = ::Const.World.Common.convNameToList(::Const.Items.NamedBarbarianArmors);
			this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
		}
		else
		{
			local weightName = ::Const.World.Common.convNameToList(::Const.Items.NamedBarbarianHelmets);
			this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
		}

	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

