this.flesh_abomination_ranged <- this.inherit("scripts/entity/tactical/enemies/flesh_abomination", {
	m = {},
	function create()
	{
		this.flesh_abomination.create();

		this.m.AIAgent = this.new("scripts/ai/tactical/agents/flesh_abomination_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombiePlayer);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.InjuryType = 1;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("flesh_abomination_ranged");
		body.varySaturation(0.2);
		body.varyColor(0.06, 0.06, 0.06);
		local injury = this.addSprite("injury");
		injury.setBrush("bust_alp_01_injured");
		injury.Scale = 0.8;
		injury.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 10));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/actives/bone_bolt"));
	}
});