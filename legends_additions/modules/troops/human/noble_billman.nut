::Const.Tactical.Actor.Billman = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/noble_billman", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Billman);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 2;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
			
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		local weapons = [
			"weapons/billhook",
			"weapons/pike",
			"weapons/legend_military_voulge"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/polehammer"
			]);
		}

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"seedmaster_noble_armor"
			],
			[
				1,
				"citreneking_noble_armor"
			]
		]));

		if (this.Math.rand(1, 100) <= 33)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = this.Const.World.Common.pickHelmet([
					[
						1,
						"kettle_hat"
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
						"padded_kettle_hat"
					],
					[
						1,
						"kettle_hat_with_mail"
					],
					[
						1,
						"mail_coif"
					],
					[
						2,
						"legend_enclave_vanilla_skullcap_01"
					],
					[
						5,
						"heavy_noble_house_helmet_00"
					]
				]);
			}
			else if (banner <= 7)
			{
				helmet = this.Const.World.Common.pickHelmet([
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
						"rondel_helm"
					],
					[
						1,
						"scale_helm"
					],
					[
						1,
						"flat_top_with_mail"
					],
					[
						1,
						"mail_coif"
					],
					[
						1,
						"legend_enclave_vanilla_skullcap_01"
					],
					[
						5,
						"heavy_noble_house_helmet_00"
					]
				]);
			}
			else
			{
				helmet = this.Const.World.Common.pickHelmet([
					[
						1,
						"nasal_helmet"
					],
					[
						1,
						"padded_nasal_helmet"
					],
					[
						1,
						"nasal_helmet_with_mail"
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
						"mail_coif"
					],
					[
						2,
						"legend_enclave_vanilla_skullcap_01"
					],
					[
						5,
						"heavy_noble_house_helmet_00"
					]
				]);
			}

			if (helmet != null)
			{
				if ("setPlainVariant" in helmet)
				{
					helmet.setPlainVariant();
				}

				this.m.Items.equip(helmet);
			}
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"full_aketon_cap"
				],
				[
					2,
					"aketon_cap"
				],
				[
					1,
					""
				],
				[
					1,
					"headscarf"
				]
			]));
		}
	}

});

