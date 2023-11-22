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
		local actor = this.getContainer().getActor();
		if (_attacker.getID() == actor.getID()) //if self inflicted damage, pin the blame on the player
		{
			if (!(::Const.Faction.Player in this.m.Factions)) this.m.Factions[::Const.Faction.Player] <- 0;
			this.m.Factions[::Const.Faction.Player] = this.m.Factions[::Const.Faction.Player] + _damageHitpoints + _damageArmor;
			return;
		}

		local faction = _attacker.getFaction();
		local isPlayer = faction == ::Const.Faction.Player || faction == ::Const.Faction.PlayerAnimals;
		if (isPlayer) faction = ::Const.Faction.Player;

		if (!(_attacker.getFaction() in this.m.Factions)) this.m.Factions[_attacker.getFaction()] <- 0;
		this.m.Factions[_attacker.getFaction()] = this.m.Factions[_attacker.getFaction()] + _damageHitpoints + _damageArmor;

	}

});
