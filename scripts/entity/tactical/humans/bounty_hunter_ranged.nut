this.bounty_hunter_ranged <- this.inherit("scripts/entity/tactical/humans/mercenary_ranged", {
	m = {},
	function create()
	{
		this.mercenary_ranged.create();
	}

	function onInit()
	{
		this.mercenary_ranged.onInit();
		this.m.BaseProperties.RangedSkill -= 10;
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
				"thick_tunic"
			],
			[
				1,
				"padded_surcoat"
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
				"ragged_surcoat"
			],
			[
				1,
				"basic_mail_shirt"
			]
		]));

		if (::Math.rand(1, 100) <= 50)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					1,
					"hood"
				],
				[
					1,
					"full_aketon_cap"
				],
				[
					1,
					"headscarf"
				],
				[
					1,
					"mouth_piece"
				],
				[
					1,
					"full_leather_cap"
				],
				[
					1,
					"aketon_cap"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}

	}

});

