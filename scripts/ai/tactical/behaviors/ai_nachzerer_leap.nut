this.ai_nachzerer_leap <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.nachzerer_leap"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Darkflight;
		this.m.Order = this.Const.AI.Behavior.Order.Darkflight;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;

		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP) return this.Const.AI.Behavior.Score.Zero;
		if (_entity.getCurrentProperties().IsRooted) return this.Const.AI.Behavior.Score.Zero;
		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing) return this.Const.AI.Behavior.Score.Zero;

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return this.Const.AI.Behavior.Score.Zero;

		//Get all potential corpses
		local enemy_tiles = this.m.Skill.getTargets( _entity );
		if (enemy_tiles.len() == 0) return this.Const.AI.Behavior.Score.Zero;

		local targets = [];
		local origin = _entity.getTile();

		foreach( enemy_tile in enemy_tiles )
		{
			//Scan 6 adjacent tiles for empty spaces
			for( local i = 0; i < 6; i = ++i)
			{
				if (!enemy_tile.hasNextTile(i)) continue;
				local next_tile = enemy_tile.getNextTile(i);
				if (!next_tile.IsEmpty) continue;
				
				//Scan 6 adjacent tiles to above tile for enemies
				local surrounding_enemies = 0;
				for( local j = 0; j < 6; j = ++i)
				{
					if (!next_tile.hasNextTile(j)) continue;
					local next_next_tile = next_tile.getNextTile(j);
					if (!next_next_tile.IsOccupiedByActor) continue;
					local actor = next_next_tile.getEntity();
					if (!actor.isAlliedWith(_entity)) surrounding_enemies++;
				}

				local safety_factor = next_tile.getDistanceTo(origin) - surrounding_enemies;
				targets.push({
					Tile = next_tile,
					SafetyFactor = safety_factor
				});
			}
		}

		if (targets.len() == 0) return this.Const.AI.Behavior.Score.Zero;
		targets.sort(this.comparator_SafetyFactor);
		this.m.TargetTile = targets[0].Tile; //pick the furthest, safest tile to jump to.

		::logInfo("Evaluation finished");
		return 340000;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null)
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Leaping.");
			}

			local dist = _entity.getTile().getDistanceTo(this.m.TargetTile);
			this.m.Skill.use(this.m.TargetTile);
			this.getAgent().declareEvaluationDelay(1000);
			this.getAgent().declareAction();

			this.m.TargetTile = null;
		}

		return true;
	}

	//This comparator fn sorts by descending
	function comparator_SafetyFactor( _a, _b )
	{
		if (_a.SafetyFactor > _b.SafetyFactor) return -1;
		else if (_a.SafetyFactor < _b.SafetyFactor) return 1;
		return 0;
	}

});

