this.mercenary_ranged <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.MercenaryRanged;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.MercenaryRanged.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.AllMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);

		if (::Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = ::Const.Faces.WildFemale;
		}
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.MercenaryRanged);
		b.TargetAttractionMult = 2.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function pickOutfit()
	{
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"mail_shirt"
			],
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"padded_leather"
			]
		]));

		if (::Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(::Const.World.Common.pickHelmet([
				[
					1,
					"hood"
				],
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
					"full_leather_cap"
				],
				[
					1,
					"headscarf"
				],
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
					"mail_coif"
				]
			]));
		}
	}

	function post_init()
	{
		this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
	}

});

