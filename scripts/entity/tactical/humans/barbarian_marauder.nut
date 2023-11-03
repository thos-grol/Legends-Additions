this.barbarian_marauder <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BarbarianMarauder;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BarbarianMarauder.XP;
		this.abstract_human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_melee_agent");
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

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BarbarianMarauder);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
	}

	function pickOutfit()
	{
		local armor = [
			[
				33,
				"barbarians/scrap_metal_armor"
			],
			[
				34,
				"barbarians/hide_and_bone_armor"
			],
			[
				33,
				"barbarians/reinforced_animal_hide_armor"
			]
		];
		armor.push([
			5,
			"barbarians/legend_barbarian_southern_armor"
		]);
		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/bear_headpiece"
			],
			[
				1,
				"barbarians/leather_helmet"
			],
			[
				1,
				"barbarians/crude_metal_helmet"
			],
			[
				1,
				""
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

