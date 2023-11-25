this.militia_veteran <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.MilitiaVeteran;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.MilitiaVeteran.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.All;
		this.m.Flags.add("militia");
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/militia_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MilitiaVeteran);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");
	}

	function pickOutfit()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"gambeson"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"leather_lamellar"
			],
			[
				1,
				"thick_tunic"
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
					"full_leather_cap"
				]
			]));
		}
	}

});

