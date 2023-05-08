::Const.Tactical.Actor.SkeletonMedium = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 90,
	Stamina = 100,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/skeleton_medium_polearm", function(o) {
	o.onInit = function()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonMedium);
		b.Initiative -= 20;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		{
			b.IsSpecializedInPolearms = true;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	}

	o.assignRandomEquipment = function()
	{
		if (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.Math.max(10, 60 - this.World.getTime().Days))
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_bladed_pike"));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
		}

		local armor = [
			[
				1,
				"ancient/ancient_scale_harness"
			],
			[
				1,
				"ancient/ancient_mail"
			],
			[
				1,
				"ancient/ancient_double_layer_mail"
			]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				66,
				"ancient/ancient_legionary_helmet"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

