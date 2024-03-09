this.bounty_hunter <- this.inherit("scripts/entity/tactical/humans/mercenary", {
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
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"leather_lamellar"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"mail_hauberk"
			]
		]));

		if (::Math.rand(1, 100) <= 90)
		{
			local helm = [
				[
					1,
					"nasal_helmet"
				],
				[
					1,
					"nasal_helmet_with_mail"
				],
				[
					1,
					"reinforced_mail_coif"
				],
				[
					1,
					"headscarf"
				],
				[
					1,
					"kettle_hat"
				],
				[
					1,
					"kettle_hat_with_mail"
				],
				[
					1,
					"nordic_helmet"
				],
				[
					1,
					"nordic_helmet_with_closed_mail"
				],
				[
					1,
					"barbute_helmet"
				]
			];
			helm.push([
				1,
				"theamson_barbute_helmet"
			]);
			local item = ::Const.World.Common.pickHelmet(helm);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

});



