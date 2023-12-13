this.cultist_chosen <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.CultistChosen;
		this.m.Name = "Chosen of Davkul";
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
		b.setValues(this.Const.Tactical.Actor.CultistChosen);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_orcs");
		this.m.Skills.add(this.new("scripts/skills/traits/deathwish_trait"));
		this.m.Skills.add(this.new("scripts/skills/actives/cultist_compassion_ritual"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/broken_knee_injury"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/broken_elbow_joint_injury"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/collapsed_lung_part_injury"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/weakened_heart_injury"));
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/brain_damage_injury"));

		local lucky = this.m.Skills.getSkillByID("trait.lucky")
		if (lucky == null)
		{
			lucky = ::new("scripts/skills/traits/lucky_trait");
			this.m.Skills.add(lucky);
		}
		this.getFlags().set("Lucky", 4);
		this.m.Skills.add(this.new("scripts/skills/perks/cultist_eyes_on_the_inside"));
	}

	function pickOutfit()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"coat_of_plates"
			],
			[
				1,
				"coat_of_scales"
			]
		]));

		local helmet = this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[
				30,
				"full_helm"
			],
			[
				5,
				"legend_helm_breathed"
			],
			[
				5,
				"legend_helm_full"
			],
			[
				5,
				"legend_helm_bearded"
			],
			[
				5,
				"legend_helm_point"
			],
			[
				5,
				"legend_helm_snub"
			],
			[
				5,
				"legend_helm_wings"
			],
			[
				5,
				"legend_helm_short"
			],
			[
				5,
				"legend_helm_curved"
			],
			[
				2,
				"legend_enclave_vanilla_great_helm_01"
			],
			[
				2,
				"legend_enclave_vanilla_great_bascinet_01"
			],
			[
				2,
				"legend_enclave_vanilla_great_bascinet_02"
			],
			[
				2,
				"legend_enclave_vanilla_great_bascinet_03"
			],
			[
				5,
				"legend_frogmouth_helm"
			],
			[
				1,
				"legend_frogmouth_helm_crested"
			]
		]));
		local head = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head);
		if (head != null)
			head.setUpgrade(::new("scripts/items/legend_helmets/vanity/legend_helmet_sack"));
	}

});

