this.ai_nachzerer_gruesome_feast <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.nachzerer_gruesome_feast"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.GruesomeFeast;
		this.m.Order = this.Const.AI.Behavior.Order.GruesomeFeast;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		::logInfo("begin: " + "ai_nachzerer_gruesome_feast");
		// Function is a generator.

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP) return this.Const.AI.Behavior.Score.Zero;
		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing) return this.Const.AI.Behavior.Score.Zero;
		if (this.getAgent().getIntentions().IsDefendingPosition) return this.Const.AI.Behavior.Score.Zero;
		if (_entity.getCurrentProperties().IsRooted) return this.Const.AI.Behavior.Score.Zero;

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return this.Const.AI.Behavior.Score.Zero;

		local time = this.Time.getExactTime();
		local tile_origin = _entity.getTile();
		local corpses = this.Tactical.Entities.getCorpses();
		if (corpses.len() == 0) return this.Const.AI.Behavior.Score.Zero;

		local potentialCorpses = [];
		foreach( c in corpses )
		{
			if (!c.IsCorpseSpawned || !c.Properties.get("Corpse").IsConsumable || c.IsEmpty) continue;
			
			local dist = c.getDistanceTo(tile_origin);
			if (dist > this.m.Skill.getMaxRange()) continue;
			potentialCorpses.push({
				Tile = c,
				Distance = dist
			});

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}
		}

		if (potentialCorpses.len() == 0) return this.Const.AI.Behavior.Score.Zero;
		potentialCorpses.sort(this.onSortByDistance);

		local bestTarget = potentialCorpses[0].Tile;
		if (bestTarget == null) return this.Const.AI.Behavior.Score.Zero;
		this.m.TargetTile = bestTarget;
		return this.Math.max(0, this.Const.AI.Behavior.Score.GruesomeFeast) * 100;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.m.IsFirstExecuted = false;

			if (this.Const.AI.VerboseMode) this.logInfo("* " + _entity.getName() + ": Using Gruesome Feast (Leap).");

			this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
			if (this.m.Skill.use(this.m.TargetTile))
			{
				if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
				{
					this.getAgent().declareAction();
					this.getAgent().declareEvaluationDelay(600);
				}
			}

			this.m.Skill = null;
			this.m.TargetTile = null;
		}

		return false;
	}

	function onSortByDistance( _a, _b )
	{
		if (_a.Distance > _b.Distance)
		{
			return -1;
		}
		else if (_a.Distance < _b.Distance)
		{
			return 1;
		}

		return 0;
	}

});

