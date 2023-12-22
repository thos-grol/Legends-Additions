this.barbarian_beastmaster <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.BarbarianBeastmaster;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BarbarianBeastmaster.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.WildMale;
		this.m.Hairs = ::Const.Hair.WildMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_beastmaster_agent");
		this.m.AIAgent.setActor(this);

		if (::Math.rand(1, 100) <= 30)
		{
			this.setGender(1);
			this.m.Faces = ::Const.Faces.WildFemale;
		}
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
		b.setValues(::Const.Tactical.Actor.BarbarianBeastmaster);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		this.m.Skills.add(this.new("scripts/skills/actives/crack_the_whip_skill"));
	}

	function pickOutfit()
	{
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"barbarians/hide_and_bone_armor"
			]
		]));
		this.m.Items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/beastmasters_headpiece"
			]
		]));
	}

});

