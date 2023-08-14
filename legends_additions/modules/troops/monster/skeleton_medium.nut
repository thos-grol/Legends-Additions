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
::mods_hookExactClass("entity/tactical/enemies/skeleton_medium", function(o) {
	o.onInit = function()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonMedium);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local weapons = [
			[
				1,
				"weapons/ancient/broken_ancient_sword"
			],
			[
				2,
				"weapons/ancient/ancient_sword"
			],
			[
				1,
				"weapons/ancient/legend_gladius"
			]
		];
		this.m.Items.equip(this.Const.World.Common.pickItem(weapons, "scripts/items/"));

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 100) <= 66)
			{
				this.m.Items.equip(this.new("scripts/items/shields/ancient/coffin_shield"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
			}
		}

		local armor = [
			[
				1,
				"ancient/ancient_scale_harness"
			],
			[
				1,
				"ancient/ancient_breastplate"
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
				99,
				"ancient/ancient_honorguard_helmet"
			],
			[
				1,
				"ancient/legend_ancient_legionary_helmet_restored"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

