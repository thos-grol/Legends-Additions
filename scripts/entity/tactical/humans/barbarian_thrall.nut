this.barbarian_thrall <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.BarbarianThrall;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BarbarianThrall.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.WildMale;
		this.m.Hairs = ::Const.Hair.WildMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.WildExtended;

		if (::Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = ::Const.Faces.WildFemale;
		}

		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local tattoos = [
			2,
			3
		];

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("warpaint_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("warpaint_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BarbarianThrall);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
	}

	function pickOutfit()
	{
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"barbarians/thick_furs_armor"
			],
			[
				1,
				"barbarians/animal_hide_armor"
			]
		]));
		local item = ::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/bear_headpiece"
			],
			[
				2,
				""
			]
		]);
		if (item != null) this.m.Items.equip(item);
	}

});

