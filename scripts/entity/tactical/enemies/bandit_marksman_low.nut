this.bandit_marksman_low <- this.inherit("scripts/entity/tactical/enemies/bandit_marksman", {
	m = {},
	function create()
	{
		this.bandit_marksman.create();
		this.m.IsLow = true;
	}

	function onInit()
	{
		this.bandit_marksman.onInit();
		this.m.BaseProperties.Initiative -= 10;
		this.m.BaseProperties.RangedSkill -= 10;
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local weapons = [
			[
				"weapons/short_bow",
				"ammo/quiver_of_arrows"
			],
			[
				"weapons/short_bow",
				"ammo/quiver_of_arrows"
			],
			[
				"weapons/light_crossbow",
				"ammo/quiver_of_bolts"
			]
		];
		local n = this.Math.rand(0, weapons.len() - 1);

		foreach( w in weapons[n] )
		{
			this.m.Items.equip(this.new("scripts/items/" + w));
		}

		this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
		local item = this.Const.World.Common.pickArmor([
			[
				20,
				"leather_wraps"
			]
		]);
		this.m.Items.equip(item);

		if (this.Math.rand(0, 1) == 0)
		{
			local item = this.Const.World.Common.pickHelmet([
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

