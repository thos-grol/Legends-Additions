this.bandit_raider_low <- this.inherit("scripts/entity/tactical/enemies/bandit_raider", {
	m = {},
	function create()
	{
		this.bandit_raider.create();
	}

	function onInit()
	{
		this.bandit_raider.onInit();
		this.m.BaseProperties.MeleeSkill -= 10;
		this.m.BaseProperties.MeleeDefense -= 5;
		this.m.BaseProperties.RangedDefense -= 5;
		this.m.Skills.update();
	}

	function pickOutfit()
	{
		local item = ::Const.World.Common.pickArmor([
			[
				10,
				"bandit_armor_light"
			],
			[
				20,
				"ragged_surcoat"
			],
			[
				20,
				"padded_leather"
			],
			[
				15,
				"worn_mail_shirt"
			],
			[
				15,
				"leather_lamellar"
			],
			[
				20,
				"patched_mail_shirt"
			]
		]);
		this.m.Items.equip(item);

		if (::Math.rand(1, 100) <= 75)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					1,
					"nasal_helmet"
				],
				[
					1,
					"dented_nasal_helmet"
				],
				[
					1,
					"rusty_mail_coif"
				],
				[
					1,
					"headscarf"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

});

