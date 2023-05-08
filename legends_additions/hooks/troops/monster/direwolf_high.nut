::Const.Tactical.Actor.FrenziedDirewolf = {
	XP = 250,
	ActionPoints = 12,
	Hitpoints = 150,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
};
::mods_hookExactClass("entity/tactical/enemies/direwolf_high", function(o) {
	o.getName = function()
	{
		return "Frenzied Direwolf";
	}

	o.onInit = function()
	{
		this.direwolf.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FrenziedDirewolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local head_frenzy = this.getSprite("head_frenzy");
		head_frenzy.setBrush(this.getSprite("head").getBrush().Name + "_frenzy");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		}
	}

});

