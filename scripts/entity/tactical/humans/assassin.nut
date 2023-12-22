this.assassin <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Assassin;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Assassin.XP;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/assassin_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Assassin);
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
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/assassin_robe"
			]
		]));
		this.m.Items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/assassin_head_wrap"
			],
			[
				1,
				"oriental/assassin_face_mask"
			]
		]));
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = ::Math.rand(1, 2);
		if (r == 1) //helmet
		{
			local armor = [
				[
					1,
					"armor/named/black_leather_armor"
				]
			];
			this.m.Items.equip(::Const.World.Common.pickArmor(armor));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

