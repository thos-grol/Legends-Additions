this.cultist_priest <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.CultistPriest;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Cultist.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);

		if (this.Math.rand(1, 100) <= 10)
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

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("warpaint_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("warpaint_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.CultistPriest);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_orcs");
		this.m.Skills.add(this.new("scripts/skills/traits/deathwish_trait"));
		local lucky = this.m.Skills.getSkillByID("trait.lucky")
		if (lucky == null)
		{
			lucky = ::new("scripts/skills/traits/lucky_trait");
			this.m.Skills.add(lucky);
		}
		this.getFlags().set("Lucky", 3);
		this.getFlags().set("AgonizingBlast", true);
		this.getFlags().set("InstinctiveBlast", true);
		this.m.Skills.add(this.new("scripts/skills/perks/cultist_eyes_on_the_inside"));
		this.m.Skills.add(this.new("scripts/skills/actives/cultist_eldritch_blast"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/missing_finger_injury"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/missing_eye_injury"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/brain_damage_injury"));
	}

	function pickOutfit()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				3,
				"cultist_leather_armor"
			],
			[
				2,
				"barbarians/animal_hide_armor"
			],
			[
				1,
				"barbarians/hide_and_bone_armor"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				2,
				"cultist_hood"
			],
			[
				1,
				"cultist_leather_hood"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

