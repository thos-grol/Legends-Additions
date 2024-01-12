this.drained_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		ActorID = null
	},
	function create()
	{
		this.m.ID = "effects.drained_effect";
		this.m.Name = "Drained";
		this.m.Description = "This character has been drained by negative energy.";
		this.m.Icon = "skills/demon_hound_bite.png";
		this.m.IconMini = "demon_hound_bite_effect";
		this.m.Overlay = "demon_hound_bite_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded()
	{
		this.m.TurnsLeft = ::Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function getDescription()
	{
		return "This character has been drained by negative energy and has: "
		+ "\n[color=" + ::Const.UI.Color.NegativeValue + "] -30% [/color]Fatigue recovery for [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s)."
		+ "\n[color=" + ::Const.UI.Color.NegativeValue + "] -" + (this.m.TurnsLeft * 10) + "% [/color]Max Health for [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function onUpdate( _properties )
	{
		_properties.HitpointsMult *= 1.0 - this.m.TurnsLeft / 10.0;
		_properties.FatigueRecoveryRateMult *= 0.3;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function resetTime()
	{
		this.m.TurnsLeft += 2;
		if (this.m.TurnsLeft >= 10) this.actor.kill(this.getAttacker(), this, ::Const.FatalityType.None, false);
	}

	function getAttacker()
	{
		if (this.m.ActorID != null)
		{
			local e = this.Tactical.getEntityByID(this.m.ActorID);

			if (e != null && e.isPlacedOnMap() && e.isAlive() && !e.isDying())
			{
				return e;
			}
		}

		return null;
	}

});

