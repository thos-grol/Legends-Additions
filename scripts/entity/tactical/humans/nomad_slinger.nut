this.nomad_slinger <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.NomadSlinger;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.NomadSlinger.XP;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.SouthernUntidy;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.NomadSlinger);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (::Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = ::Math.rand(150, 255);
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
				3,
				"oriental/nomad_robe"
			],
			[
				2,
				"oriental/thick_nomad_robe"
			],
			[
				3,
				"oriental/cloth_sash"
			]
		]));
		local helmet = [
			[
				3,
				"oriental/nomad_head_wrap"
			],
			[
				1,
				"citrene_nomad_cutthroat_helmet_00"
			],
			[
				1,
				"citrene_nomad_cutthroat_helmet_01"
			],
			[
				2,
				"oriental/nomad_leather_cap"
			]
		];
		this.m.Items.equip(::Const.World.Common.pickHelmet(helmet));
	}

	function assignRandomEquipment()
	{
		this.abstract_human.assignRandomEquipment();
		local weapons = [
			"weapons/knife",
			"weapons/wooden_stick"
		];
		this.m.Items.addToBag(this.new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));
	}

});

