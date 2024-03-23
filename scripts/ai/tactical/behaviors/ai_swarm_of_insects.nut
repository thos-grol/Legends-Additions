this.ai_swarm_of_insects <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.insects"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.SwarmOfInsects;
		this.m.Order = this.Const.AI.Behavior.Order.SwarmOfInsects;
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

		if (!this.Tactical.State.isScenarioMode() && !this.World.getTime().IsDaytime && this.Time.getRound() == 1)
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
		local bestScore = 30.0;
		local bestTarget;

		foreach( opponent in _targets )
		{
			local target = opponent.Actor;
			local opponentTile = opponent.Actor.getTile();

			if (!this.m.Skill.isUsableOn(opponentTile))
			{
				continue;
			}

			local score = 1.0;
			local distanceToTarget = myTile.getDistanceTo(opponentTile);

			if (!target.getCurrentProperties().IsRooted && !target.isArmedWithRangedWeapon() && this.queryActorTurnsNearTarget(target, myTile, _entity).Turns <= 1.0)
			{
				continue;
			}

			if (target.getMoraleState() == this.Const.MoraleState.Fleeing)
			{
				continue;
			}

			score = score + target.getCurrentProperties().getMeleeDefense();
			score = score + target.getCurrentProperties().getRangedDefense();
			score = score + target.getCurrentProperties().getMeleeSkill();
			score = score + target.getCurrentProperties().getRangedSkill();

			if (target.isArmedWithRangedWeapon() && distanceToTarget <= target.getIdealRange())
			{
				score = score + this.Const.AI.Behavior.InsectSwarmDangerOfRangedTarget;
			}

			score = score - myTile.getDistanceTo(opponentTile) * this.Const.AI.Behavior.InsectSwarmDistanceMult;
			local minDist = distanceToTarget;

			foreach( ally in knownAllies )
			{
				local d = ally.getTile().getDistanceTo(opponentTile);
				score = score + this.Math.max(0, 7 - d) * this.Const.AI.Behavior.InsectSwarmAllyDistanceMult;

				if (d < minDist)
				{
					d = minDist;
				}
			}

			if (this.getStrategy().getStats().RangedAlliedVSEnemies <= 1.0 && !target.isArmedWithRangedWeapon() && minDist > 4)
			{
				continue;
			}

			if (target.getSkills().hasSkill("effects.insect_swarm"))
			{
				for( ; target.getCurrentProperties().NegativeStatusEffectDuration < 0;  )
				{
				}

				score = score * this.Const.AI.Behavior.InsectSwarmAlreadyAppliedMult;
			}

			if (opponentTile.hasZoneOfOccupationOtherThan(target.getAlliedFactions()))
			{
				score = score * this.Const.AI.Behavior.InsectSwarmEngagedMult;
			}

			score = score * target.getCurrentProperties().TargetAttractionMult;

			if (_entity.getAttackers().find(target.getID()) != null)
			{
				score = score * this.Const.AI.Behavior.InsectSwarmAttackingMeMult;
			}

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

