this.ai_nachzerer_gruesome_feast <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		SelectedSkill = null,
		PossibleSkills = [
			"actives.nachzerer_gruesome_feast"
		]
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.Darkflight;
		this.m.Order = this.Const.AI.Behavior.Order.Darkflight;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		if (_entity.getActionPoints() < this.Const.Movement.AutoEndTurnBelowAP) return this.Const.AI.Behavior.Score.Zero;
		if (_entity.getCurrentProperties().IsRooted) return this.Const.AI.Behavior.Score.Zero;
		if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing) return this.Const.AI.Behavior.Score.Zero;

		this.m.SelectedSkill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.SelectedSkill == null) return this.Const.AI.Behavior.Score.Zero;

		//Get all potential corpses
		local corpse_tiles = this.Tactical.Entities.getCorpses();
		if (corpse_tiles.len() == 0) return this.Const.AI.Behavior.Score.Zero;

		local targets = [];
		local origin = _entity.getTile();

		foreach( corpse_tile in corpse_tiles )
		{
			if (!corpse_tile.IsCorpseSpawned || !corpse_tile.Properties.get("Corpse").IsConsumable) continue;
			local distance = corpse_tile.getDistanceTo(origin);
			if (distance > this.m.SelectedSkill.m.MaxRange) continue;

			//Scan 6 adjacent tiles for enemies
			local surrounding_enemies = 0;
			for( local i = 0; i < 6; i = ++i)
			{
				if (!corpse_tile.hasNextTile(i)) continue;
				local next_tile = corpse_tile.getNextTile(i);
				if (!next_tile.IsOccupiedByActor) continue;
				local actor = next_tile.getEntity();
				if (!actor.isAlliedWith(_entity)) surrounding_enemies++;
			}

			local safety_factor = distance - surrounding_enemies;
			targets.push({
				Tile = corpse_tile,
				SafetyFactor = safety_factor
			});
		}


		if (targets.len() == 0) return this.Const.AI.Behavior.Score.Zero;
		targets.sort(this.comparator_SafetyFactor);
		this.m.TargetTile = targets[0].Tile; //pick the most isolated, and furthest distance away corpse to eat.
		this.getAgent().getIntentions().TargetTile = this.m.TargetTile;

		return 350000;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.m.IsFirstExecuted = false;
			this.m.Agent.adjustCameraToTarget(this.m.TargetTile);
			return false;
		}

		if (this.Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Leaping gruesome feast.");
		}
		this.m.SelectedSkill.use(this.m.TargetTile);
		this.getAgent().declareEvaluationDelay(3000);
		this.getAgent().declareAction();
		this.m.TargetTile = null;
		this.m.SelectedSkill = null;
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

