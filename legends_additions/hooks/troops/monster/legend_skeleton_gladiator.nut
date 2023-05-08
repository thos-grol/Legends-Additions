::Const.Tactical.Actor.SkeletonGladiator = {
	XP = 300,
	ActionPoints = 10,
	Hitpoints = 85,
	Bravery = 100,
	Stamina = 85,
	MeleeSkill = 65,
	RangedSkill = 75,
	MeleeDefense = 15,
	RangedDefense = 30,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		175,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/legend_skeleton_gladiator", function(o) {
	o.onInit = function()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonGladiator);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_nets"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		this.m.Items.equip(this.new("scripts/items/weapons/throwing_spear"));
		this.m.Items.equip(this.new("scripts/items/weapons/throwing_spear"));
		this.m.Items.equip(this.new("scripts/items/weapons/throwing_spear"));
		this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
		this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"ancient/ancient_ripped_cloth"
			]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				34,
				""
			],
			[
				66,
				"ancient/ancient_gladiator_helmet"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

