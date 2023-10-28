this.legend_bandit_veteran <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Name = "Raider (Veteran)";
		this.m.Type = this.Const.EntityType.BanditVeteran;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditVeteran.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditVeteran);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.6);
		this.getSprite("shield_icon").setBrightness(0.85);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function pickOutfit()
	{
		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"reinforced_mail_hauberk"
			],
			[
				1,
				"scale_armor"
			],
			[
				2,
				"heavy_lamellar_armor"
			],
			[
				2,
				"bandit_armor_heavy"
			],
			[
				3,
				"bandit_armor_ultraheavy"
			]
		]);
		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 85)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					1,
					"nasal_helmet"
				],
				[
					1,
					"rondel_helm"
				],
				[
					1,
					"barbute_helmet"
				],
				[
					1,
					"legend_enclave_vanilla_skullcap_01"
				],
				[
					1,
					"legend_enclave_vanilla_kettle_sallet_01"
				],
				[
					1,
					"scale_helm"
				],
				[
					1,
					"deep_sallet"
				],
				[
					1,
					"dented_nasal_helmet"
				],
				[
					1,
					"nasal_helmet_with_rusty_mail"
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

