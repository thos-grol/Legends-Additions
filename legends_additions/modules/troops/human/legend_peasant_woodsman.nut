::Const.Tactical.Actor.LegendPeasantWoodsman = {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 20,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/legend_peasant_woodsman", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantWoodsman);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_damage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_axe"));
		this.getSprite("socket").setBrush("bust_base_militia");

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_forceful_swing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"thick_tunic"
			],
			[
				8,
				"linen_tunic"
			]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					3,
					"straw_hat"
				],
				[
					1,
					"hood"
				]
			]));
		}
	}

});

