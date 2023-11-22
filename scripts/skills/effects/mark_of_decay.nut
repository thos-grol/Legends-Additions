this.mark_of_decay <- this.inherit("scripts/skills/skill", {
	m = {
		Percent = 0.25,
		Bonus = 0.0,
		TurnsLeft = 3,
		RottenOffering = false,
		Ignore = false,
		Actor = null,
		ChanceResurrect = 10
	},

	function setActor( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

	function getAttacker()
	{
		if (::MSU.isNull(this.m.Actor)) return this.getContainer().getActor();
		if (this.m.Actor.getID() != this.getContainer().getActor().getID())
		{
			if (this.m.Actor.isAlive() && this.m.Actor.isPlacedOnMap()) return this.m.Actor;
		}
		return this.getContainer().getActor();
	}

	function create()
	{
		this.m.ID = "effects.mark_of_decay";
		this.m.Name = "Mark of Decay";
		this.m.Icon = "ui/perks/spell_mark_of_decay.png";
		this.m.IconMini = "status_effect_05_mini";
		this.m.Overlay = "status_effect_05";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function setBonus( _d )
	{
		this.m.Bonus = (_d * 2.0) / 100.0;
		::logInfo("setting bonus: +" + this.m.Bonus); //TODO: PLACEHOLDER remove after test, test mark of decay bonus after potency
	}

	function getDescription()
	{
		return "This unit has been marked by negative energy. They are fatigued by " + (this.m.Percent + this.m.Bonus) * 100 + "% of their max fatigue on turn start";
	}

	function reset()
	{
		this.m.TurnsLeft = 3;
	}

	function onUpdate( _properties )
	{
		if (this.m.RottenOffering) _properties.TargetAttractionMult += 2.0;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		local amount = ::Math.round(actor.getFatigueMax() * (this.m.Percent + this.m.Bonus));
		this.applyFatigueDamage(actor, amount);
		if (!actor.isHiddenToPlayer() && actor.getTile().IsVisibleForPlayer) ::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(actor) + ::MSU.Text.colorRed(" fatigue has decayed by " + amount));
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0) this.removeSelf();
	}

	function onDeath( _fatalityType )
	{
		local owner = getAttacker();
		if (owner.getSkills().getSkillByID("perk.research.rotten_offering") == null) return;
		local reanimate = owner.getSkills().getSkillByID("actives.spell.reanimate");
		if (reanimate == null) return;

		local bonus = 0;
		if (owner.getSkills().getSkillByID("perk.meditation.omen_of_decay") != null
			&& owner.getFlags().has("decay_bonus"))
			bonus = owner.getFlags().getAsInt("decay_bonus");

		local chance = 10 + 2 * bonus;
		if (::Math.rand(1, 100) > chance) return;

		local actor = this.getContainer().getActor();
		reanimate.m.Tiles.push(actor.getTile());
	}

});

