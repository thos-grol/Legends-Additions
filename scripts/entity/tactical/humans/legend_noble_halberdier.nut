this.legend_noble_halberdier <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendHalberdier;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendHalberdier.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendHalberdier);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
	}

	function pickOutfit()
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

		if (this.Math.rand(1, 100) <= 90)
		{
			local helmet;

			if (banner <= 4)
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
						"flat_top_with_mail"
					],
					[
						1,
						"mail_coif"
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
						"legend_enclave_vanilla_kettle_sallet_01"
					],
					[
						1,
						"legend_enclave_vanilla_kettle_sallet_03"
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
						"flat_top_with_mail"
					],
					[
						1,
						"mail_coif"
					],
					[
						1,
						"legend_enclave_vanilla_kettle_sallet_02"
					],
					[
						1,
						"legend_enclave_vanilla_kettle_sallet_03"
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
						"mail_coif"
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
						"legend_enclave_vanilla_kettle_sallet_01"
					],
					[
						1,
						"legend_enclave_vanilla_kettle_sallet_02"
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
					2,
					"aketon_cap"
				],
				[
					1,
					"full_aketon_cap"
				]
			]));
		}
	}

});

