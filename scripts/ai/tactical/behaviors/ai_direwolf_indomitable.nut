this.ai_direwolf_indomitable <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.direwolf_indomitable"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.Indomitable;
		this.m.Order = ::Const.AI.Behavior.Order.Indomitable;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		if (_entity.getCurrentProperties().IsStunned) return ::Const.AI.Behavior.Score.Zero;
		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing) return ::Const.AI.Behavior.Score.Zero;
		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP) return ::Const.AI.Behavior.Score.Zero;
		if (!this.getAgent().hasKnownOpponent()) return ::Const.AI.Behavior.Score.Zero;
		
		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return ::Const.AI.Behavior.Score.Zero;
		local targets = this.queryTargetsInMeleeRange(1, 1);
		if (targets.len() <= 1) return ::Const.AI.Behavior.Score.Zero;

		return 1000000000;
	}

	function onExecute( _entity )
	{
		if (::Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Indomitable!");
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

