::Const.Tactical.Actor.LegendPeasantMonk = {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 10,
	MeleeDefense = 30,
	RangedDefense = 30,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/legend_peasant_monk", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendPeasantMonk);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(0, 255);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_staff_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_staff_stun"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_push_the_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_staves"));
		this.getSprite("socket").setBrush("bust_base_militia");

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_inspire"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;
		r = this.Math.rand(1, 4);

		if (r <= 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_tipstaff"));
		}

		local armor = [
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
		];
		local helmet = [
			[
				1,
				"straw_hat"
			],
			[
				2,
				"hood"
			],
			[
				1,
				"headscarf"
			]
		];
		local outfits = [
			[
				1,
				"brown_monk_outfit_00"
			]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
		{
			this.m.Items.equip(item);
		}
	}

});

