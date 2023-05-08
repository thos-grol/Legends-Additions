::Const.Tactical.Actor.LegendPeasantBlacksmith = {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 80,
	RangedSkill = 10,
	MeleeDefense = 20,
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
::mods_hookExactClass("entity/tactical/humans/legend_peasant_blacksmith", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantBlacksmith);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_damage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_hammer"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
		this.getSprite("socket").setBrush("bust_base_militia");

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
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
				1,
				"apron"
			],
			[
				1,
				"tattered_sackcloth"
			],
			[
				6,
				"linen_tunic"
			]
		]));

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[
					1,
					"headscarf"
				],
				[
					2,
					"hood"
				],
				[
					1,
					"straw_hat"
				]
			]));
		}
	}

});

