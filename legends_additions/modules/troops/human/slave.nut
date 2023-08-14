::Const.Tactical.Actor.Slave = {
	XP = 75,
	ActionPoints = 9,
	Hitpoints = 45,
	Bravery = 35,
	Stamina = 100,
	MeleeSkill = 45,
	RangedSkill = 35,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/slave", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Slave);
		b.TargetAttractionMult = 0.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");

		if (this.Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("bust_head_darkeyes_01");
			tattoo_head.Visible = true;
		}
		else
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.m.Ethnicity == 0)
		{
			local body = this.getSprite("body");
			body.Color = this.createColor("#ffeaea");
			body.varyColor(0.05, 0.05, 0.05);
			local head = this.getSprite("head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
	}

	o.assignRandomEquipment = function()
	{
		local r;
		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					2,
					"sackcloth"
				],
				[
					1,
					"indebted_armor_rags"
				],
				[
					2,
					"tattered_sackcloth"
				]
			]));
		}

		local helmet = [
			[
				1,
				"oriental/southern_head_wrap"
			],
			[
				2,
				""
			]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}

});

