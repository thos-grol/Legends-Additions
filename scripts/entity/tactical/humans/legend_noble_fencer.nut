this.legend_noble_fencer <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendFencer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendFencer.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_fencer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendFencer);
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

		r = this.Math.rand(0, 2);

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
						"padded_kettle_hat"
					],
					[
						1,
						"kettle_hat_with_mail"
					],
					[
						1,
						"mail_coif"
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
				],
				[
					1,
					"headscarf"
				],
				[
					1,
					""
				]
			]));
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = this.Math.rand(1, 2);
		if (r == 1) //armor
		{
			local armor = [
				"armor/named/black_leather_armor",
				"armor/named/named_noble_mail_armor",
				"armor/named/blue_studded_mail_armor"
			];
			local h = this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armor));
			this.m.Items.equip(h);
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

