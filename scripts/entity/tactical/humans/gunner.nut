this.gunner <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Gunner;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Gunner.XP;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_gunner_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Gunner);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
	}

	function onOtherActorDeath( _killer, _victim, _skill )
	{
		if (_victim.getType() == ::Const.EntityType.Slave && _victim.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorDeath(_killer, _victim, _skill);
	}

	function onOtherActorFleeing( _actor )
	{
		if (_actor.getType() == ::Const.EntityType.Slave && _actor.isAlliedWith(this))
		{
			return;
		}

		this.actor.onOtherActorFleeing(_actor);
	}

	function pickOutfit()
	{
		local r;
		local banner = 3;
		this.m.Items.addToBag(this.new("scripts/items/weapons/oriental/light_southern_mace"));

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/padded_vest"
			]
		]));
		local helm = ::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/gunner_hat"
			]
		]);
		this.m.Items.equip(helm);
	}

});

