this.ai_nachzerer_swallow_whole <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.nachzerer_swallow_whole"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.SwallowWhole;
		this.m.Order = ::Const.AI.Behavior.Order.SwallowWhole;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		::logInfo("begin: " + "ai_nachzerer_swallow_whole");
		this.m.TargetTile = null;
		this.m.Skill = null;

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (this.getAgent().getKnownOpponents().len() <= 1)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local targets = this.queryTargetsInMeleeRange();

		if (targets.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local bestTarget = this.getBestTarget(_entity, this.m.Skill, targets);

		if (bestTarget.Target == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget.Target.getTile();
		return ::Const.AI.Behavior.Score.SwallowWhole * 100;
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
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using Swallow Whole against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			this.m.Skill.use(this.m.TargetTile);

			if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
			{
				this.getAgent().declareAction();
			}

			this.m.TargetTile = null;
		}

		return true;
	}

	function getBestTarget( _entity, _skill, _targets )
	{
		local bestTarget;
		local bestScore = 0.0;

		foreach( target in _targets )
		{
			if (!_skill.onVerifyTarget(_entity.getTile(), target.getTile()))
			{
				continue;
			}

			local score = 0.0;

			if (target.getHitpoints() <= 10)
			{
				continue;
			}

			local p = target.getCurrentProperties();
			score = score + p.getMeleeDefense();
			score = score + p.getMeleeSkill() * 0.25;
			score = score + target.getHitpoints() * 0.25;
			score = score + (target.getArmor(::Const.BodyPart.Body) * (p.HitChance[::Const.BodyPart.Body] / 100.0) + target.getArmor(::Const.BodyPart.Head) * (p.HitChance[::Const.BodyPart.Head] / 100.0)) * 0.1;
			score = score * p.TargetAttractionMult;

			if (score > bestScore)
			{
				bestTarget = target;
				bestScore = score;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore * 0.01
		};
	}

});

