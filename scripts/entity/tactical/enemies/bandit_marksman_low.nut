this.bandit_marksman_low <- this.inherit("scripts/entity/tactical/enemies/bandit_marksman", {
	m = {},
	function onInit()
	{
		this.bandit_marksman.onInit();
		this.m.BaseProperties.Initiative -= 10;
		this.m.BaseProperties.RangedSkill -= 10;
		this.m.Skills.update();
	}

	function pickOutfit()
	{
		local item = ::Const.World.Common.pickArmor([
			[
				20,
				"leather_wraps"
			]
		]);
		this.m.Items.equip(item);

		if (::Math.rand(0, 1) == 0)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					5,
					"headscarf"
				],
				[
					5,
					"mouth_piece"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}

	}

});

