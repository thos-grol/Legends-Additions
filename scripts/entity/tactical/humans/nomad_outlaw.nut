this.nomad_outlaw <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Name = "Outlaw";
		this.m.Type = ::Const.EntityType.NomadOutlaw;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.NomadOutlaw.XP;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.SouthernUntidy;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.NomadOutlaw);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (::Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (::Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == ::Const.EntityType.Slave && _victim.isAlliedWith(this)) return;
		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == ::Const.EntityType.Slave && _actor.isAlliedWith(this)) return;
		this.actor.onOtherActorFleeing(_actor);
	}

	function pickOutfit()
	{
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				2,
				"oriental/stitched_nomad_armor"
			],
			[
				1,
				"oriental/plated_nomad_mail"
			],
			[
				1,
				"citrene_nomad_cutthroat_armor_00"
			],
			[
				1,
				"citrene_nomad_cutthroat_armor_01"
			],
			[
				1,
				"theamson_nomad_outlaw_armor"
			],
			[
				3,
				"oriental/leather_nomad_robe"
			]
		]));
		local helmet = [
			[
				3,
				"oriental/nomad_leather_cap"
			],
			[
				2,
				"oriental/nomad_light_helmet"
			],
			[
				3,
				"citrene_nomad_cutthroat_helmet_01"
			],
			[
				1,
				"theamson_nomad_outlaw_helmet"
			],
			[
				2,
				"oriental/nomad_reinforced_helmet"
			],
			[
				1,
				"oriental/leather_head_wrap"
			]
		];
		this.m.Items.equip(::Const.World.Common.pickHelmet(helmet));
	}

});

