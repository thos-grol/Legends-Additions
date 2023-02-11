::Const.Tactical.Actor.LegendRedbackSpider <- {
	XP = 600,
	ActionPoints = 16,
	Hitpoints = 250,
	Bravery = 120,
	Stamina = 180,
	MeleeSkill = 85,
	RangedSkill = 0,
	MeleeDefense = 45,
	RangedDefense = 30,
	Initiative = 175,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		240,
		240
	]
};
::mods_hookExactClass("entity/tactical/enemies/legend_redback_spider", function (o)
{
    o.onInit = function()
	{
        this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LegendRedbackSpider);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local legs_back = this.addSprite("legs_back");
		legs_back.setBrush("bust_spider_redback_legs_back");
		local body = this.addSprite("body");
		body.setBrush("bust_spider_redback_body_0" + this.Math.rand(1, 4));

		if (this.Math.rand(0, 100) < 90) body.varySaturation(0.3);
		if (this.Math.rand(0, 100) < 90) body.varyColor(0.1, 0.1, 0.1);
		if (this.Math.rand(0, 100) < 90) body.varyBrightness(0.1);

		local legs_front = this.addSprite("legs_front");
		legs_front.setBrush("bust_spider_redback_legs_front");
		legs_front.Color = body.Color;
		legs_front.Saturation = body.Saturation;
		legs_back.Color = body.Color;
		legs_back.Saturation = body.Saturation;
		local head = this.addSprite("head");
		head.setBrush("bust_spider_redback_head_01");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_spider_01_injured");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(7, 10));
		this.setSpriteOffset("status_stunned", this.createVec(0, -20));
		this.setSpriteOffset("arrow", this.createVec(0, -20));
		this.setSize(this.Math.rand(70, 90) * 0.01);

		this.m.Skills.add(::new("scripts/skills/actives/legend_redback_spider_bite_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/web_skill"));

        this.m.Skills.add(::new("scripts/skills/racial/legend_redback_spider_racial"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_legend_escape_artist"));
        this.m.Skills.add(::new("scripts/skills/effects/webknecht_potion_effect"));

        this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_inspiring_presence"));
        this.m.Skills.add(::new("scripts/skills/traits/fearless_trait"));
    }

});