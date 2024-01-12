this.ai_eldritch_blast <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.eldritch_blast"
		],
		SelectedSkill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.EldritchBlast;
		this.m.Order = ::Const.AI.Behavior.Order.EldritchBlast;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

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

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				skills.push(skill);
			}
		}

		if (skills.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local targets = this.getAgent().getKnownOpponents();
		score = score * this.selectBestTargetAndSkill(_entity, targets, skills);

		if (this.m.TargetTile == null || this.m.SelectedSkill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.SelectedSkill);

		if (this.getAgent().getIntentions().IsChangingWeapons)
		{
			score = score * ::Const.AI.Behavior.AttackAfterSwitchWeaponMult;
		}

		// if (::Math.rand(1,100) > 33)
		// {
		// 	return ::Const.AI.Behavior.Score.Zero;
		// }

		return ::Const.AI.Behavior.Score.Attack * score * 2;
	}

	function onBeforeExecute( _entity )
	{
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			if (this.m.TargetTile.getEntity().isPlayerControlled() && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			this.getAgent().adjustCameraToTarget(this.m.TargetTile, this.m.SelectedSkill.getDelay());
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.SelectedSkill.getName() + " against " + this.m.TargetTile.getEntity().getName() + "!");
			}

			this.m.SelectedSkill.use(this.m.TargetTile);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();
				this.getAgent().declareEvaluationDelay(this.m.SelectedSkill.getDelay() + 750);
			}

			this.m.TargetTile = null;
			this.m.SelectedSkill = null;
		}

		return true;
	}

	function selectBestTargetAndSkill( _entity, _targets, _skills )
	{
		local bestSkills;
		local bestTarget;
		local bestScore = -9000.0;
		local bestOpponentsAdjacent = 0;
		local myTile = _entity.getTile();

		foreach( target in _targets )
		{
			if (target.Actor.isNull())
			{
				continue;
			}

			local targetTile = target.Actor.getTile();

			if (!targetTile.IsVisibleForEntity)
			{
				continue;
			}

			local skills = [];

			foreach( s in _skills )
			{
				if (s.isInRange(targetTile) && s.onVerifyTarget(_entity.getTile(), targetTile))
				{
					skills.push({
						Skill = s,
						Score = 0.0
					});
				}
			}

			if (skills.len() == 0)
			{
				continue;
			}

			local alliesAdjacent = 0;
			local opponentsAdjacent = 0;
			local score = 0.0;

			foreach( s in skills )
			{
				local tilesAffected = s.Skill.getAffectedTiles(targetTile);

				foreach( t in tilesAffected )
				{
					if (!t.IsOccupiedByActor)
					{
						continue;
					}

					if (_entity.isAlliedWith(t.getEntity()))
					{
						if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
						{
							s.Score -= 1.0 / 6.0 * 4.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * t.getEntity().getCurrentProperties().TargetAttractionMult;
						}
					}
					else
					{
						s.Score += this.queryTargetValue(_entity, t.getEntity(), s.Skill);
					}
				}
			}

			local blockedTiles = ::Const.Tactical.Common.getBlockedTiles(myTile, targetTile, _entity.getFaction());

			foreach( tile in blockedTiles )
			{
				if (!tile.IsOccupiedByActor || tile.getEntity().isAlliedWith(_entity))
				{
					score = score * ::Const.AI.Behavior.AttackLineOfFireBlockedMult;
					break;
				}
			}

			if (myTile.getDistanceTo(targetTile) > 2)
			{
				for( local i = 0; i < ::Const.Direction.COUNT; i = ++i )
				{
					if (!targetTile.hasNextTile(i))
					{
					}
					else
					{
						local tile = targetTile.getNextTile(i);

						if (tile.IsEmpty)
						{
						}
						else if (tile.IsOccupiedByActor)
						{
							if (tile.getEntity().isAlliedWith(_entity))
							{
								if (this.getProperties().TargetPriorityHittingAlliesMult < 1.0)
								{
									score = score - 1.0 / 6.0 * 4.0 * (1.0 - this.getProperties().TargetPriorityHittingAlliesMult) * tile.getEntity().getCurrentProperties().TargetAttractionMult;
								}

								alliesAdjacent = ++alliesAdjacent;
							}
							else
							{
								score = score + 1.0 / 6.0 * this.queryTargetValue(_entity, tile.getEntity(), null) * ::Const.AI.Behavior.AttackRangedHitBystandersMult;
								opponentsAdjacent = ++opponentsAdjacent;
							}
						}
					}
				}
			}

			if (targetTile.getZoneOfControlCount(_entity.getFaction()) < ::Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)
			{
				score = score * (1.0 + (1.0 - ::Math.minf(1.0, this.queryActorTurnsNearTarget(target.Actor, myTile, _entity).Turns)) * ::Const.AI.Behavior.AttackDangerMult);
			}

			if (score > bestScore && (this.getProperties().TargetPriorityHittingAlliesMult >= 1.0 || alliesAdjacent <= ::Const.AI.Behavior.AttackRangedMaxAlliesAdjacent))
			{
				bestTarget = target;
				bestScore = score;
				bestSkills = skills;
				bestOpponentsAdjacent = opponentsAdjacent;
			}
		}

		if (bestTarget != null)
		{
			this.m.TargetTile = bestTarget.Actor.getTile();
			local chance = 0;
			local highestScore = 0;

			for( local i = 0; i < bestSkills.len(); i = ++i )
			{
				if (bestSkills[i].Score > highestScore)
				{
					highestScore = ::Math.floor(::Math.pow(bestSkills[i].Score * 100, ::Const.AI.Behavior.AttackRangedChancePOW));
				}
			}

			for( local i = 0; i < bestSkills.len(); i = ++i )
			{
				local score = ::Math.floor(::Math.pow(bestSkills[i].Score * 100, ::Const.AI.Behavior.AttackRangedChancePOW));

				if (score < highestScore * ::Const.AI.Behavior.AttackRangedScoreCutoff)
				{
				}
				else
				{
					chance = chance + score;
				}
			}

			if (chance != 0)
			{
				local pick = ::Math.rand(1, chance);

				for( local i = 0; i < bestSkills.len(); i = ++i )
				{
					local score = ::Math.floor(::Math.pow(bestSkills[i].Score * 100, ::Const.AI.Behavior.AttackRangedChancePOW));

					if (score < highestScore * ::Const.AI.Behavior.AttackRangedScoreCutoff)
					{
					}
					else
					{
						if (pick <= score)
						{
							this.m.SelectedSkill = bestSkills[i].Skill;
							return ::Math.maxf(0.1, bestSkills[i].Score + ::Math.maxf(0.0, bestScore));
						}

						pick = pick - score;
					}
				}
			}
		}

		return 0.0;
	}

});

