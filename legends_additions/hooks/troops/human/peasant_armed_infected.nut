::Const.Tactical.Actor.Peasant = {
	XP = 50,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 35,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/peasant_armed_infected", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Peasant);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_vermesthropy_injury"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_form"));

		if (this.Math.rand(1, 100) <= 20)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
		}

		if (this.Math.rand(1, 100) <= 10)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		}

		this.m.Skills.add(this.new("scripts/skills/traits/weasel_trait"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;
		r = this.Math.rand(1, 14);

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
			this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_saw"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 14)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));
		}

		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
		}

		local r;
		r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sling"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"sackcloth"
			],
			[
				1,
				"thick_tunic"
			],
			[
				2,
				"apron"
			],
			[
				1,
				"tattered_sackcloth"
			],
			[
				2,
				"linen_tunic"
			]
		]));

		if (this.Math.rand(1, 100) <= 50)
		{
			local helmet = [
				[
					1,
					"hood"
				],
				[
					1,
					"headscarf"
				],
				[
					1,
					"straw_hat"
				],
				[
					1,
					"feathered_hat"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}

});

