this.ai_recover <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.recover"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.Recover;
		this.m.Order = ::Const.AI.Behavior.Order.Recover;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		local scoreMult = 1.0;

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing) return ::Const.AI.Behavior.Score.Zero;
		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP) return ::Const.AI.Behavior.Score.Zero;
		if (_entity.getFatigue() < _entity.getFatigueMax() / 2 || _entity.getFatigue() <= _entity.getCurrentProperties().FatigueRecoveryRate) return ::Const.AI.Behavior.Score.Zero;
		if (this.getAgent().getBehavior(::Const.AI.Behavior.ID.Adrenaline) != null && this.getAgent().getBehavior(::Const.AI.Behavior.ID.Adrenaline).getUsedLast() == this.Time.getRound() - 1) return ::Const.AI.Behavior.Score.Zero;
		
		// local myTile = _entity.getTile();
		// local inZonesOfControl = myTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
		// local isDisarmed = !_entity.getCurrentProperties().IsAbleToUseWeaponSkills;

		// if (inZonesOfControl != 0 && (!isDisarmed || _entity.isArmedWithShield())) return ::Const.AI.Behavior.Score.Zero;
		local numAttacksLastTurn = _entity.getAttackedCount();
		if (numAttacksLastTurn > 3) return ::Const.AI.Behavior.Score.Zero;
		
		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return ::Const.AI.Behavior.Score.Zero;
		
		scoreMult = scoreMult * (_entity.getFatigue() / (_entity.getFatigueMax() * 1.0));
		scoreMult = scoreMult * ::Math.minf(1.0, ::Math.maxf(0.5, this.Tactical.TurnSequenceBar.getTurnPosition() / (1.0 * this.Tactical.TurnSequenceBar.getAllEntities().len())));
		return ::Const.AI.Behavior.Score.Recover * scoreMult;
	}

	function onExecute( _entity )
	{
		if (::Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Recover!");
		}

		this.m.Skill.use(_entity.getTile());

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		return true;
	}

});

