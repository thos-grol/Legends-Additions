this._nokillstealing <- this.inherit("scripts/skills/skill", {
	m = {
		Factions = {}
	},
	function create()
	{
		this.m.ID = "effects._nokillstealing";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsHidden = true;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!(_attacker.getFaction() in this.m.Factions)) this.m.Factions[_attacker.getFaction()] <- 0;
		this.m.Factions[_attacker.getFaction()] = this.m.Factions[_attacker.getFaction()] + _damageHitpoints + _damageArmor;
	}
	
});
