this.conscript <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Conscript;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Conscript.XP;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Conscript);
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
		local banner;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = 13;
		}

		local variant;

		if (banner == 12)
		{
			variant = 9;
		}
		else if (banner == 13)
		{
			variant = 10;
		}
		else
		{
			variant = 8;
		}

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				2,
				"oriental/linothorax",
				variant
			],
			[
				1,
				"oriental/southern_mail_shirt"
			]
		]));
		local variant = 7;

		if (banner == 12)
		{
			variant = 12;
		}
		else if (banner == 13)
		{
			variant = 8;
		}
		else if (banner == 14)
		{
			variant = 7;
		}

		local helm = ::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/southern_head_wrap",
				variant
			],
			[
				1,
				"oriental/wrapped_southern_helmet"
			],
			[
				1,
				"oriental/spiked_skull_cap_with_mail"
			]
		]);
		this.m.Items.equip(helm);
	}

});

