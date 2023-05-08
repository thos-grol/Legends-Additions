::Const.Tactical.Actor.GoblinLeader = {
	XP = 400,
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
::mods_hookExactClass("entity/tactical/enemies/goblin_leader", function(o) {
	o.onInit = function()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinLeader);
		b.TargetAttractionMult = 1.5;
		b.DamageDirectMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_03_head_01");
		this.addDefaultStatusSprites();
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInCrossbows = true;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/actives/goblin_whip"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_true_believer"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.isRanged())
		{
			this.updateAchievement("Outgunned", 1, 1);
		}

		this.goblin.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.assignRandomEquipment = function()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/goblin_crossbow"));
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_falchion"));
		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"greenskins/goblin_leader_armor"
			]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"greenskins/goblin_leader_helmet"
			]
		]);
		this.m.Items.equip(item);
	}

});

