this._flesh_master <- this.inherit("scripts/skills/skill", {
	m = {
		Slave = null,
		IsActivated = false,
		Damage = 0
	},

	function activate()
	{
		this.m.IsActivated = true;
	}

	function setSlave( _p )
	{
		if (_p == null)
		{
			this.m.Slave = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Slave = _p;
		}
		else
		{
			this.m.Slave = this.WeakTableRef(_p);
		}
	}

	function isAlive()
	{
		return this.getContainer() != null && !this.getContainer().isNull() && this.getContainer().getActor() != null && this.getContainer().getActor().isAlive() && this.getContainer().getActor().getHitpoints() > 0;
	}

	function create()
	{
		this.m.ID = "effects._flesh_master";
		this.m.Name = "Flesh Master";
		this.m.Icon = "skills/status_effect_84.png";
		this.m.IconMini = "status_effect_84_mini";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		local actor = this.getContainer().getActor();
		local pact = actor.getSkills().getSkillByID("perk.meditation.pact_of_flesh");
		if (pact == null) return;

		this.m.Damage = _hitInfo.DamageRegular;
		_properties.DamageReceivedRegularMult *= 0;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		local pact = actor.getSkills().getSkillByID("perk.meditation.pact_of_flesh");
		if (pact == null) return;

		if (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive())
		{
			this.removeSelf();
			return;
		}
		if (this.m.Damage > 0) this.m.Slave.applyDamage(this.m.Damage);
		this.m.Damage = 0;
		if (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive()) this.removeSelf();
	}

	function onUpdate( _properties )
	{
		if (this.m.IsActivated && (this.m.Slave == null || this.m.Slave.isNull() || !this.m.Slave.isAlive()))
		{
			this.removeSelf();
		}
	}

	function onRemoved()
	{
		if (this.m.Slave != null && !this.m.Slave.isNull() && !this.m.Slave.getContainer().isNull())
		{
			local slave = this.m.Slave;
			this.m.Slave = null;
			slave.setMaster(null);
			slave.removeSelf();
			slave.getContainer().update();
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

});

