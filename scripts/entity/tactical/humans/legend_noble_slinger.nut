//raider
this.legend_noble_slinger <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendSlinger;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendSlinger.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendSlinger);
		b.TargetAttractionMult = 1.1;
		b.IsSpecializedInCrossbows = true;
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

		if (::Math.rand(1, 100) <= 80)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}


		this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));


		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"gambeson"
			]
		]));
		local helmet = ::Const.World.Common.pickHelmet([
			[
				1,
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
				"mail_coif"
			],
			[
				1,
				""
			]
		]);

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

