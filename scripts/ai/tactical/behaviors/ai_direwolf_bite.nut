this.ai_direwolf_bite <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.direwolf_bite"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.AttackDefault;
		this.m.Order = this.Const.AI.Behavior.Order.AttackDefault;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP) return this.Const.AI.Behavior.Score.Zero;
		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing) return this.Const.AI.Behavior.Score.Zero;
		if (!this.getAgent().hasVisibleOpponent()) return this.Const.AI.Behavior.Score.Zero;

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return this.Const.AI.Behavior.Score.Zero;

		local myTile = _entity.getTile();
		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange() + (this.m.Skill.isRanged() ? myTile.Level : 0), this.m.Skill.getMaxLevelDifference());
		if (targets.len() == 0) return this.Const.AI.Behavior.Score.Zero;

		this.m.TargetTile = ::MSU.Array.rand(targets).getTile();
		return this.Const.AI.Behavior.Score.Attack;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
		{
			if (this.Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			local dist = _entity.getTile().getDistanceTo(this.m.TargetTile);
			this.m.Skill.use(this.m.TargetTile);
			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();

				if (dist > 1 && this.m.Skill.isShowingProjectile())
				{
					this.getAgent().declareEvaluationDelay(750);
				}
				else if (this.m.Skill.getDelay() != 0)
				{
					this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
				}
			}
			this.m.TargetTile = null;
		}

		return true;
	}

});

