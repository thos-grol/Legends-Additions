this.cultist <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Cultist;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Cultist.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.AllMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);

		if (::Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
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
		b.setValues(::Const.Tactical.Actor.Cultist);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_orcs");
		this.m.Skills.add(this.new("scripts/skills/traits/deathwish_trait"));
		if (::Math.rand(1,100) <= 25) this.m.Skills.add(this.new("scripts/skills/actives/cultist_pain_ritual"));
		if (::Math.rand(1,100) <= 50) this.m.Skills.add(this.new("scripts/skills/injury_permanent/missing_eye_injury"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/brain_damage_injury"));
	}

	function post_init()
	{
		if (::Math.rand(1, 100) <= 25)
		{
			local body = this.m.Items.getItemAtSlot(::Const.ItemSlot.Body);
			if (body != null)
				body.setUpgrade(::new("scripts/items/legend_armor/plate/legend_armor_cult_armor"));
		}

		local head = this.m.Items.getItemAtSlot(::Const.ItemSlot.Head);
		if (head != null)
			head.setUpgrade(::new("scripts/items/legend_helmets/vanity/legend_helmet_sack"));
		else
		{
			local helmet = ::new("scripts/items/legend_helmets/hood/legend_helmet_leather_hood");
			this.m.Items.equip(helmet);
		}




	}

});

