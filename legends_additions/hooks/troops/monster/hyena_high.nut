::Const.Tactical.Actor.FrenziedHyena = {
	XP = 250,
	ActionPoints = 14,
	Hitpoints = 140,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};
::mods_hookExactClass("entity/tactical/enemies/hyena_high", function(o) {
	o.getName = function()
	{
		return "Frenzied Hyena";
	}

	o.onInit = function()
	{
		this.hyena.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FrenziedHyena);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local body = this.getSprite("body");
		body.setBrush("bust_hyena_0" + this.Math.rand(4, 6));
		local head = this.getSprite("head");
		head.setBrush("bust_hyena_0" + this.Math.rand(4, 6) + "_head");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
	}

});

