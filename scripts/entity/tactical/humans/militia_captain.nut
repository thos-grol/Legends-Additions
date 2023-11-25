this.militia_captain <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.MilitiaCaptain;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.MilitiaCaptain.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
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
		b.setValues(this.Const.Tactical.Actor.MilitiaCaptain);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_02");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
	}

	function pickOutfit()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"mail_shirt"
			]
		]));
		local r = this.Math.rand(1, 4);
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
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
				"feathered_hat"
			],
			[
				1,
				"kettle_hat"
			]
		]));
	}

});

