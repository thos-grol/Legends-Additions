this.noble_footman <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Footman;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Footman.XP;
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
		b.setValues(::Const.Tactical.Actor.Footman);
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
		if (!this.Tactical.State.isScenarioMode()) banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		else banner = this.getFaction();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= 90) this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		r = ::Math.rand(1, 2);
		local shield;
		shield = this.new("scripts/items/shields/faction_heater_shield");
		shield.setFaction(banner);
		this.m.Items.equip(shield);

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
		local helmet;

		if (banner <= 4)
		{
			helmet = ::Const.World.Common.pickHelmet([
				[
					5,
					"kettle_hat"
				],
				[
					5,
					"rondel_helm"
				],
				[
					4,
					"scale_helm"
				],
				[
					4,
					"kettle_hat_with_mail"
				],
				[
					3,
					"padded_kettle_hat"
				],
				[
					3,
					"legend_enclave_vanilla_skullcap_01"
				],
				[
					2,
					"mail_coif"
				],
				[
					1,
					"heavy_noble_house_helmet_00"
				]
			]);
		}
		else if (banner <= 7)
		{
			helmet = ::Const.World.Common.pickHelmet([
				[
					5,
					"rondel_helm"
				],
				[
					4,
					"padded_flat_top_helmet"
				],
				[
					3,
					"legend_enclave_vanilla_skullcap_01"
				],
				[
					3,
					"mail_coif"
				],
				[
					2,
					"flat_top_helmet"
				],
				[
					2,
					"scale_helm"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"heavy_noble_house_helmet_00"
				]
			]);
		}
		else
		{
			helmet = ::Const.World.Common.pickHelmet([
				[
					5,
					"nasal_helmet"
				],
				[
					5,
					"padded_nasal_helmet"
				],
				[
					4,
					"nasal_helmet_with_mail"
				],
				[
					3,
					"mail_coif"
				],
				[
					2,
					"legend_enclave_vanilla_skullcap_01"
				],
				[
					1,
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

});

