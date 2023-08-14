::Const.Tactical.Actor.ZombiePlayer = {
	XP = 150,
	ActionPoints = 6,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 50,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/zombie_player", function(o) {
	o.onInit = function()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombiePlayer);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.FatigueDealtPerHitMult = 2.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.InjuryType = 1;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		local injury = this.getSprite("injury");
		injury.setBrush("zombify_01");
	}

});

