::Const.Tactical.Actor.KrakenTentacle = {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 300,
	Bravery = 60,
	Stamina = 999,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/kraken_tentacle", function(o) {
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.KrakenTentacle);
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByRain = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_kraken_tentacle_01");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.68;
		this.setSpriteOffset("status_rooted", this.createVec(5, 25));
		this.setSpriteOffset("arrow", this.createVec(0, 25));
		this.setSpriteOffset("status_stunned", this.createVec(0, 25));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_move_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_bite_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_ensnare_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.Tactical.getTemporaryRoster().add(this);
	}
});

