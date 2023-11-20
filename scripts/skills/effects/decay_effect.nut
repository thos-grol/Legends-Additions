this.decay_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		Damage = 5,
		LastRoundApplied = 0,
		Actor = null
	},
	function getDamage()
	{
		return this.m.Damage;
	}

	function setDamage( _d )
	{
		this.m.Damage = _d;
	}

	function setActor( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function create()
	{
		this.m.ID = "effects.decay";
		this.m.Name = "Decaying";
		this.m.KilledString = "Decayed to death";
		this.m.Icon = "ui/perks/meditation_omen_of_decay.png";
		this.m.IconMini = "decay_mini";
		this.m.Overlay = "decay";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DamageOverTime;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is decaying and will lose [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.Damage + "[/color] hitpoints each turn for [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function getAttacker()
	{
		if (!::Legends.Mod.ModSettings.getSetting("BleedKiller").getValue()) return this.getContainer().getActor();
		if (::MSU.isNull(this.m.Actor)) return this.getContainer().getActor();
		if (this.m.Actor.getID() != this.getContainer().getActor().getID())
		{
			if (this.m.Actor.isAlive() && this.m.Actor.isPlacedOnMap()) return this.m.Actor;
		}
		return this.getContainer().getActor();
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile()); //FIXME: EFFECT icon fx
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getAttacker(), this, hitInfo);
			if (--this.m.TurnsLeft <= 0) this.removeSelf();
		}
	}

	function onAdded()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "'s resilience decreased the decay time by 1");
			}

			this.m.TurnsLeft -= 1;
		}

		::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is decaying (" + this.m.TurnsLeft + " turns)");
	}

	function onUpdate( _properties )
	{
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});

