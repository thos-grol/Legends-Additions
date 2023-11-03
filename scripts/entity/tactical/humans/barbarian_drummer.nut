this.barbarian_drummer <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BarbarianDrummer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BarbarianDrummer.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;

		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = this.Const.Faces.WildFemale;
		}

		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_drummer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];
		local tattoo_body = this.actor.getSprite("tattoo_body");
		local body = this.actor.getSprite("body");
		tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
		tattoo_body.Visible = true;
		local tattoo_head = this.actor.getSprite("tattoo_head");
		tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
		tattoo_head.Visible = true;
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BarbarianMarauder);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
	}

	function pickOutfit()
	{
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"barbarians/thick_furs_armor"
			],
			[
				1,
				"barbarians/animal_hide_armor"
			],
			[
				1,
				"barbarians/reinforced_animal_hide_armor"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/bear_headpiece"
			]
		]);

		if (item != null) this.m.Items.equip(item);
	}

	function assignRandomEquipment()
	{
		this.abstract_human.assignRandomEquipment();

		local r = this.Math.rand(1, 2);
		if (r == 1) this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
		else if (r == 2) this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/claw_club"));
	}

});

