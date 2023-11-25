this.mercenary_low <- this.inherit("scripts/entity/tactical/humans/mercenary", {
	m = {},
	function create()
	{
		this.mercenary.create();
	}

	function onInit()
	{
		this.mercenary.onInit();
		this.m.BaseProperties.MeleeSkill -= 10;
		this.m.BaseProperties.MeleeDefense -= 10;
		this.m.BaseProperties.RangedDefense -= 10;
		this.m.BaseProperties.Initiative -= 10;
		this.m.Skills.update();
	}

	function pickOutfit()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				5,
				"gambeson"
			],
			[
				2,
				"werewolf_mail_armor"
			],
			[
				1,
				"northern_mercenary_armor_00"
			],
			[
				3,
				"northern_mercenary_armor_01"
			],
			[
				3,
				"padded_surcoat"
			],
			[
				4,
				"basic_mail_shirt"
			],
			[
				4,
				"mail_shirt"
			],
			[
				4,
				"mail_hauberk"
			]
		]));

		if (this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"padded_nasal_helmet"
				],
				[
					1,
					"rondel_helm"
				],
				[
					1,
					"scale_helm"
				],
				[
					1,
					"nasal_helmet"
				],
				[
					1,
					"closed_mail_coif"
				],
				[
					1,
					"mail_coif"
				],
				[
					1,
					"headscarf"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"kettle_hat"
				],
				[
					1,
					"flat_top_helmet"
				],
				[
					1,
					"padded_flat_top_helmet"
				],
				[
					1,
					""
				]
			]));
		}

	}

});

