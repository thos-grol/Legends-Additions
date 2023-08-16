::Const.Tactical.Actor.KoboldFighter <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 70,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/enemies/kobold_fighter", function(o) {

	o.onInit = function()
	{
		this.kobold.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.KoboldFighter);
		b.DamageDirectMult = 1.4;
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("head_kobold_0" + this.Math.rand(1, 5));
		this.addDefaultStatusSprites();

		if (!this.m.IsLow)
		{
			b.IsSpecializedInBows = true;

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 180)
			{
				b.DamageDirectMult = 1.5;
			}
		}

		this.m.Skills.add(this.new("scripts/skills/racial/goblin_ambusher_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_backflip"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_hair_splitter"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		}
	}

	o.assignRandomEquipment = function()
	{
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));
		this.m.Items.equip(this.new("scripts/items/weapons/greenskins/legend_blowgun"));
		this.m.Items.equip(this.new("scripts/items/ammo/legend_darts"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
			this.m.Items.addToBag(this.new("scripts/items/accessory/spider_poison_item"));
		}
		else if (this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
		}
	}

});

