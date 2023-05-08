::Const.Tactical.Actor.LegendPeasantMinstrel = {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 70,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 40,
	MeleeDefense = 0,
	RangedDefense = 20,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/legend_peasant_minstrel", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMinstrel);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_lute_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_lute_damage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_entice"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_daze"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_drums_of_life"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_drums_of_war"));
		this.getSprite("socket").setBrush("bust_base_militia");

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;
		r = this.Math.rand(1, 100);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/named_lute"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/lute"));
		}

		local r;
		r = this.Math.rand(1, 4);

		if (r >= 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_drum"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				9,
				"linen_tunic"
			]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					3,
					"feathered_hat"
				],
				[
					1,
					"hood"
				]
			]));
		}
	}

});

