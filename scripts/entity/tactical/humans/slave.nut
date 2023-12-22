this.slave <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Slave;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Slave.XP;
		this.abstract_human.create();

		if (::Math.rand(1, 100) <= 90)
		{
			this.m.Bodies = ::Const.Bodies.SouthernSlave;
			this.m.Faces = ::Const.Faces.SouthernMale;
			this.m.Hairs = ::Const.Hair.SouthernMale;
			this.m.HairColors = ::Const.HairColors.Southern;
			this.m.Beards = ::Const.Beards.SouthernUntidy;
			this.m.BeardChance = 90;
			this.m.Ethnicity = 1;
		}
		else
		{
			this.m.Bodies = ::Const.Bodies.NorthernSlave;
			this.m.Faces = ::Const.Faces.AllMale;
			this.m.Hairs = ::Const.Hair.WildMale;
			this.m.HairColors = ::Const.HairColors.All;
			this.m.Beards = ::Const.Beards.Untidy;
		}

		this.m.Body = ::Math.rand(0, this.m.Bodies.len() - 1);
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Slave);
		b.TargetAttractionMult = 0.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");

		if (::Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("bust_head_darkeyes_01");
			tattoo_head.Visible = true;
		}
		else
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}

		if (::Math.rand(1, 100) <= 75)
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (::Math.rand(1, 100) <= 75)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.m.Ethnicity == 0)
		{
			local body = this.getSprite("body");
			body.Color = this.createColor("#ffeaea");
			body.varyColor(0.05, 0.05, 0.05);
			local head = this.getSprite("head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
	}

	function pickOutfit()
	{
		if (::Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[
					2,
					"sackcloth"
				],
				[
					1,
					"indebted_armor_rags"
				],
				[
					2,
					"tattered_sackcloth"
				]
			]));
		}

		local helmet = [
			[
				1,
				"oriental/southern_head_wrap"
			],
			[
				2,
				""
			]
		];
		this.m.Items.equip(::Const.World.Common.pickHelmet(helmet));
	}

});

