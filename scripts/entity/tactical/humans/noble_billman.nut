this.noble_billman <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Billman;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Billman.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Billman);
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

		if (::Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"seedmaster_noble_armor"
			],
			[
				1,
				"citreneking_noble_armor"
			]
		]));

		if (::Math.rand(1, 100) <= 33)
		{
			local helmet;

			if (banner <= 4)
			{
				helmet = ::Const.World.Common.pickHelmet([
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
				helmet = ::Const.World.Common.pickHelmet([
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
				helmet = ::Const.World.Common.pickHelmet([
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
			this.m.Items.equip(::Const.World.Common.pickHelmet([
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

