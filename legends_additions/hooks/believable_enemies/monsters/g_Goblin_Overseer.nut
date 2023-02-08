::Const.Tactical.Actor.GoblinLeader <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 95,
	Stamina = 130,
	MeleeSkill = 75,
	RangedSkill = 80,
	MeleeDefense = 15,
	RangedDefense = 20,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::mods_hookExactClass("entity/tactical/goblin_leader", function (o)
{

    o.onInit = function()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinLeader);
		b.TargetAttractionMult = 1.5;
		b.DamageDirectMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_03_head_01");
		this.addDefaultStatusSprites();
		b.IsSpecializedInCrossbows = true;
		this.m.Skills.add(::new("scripts/skills/actives/goblin_whip"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(::new("scripts/skills/traits/fearless_trait"));

		local inspiringPresencePerk = ::new("scripts/skills/perks/perk_inspiring_presence");
		inspiringPresencePerk.m.IsForceEnabled = true;
		this.m.Skills.add(inspiringPresencePerk);

		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_hair_splitter"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_head_hunter"));
		this.getFlags().add("goblin");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_eyes_up"));


		//FEATURE_1: Overseer Perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_true_believer"));
		this.m.Skills.addPerkTree(::Const.Perks.SwordTree, 7);
		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_power_shot"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_primal_fear"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_vengeful_spite"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_entrenched"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_personal_armor"));


	}

});