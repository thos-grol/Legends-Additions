this.mercenary_ranged <- this.inherit("scripts/entity/tactical/abstract_abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.MercenaryRanged;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.MercenaryRanged.XP;
		this.abstract_abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);

		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = this.Const.Faces.WildFemale;
		}
	}

	function onInit()
	{
		this.abstract_abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MercenaryRanged);
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
		this.m.Items.equip(this.Const.World.Common.pickArmor([
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

		if (this.Math.rand(1, 100) <= 75)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
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

