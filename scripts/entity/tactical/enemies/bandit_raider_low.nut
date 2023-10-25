this.bandit_raider_low <- this.inherit("scripts/entity/tactical/enemies/bandit_raider", {
	m = {},
	function create()
	{
		this.bandit_raider.create();
	}

	function onInit()
	{
		this.bandit_raider.onInit();
		this.m.BaseProperties.MeleeSkill -= 5;
		this.m.BaseProperties.MeleeDefense -= 5;
		this.m.BaseProperties.RangedDefense -= 5;
		this.m.Skills.update();
	}

	function pickOffhand()
	{
		if (::Math.rand(1, 100) > 15) return;

		this.m.PATTERN_OVERWRITE <- {};

		if (::Math.rand(1, 100) <= 80) //Sheild users
		{
			// ["T", 1],
			// ["D", 2],
			// ["W", 3], <- 3: ["Z", "scripts/skills/perks/perk_shield_bash"]
			// ["W", 4],
			// ["T", 5],
			// ["D", 6],
			// ["T", 3], <- 7: ["Z", "scripts/skills/perks/perk_shield_expert"]
			this.m.PATTERN_OVERWRITE[3] <- ["Z", "scripts/skills/perks/perk_shield_bash"];
			this.m.PATTERN_OVERWRITE[7] <- ["Z", "scripts/skills/perks/perk_shield_expert"];
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else //nets
		{
			// ["T", 1],
			// ["D", 2],
			// ["W", 3], <- 3: ["Z", "scripts/skills/perks/perk_shield_bash"]
			// ["W", 4],
			// ["T", 5],
			// ["D", 6],
			// ["T", 3], <- 7: ["Z", "scripts/skills/perks/perk_shield_expert"]
			this.m.PATTERN_OVERWRITE[3] <- ["Z", "scripts/skills/perks/perk_legend_net_repair"];
			this.m.PATTERN_OVERWRITE[7] <- ["Z", "scripts/skills/perks/perk_legend_net_casting"];
			//net perk autoloads nets
		}
	}

	function pickOutfit()
	{
		local item = this.Const.World.Common.pickArmor([
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

		if (this.Math.rand(1, 100) <= 75)
		{
			local item = this.Const.World.Common.pickHelmet([
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

	function pickWeapon()
	{
		local Loadout = [
			[
				"scripts/items/weapons/woodcutters_axe",
			],
			[
				"scripts/items/weapons/hooked_blade",
			],
			[
				"scripts/items/weapons/pike",
			],
			[
				"scripts/items/weapons/two_handed_wooden_hammer",
			],
			[
				"scripts/items/weapons/two_handed_mace",
			],
			[
				"scripts/items/weapons/legend_two_handed_club",
			],
			[
				"scripts/items/weapons/boar_spear",
			],
			[
				"scripts/items/weapons/morning_star",
			],
			[
				"scripts/items/weapons/falchion",
			],
			[
				"scripts/items/weapons/flail",
			],
			[
				"scripts/items/weapons/hand_axe",
			],
		];

	}

});

