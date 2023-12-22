this.noble_man_at_arms <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.LegendManAtArms;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.LegendManAtArms.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.Military;
		this.m.HairColors = ::Const.HairColors.Old;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendManAtArms);
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

		local shield = this.new("scripts/items/shields/faction_kite_shield");
		shield.setFaction(banner);
		this.m.Items.equip(shield);
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"man_at_arms_noble_armor"
			]
		]));
		local helmet;
		helmet = ::Const.World.Common.pickHelmet([
			[
				3,
				"stag_helm"
			],
			[
				3,
				"swan_helm"
			],
			[
				1,
				"heavy_noble_house_helmet_00"
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

