::Const.Tactical.Actor.KoboldWolfrider <- {
	XP = 150,
	ActionPoints = 13,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 60,
	MeleeDefense = 15,
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
::mods_hookExactClass("entity/tactical/enemies/kobold_wolfrider", function(o) {

	o.onInit = function()
	{
		this.kobold.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.KoboldWolfrider);
		b.AdditionalActionPointCost = 1;
		b.DamageDirectMult = 1.25;
		b.IsSpecializedInCrossbows = true;
		b.IsSpecializedInBows = true;
		b.IsSpecializedInDaggers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("head_kobold_0" + this.Math.rand(1, 5));
		this.setAlwaysApplySpriteOffset(true);
		local offset = this.createVec(8, 14);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("armor", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("helmet", offset);
		this.setSpriteOffset("helmet_damage", offset);
		this.setSpriteOffset("body_blood", offset);
		local variant = this.Math.rand(1, 2);
		local wolf = this.addSprite("wolf");
		wolf.setBrush("bust_wolf_0" + variant + "_body");
		wolf.varySaturation(0.15);
		wolf.varyColor(0.07, 0.07, 0.07);
		local wolf = this.addSprite("wolf_head");
		wolf.setBrush("bust_wolf_0" + variant + "_head");
		wolf.Saturation = wolf.Saturation;
		wolf.Color = wolf.Color;
		this.removeSprite("injury_body");
		local wolf_injury = this.addSprite("injury_body");
		wolf_injury.setBrush("bust_wolf_01_injured");
		wolf_injury.Visible = false;
		local wolf_armor = this.addSprite("wolf_armor");
		wolf_armor.setBrush("bust_wolf_02_armor_01");
		offset = this.createVec(0, -20);
		this.setSpriteOffset("wolf", offset);
		this.setSpriteOffset("wolf_head", offset);
		this.setSpriteOffset("wolf_armor", offset);
		this.setSpriteOffset("injury_body", offset);
		this.addDefaultStatusSprites();
		this.setSpriteOffset("arms_icon", this.createVec(15, 15));
		this.getSprite("arms_icon").Rotation = 13.0;
		local wolf_bite = this.new("scripts/skills/actives/wolf_bite");
		wolf_bite.setRestrained(true);
		wolf_bite.m.ActionPointCost = 0;
		this.m.Skills.add(wolf_bite);
		this.m.Skills.add(this.new("scripts/skills/racial/goblin_ambusher_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
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
		}
		else if (this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
		}

		local item = this.Const.World.Common.pickHelmet([
			[
				25,
				"greenskins/goblin_light_helmet"
			],
			[
				75,
				""
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

