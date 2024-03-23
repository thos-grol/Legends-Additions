this.ai_wither <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.wither"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Wither;
		this.m.Order = this.Const.AI.Behavior.Order.Wither;
		this.m.IsThreaded = false;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		this.m.TargetTile = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local opponents = this.getAgent().getKnownOpponents();
		local target = this.findBestTarget(_entity, opponents);

		if (target.Target == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = target.Target.getTile();
		return this.Const.AI.Behavior.Score.SwarmOfInsects * score + target.Score;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;

			if (this.m.TargetTile.IsVisibleForPlayer && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(this.Const.Faction.Player);
			}

			return false;
		}

		this.m.Skill.use(this.m.TargetTile);

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		this.m.TargetTile = null;
		return true;
	}

	function findBestTarget( _entity, _targets )
	{
		local myTile = _entity.getTile();
		local knownAllies = this.getAgent().getKnownAllies();
		local bestScore = 0.0;
		local bestTarget;
		local entities = this.Tactical.Entities.getInstancesOfFaction(_entity.getFaction());
		local masterTile;

		foreach( e in entities )
		{
			if (e.getType() == this.Const.EntityType.SkeletonLich)
			{
				masterTile = e.getTile();
				break;
			}
		}

		foreach( opponent in _targets )
		{
			local target = opponent.Actor;
			local opponentTile = opponent.Actor.getTile();

			if (!this.m.Skill.isUsableOn(opponentTile))
			{
				continue;
			}

			if (target.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				continue;
			}

			local score = 0.0;
			score = score + target.getCurrentProperties().getMeleeDefense();
			score = score + target.getCurrentProperties().getRangedDefense();
			score = score + target.getCurrentProperties().getMeleeSkill();
			score = score + target.getCurrentProperties().getRangedSkill();

			foreach( ally in knownAllies )
			{
				local d = ally.getTile().getDistanceTo(opponentTile);
				score = score + this.Math.max(0, 5 - d) * this.Const.AI.Behavior.WitherAllyDistanceMult;
			}

			local withered = target.getSkills().getSkillByID("effects.withered");

			if (withered != null && withered.m.TurnsLeft >= 2)
			{
				continue;
			}

			if (withered != null && withered.m.TurnsLeft == 1)
			{
				score = score * this.Const.AI.Behavior.WitherAlreadyAppliedMult;
			}

			if (opponentTile.hasZoneOfOccupationOtherThan(target.getAlliedFactions()))
			{
				score = score * this.Math.pow(this.Const.AI.Behavior.WitherEngagedPOW, opponentTile.getZoneOfOccupationCountOtherThan(target.getAlliedFactions()));
			}

			if (masterTile != null && opponentTile.getDistanceTo(masterTile) <= 2)
			{
				score = score * this.Const.AI.Behavior.WitherNearMasterMult;
			}

			score = score * target.getCurrentProperties().TargetAttractionMult;

			if (score > bestScore)
			{
				bestScore = score;
				bestTarget = target;
			}
		}

		return {
			Target = bestTarget,
			Score = bestScore * 0.1
		};
	}

});

