this.ai_charm <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		Danger = null,
		ScoreBonus = 1.0,
		PossibleSkills = [
			"actives.charm"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Charm;
		this.m.Order = this.Const.AI.Behavior.Order.Charm;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.Danger = null;
		this.m.ScoreBonus = 0.0;
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
		local func = this.calculateDanger(_entity, opponents);

		while (resume func == null)
		{
			yield null;
		}

		local func = this.findBestTarget(_entity, opponents);

		while (resume func == null)
		{
			yield null;
		}

		if (this.m.TargetTile == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Danger = null;
		return this.Const.AI.Behavior.Score.Charm * score + this.m.ScoreBonus;
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
		this.getAgent().declareEvaluationDelay(2000);

		if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
		{
			this.getAgent().declareAction(2000);
		}

		this.m.Skill = null;
		this.m.TargetTile = null;
		return true;
	}

	function findBestTarget( _entity, _targets )
	{
		// Function is a generator.
		local myTile = _entity.getTile();
		local knownAllies = this.getAgent().getKnownAllies();
		local bestScore = 0.0;
		local bestTarget;
		local time = this.Time.getExactTime();

		foreach( opponent in _targets )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local target = opponent.Actor;
			local opponentTile = opponent.Actor.getTile();

			if (!this.m.Skill.isUsableOn(opponentTile))
			{
				continue;
			}

			local score = 100.0;
			local distanceToTarget = myTile.getDistanceTo(opponentTile);
			local isRangedOpponent = this.isRangedUnit(target);

			if (target.getMoraleState() == this.Const.MoraleState.Fleeing || target.getCurrentProperties().IsStunned || !target.getCurrentProperties().IsAbleToUseWeaponSkills)
			{
				continue;
			}

			if (target.getSkills().hasSkill("effects.charmed"))
			{
				continue;
			}

			score = score + target.getLevel() * this.Const.AI.Behavior.CharmLevelMult;

			if (isRangedOpponent)
			{
				score = score + target.getCurrentProperties().getRangedSkill() * this.Const.AI.Behavior.CharmSkillMult;
			}
			else
			{
				score = score + target.getCurrentProperties().getMeleeSkill() * this.Const.AI.Behavior.CharmSkillMult;
			}

			score = score + target.getCurrentProperties().getMeleeDefense() * this.Const.AI.Behavior.CharmDefenseSkillMult;
			score = score - distanceToTarget * this.Const.AI.Behavior.CharmDistanceMult;
			local targets = 0;
			local targetsInRange = this.queryEnemiesInMeleeRange(1, target.getIdealRange(), target);

			foreach( t in targetsInRange )
			{
				if (t.getID() != _entity.getID() && t.getCurrentProperties().TargetAttractionMult > 1.0)
				{
					targets = ++targets;
				}
			}

			score = score + targets * this.Const.AI.Behavior.CharmHelpOther;
			score = score * this.Math.maxf(0.2, 1.0 - this.Const.AI.Behavior.CharmBraveryMult * target.getBravery() * target.getCurrentProperties().MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] * 0.01);

			if (target.getCurrentProperties().IsRooted && opponentTile.getZoneOfOccupationCount(target.getFaction()) == 0 && !target.isArmedWithRangedWeapon())
			{
				score = score * this.Const.AI.Behavior.CharmRootedMult;
			}

			if (target.isArmedWithRangedWeapon() && opponentTile.getZoneOfOccupationCount(target.getFaction()) != 0)
			{
				score = score * this.Const.AI.Behavior.CharmRangedWouldBeInZOCMult;
			}

			if (distanceToTarget <= target.getIdealRange())
			{
				score = score * this.Const.AI.Behavior.CharmMeleeDangerMult;
			}

			if (this.m.Danger.Danger <= 2 && this.m.Danger.PotentialDanger.find(target.getID()) != 0)
			{
				score = score * this.Const.AI.Behavior.CharmRemoveDangerMult;
			}

			if (target.getType() == this.Const.EntityType.Wardog || target.getType() == this.Const.EntityType.Warhound)
			{
				score = score * this.Const.AI.Behavior.CharmWardogMult;
			}

			if (target.getCurrentProperties().MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] >= 1000.0)
			{
				score = score * this.Const.AI.Behavior.CharmImmuneMult;
			}

			if (!isRangedOpponent)
			{
				local targetsScore = 1.0;
				local targets = 0;
				local targetsNotLockedDown = 0;
				local targetsInRange = this.queryAlliesInMeleeRange(1, target.getIdealRange(), target);

				foreach( t in targetsInRange )
				{
					local s = this.queryTargetValue(target, t);
					targetsScore = targetsScore + s;
					targets = ++targets;

					if (t.getTile().getZoneOfControlCountOtherThan(t.getAlliedFactions()) == 0)
					{
						targetsNotLockedDown = ++targetsNotLockedDown;
					}
				}

				score = score * (1.0 + (targetsScore + targetsNotLockedDown * this.Const.AI.Behavior.CharmTargetLockdownMult) * this.Const.AI.Behavior.CharmTargetsMult);

				if (targets > 1 && target.isArmedWithMeleeWeapon() && target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).isAoE())
				{
					score = score * this.Const.AI.Behavior.CharmAoEMult;
				}
			}
			else
			{
				score = score * this.Const.AI.Behavior.CharmRangedTargetMult;
			}

			local currentZOC = opponentTile.getZoneOfControlCountOtherThan(target.getAlliedFactions());

			if (currentZOC >= 3 || currentZOC >= 2 && target.getHitpointsPct() <= 0.25)
			{
				score = score * this.Const.AI.Behavior.CharmEasierToKillMult;
			}

			if (target.isAbleToWait() && !target.isTurnDone())
			{
				score = score * this.Const.AI.Behavior.CharmStillToActMult;
			}
			else if (!target.isAbleToWait() && target.getActionPoints() < target.getActionPointsMax())
			{
				score = score * this.Const.AI.Behavior.CharmAlreadyWaitedMult;
			}

			if (!target.isArmed() && target.getTile().Items.len() == 0)
			{
				score = score * this.Const.AI.Behavior.CharmTargetUnarmedMult;
			}

			if (target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && target.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.wooden_stick")
			{
				if (!target.getSkills().hasSkill("perk.quick_hands"))
				{
					score = score * this.Const.AI.Behavior.CharmTargetWoodenClubRightNowMult;
				}

				local items = target.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);
				local hasWeapon = false;

				foreach( item in items )
				{
					if (item.isItemType(this.Const.Items.ItemType.Weapon) && item.getID() != "weapon.wooden_stick")
					{
						hasWeapon = true;
						break;
					}
				}

				if (!hasWeapon)
				{
					score = score * this.Const.AI.Behavior.CharmTargetWoodenClubOnlyMult;
				}
			}

			score = score * target.getCurrentProperties().TargetAttractionMult;

			if (target.getCurrentProperties().NegativeStatusEffectDuration < 0)
			{
				score = score * this.Const.AI.Behavior.CharmLowerDurationMult;
			}

			if (score > bestScore)
			{
				bestScore = score;
				bestTarget = target;
			}
		}

		if (bestTarget != null)
		{
			this.m.TargetTile = bestTarget.getTile();
			this.m.ScoreBonus = bestScore * 0.1;
		}

		return true;
	}

	function calculateDanger( _entity, _targets )
	{
		// Function is a generator.
		local myTile = _entity.getTile();
		local currentDanger = 0.0;
		local potentialDanger = [];
		local time = this.Time.getExactTime();

		foreach( target in _targets )
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local targetTile = target.Actor.getTile();
			local realDist = myTile.getDistanceTo(targetTile);

			if (realDist <= this.Const.AI.Behavior.RangedEngageMaxDangerDist && target.Actor.getMoraleState() != this.Const.MoraleState.Fleeing && !target.Actor.isNonCombatant() && !this.isRangedUnit(target.Actor) && target.Actor.getHitpoints() / target.Actor.getHitpointsMax() >= this.Const.AI.Behavior.RangedEngageMinDangerHitpointsPct && targetTile.getZoneOfControlCountOtherThan(target.Actor.getAlliedFactions()) < this.Const.AI.Behavior.RangedEngageIgnoreDangerMinZones)
			{
				potentialDanger.push(target.Actor.getID());
				local danger = this.getDangerFromActor(target.Actor, myTile, _entity);
				currentDanger = currentDanger + danger;
			}
		}

		this.m.Danger = {
			Danger = currentDanger,
			PotentialDanger = potentialDanger
		};
		return true;
	}

	function getDangerFromActor( _actor, _target, _entity )
	{
		local d = this.queryActorTurnsNearTarget(_actor, _target, _entity);

		if (d.Turns <= this.Const.AI.Behavior.RangedEngageKeepMinTurnsAway && d.InZonesOfControl < 2)
		{
			if (d.InZonesOfOccupation != 0 || _actor.getCurrentProperties().IsRooted)
			{
				return 1.0;
			}
			else
			{
				return (1.0 - d.Turns) * 6.0;
			}
		}
		else
		{
			return 0.0;
		}
	}

});

