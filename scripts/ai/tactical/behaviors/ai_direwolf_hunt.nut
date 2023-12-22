this.ai_direwolf_hunt <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.direwolf_hunt_teleport"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.Teleport;
		this.m.Order = ::Const.AI.Behavior.Order.Teleport;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP) return ::Const.AI.Behavior.Score.Zero;
		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing) return ::Const.AI.Behavior.Score.Zero;
		if (!this.getAgent().hasKnownOpponent()) return ::Const.AI.Behavior.Score.Zero;
		if (_entity.getCurrentProperties().IsRooted) return ::Const.AI.Behavior.Score.Zero;

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);
		if (this.m.Skill == null) return ::Const.AI.Behavior.Score.Zero;

		this.m.Skill.m.HuntTile = pick_hunt(_entity);
		if (this.m.Skill.m.HuntTile == null) return ::Const.AI.Behavior.Score.Zero;

		local func = this.findBestTarget(_entity, this.getAgent().getKnownOpponents());
		while (resume func == null)
		{
			yield null;
		}
		if (this.m.TargetTile == null) return ::Const.AI.Behavior.Score.Zero;

		return 100000000;
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
				_entity.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return false;
		}

		this.m.Skill.use(this.m.TargetTile);
		this.getAgent().declareEvaluationDelay(3000);
		this.getAgent().declareAction();
		this.m.Skill = null;
		this.m.TargetTile = null;
		return true;
	}

	//////////////////////////////////////////////////////////////////////////////
	// Teleport Targeter
	//////////////////////////////////////////////////////////////////////////////

	function findBestTarget( _entity, _targets )
	{
		// Function is a generator.
		local myTile = _entity.getTile();
		local myPos = myTile.SquareCoords;
		local mapSize = this.Tactical.getMapSize();
		local time = this.Time.getExactTime();

		do
		{
			local x = ::Math.rand(3, mapSize.X - 3);
			local y = ::Math.rand(3, mapSize.Y - 3);

			if (!this.Tactical.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
				}
				else if (!this.m.Skill.isUsableOn(tile, myTile))
				{
				}
				else
				{
					if (this.isAllottedTimeReached(time))
					{
						yield null;
						time = this.Time.getExactTime();
					}

					local usable = false;

					foreach( t in _targets )
					{
						local targetTile = t.Actor.getTile();
						local d = targetTile.getDistanceTo(tile);

						if (d > 5 || d < 2) continue;

						for( local i = 0; i < 6; i = ++i )
						{
							if (!targetTile.hasNextTile(i)) continue;
							local adjacentTile = targetTile.getNextTile(i);
							if (isUsableOn_local(_entity, adjacentTile, tile))
							{
								usable = true;
								break;
							}
						}

						if (usable) break;
					}

					if (usable)
					{
						this.m.TargetTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		return true;
	}

	function isUsableOn_local( _entity, _targetTile, _userTile = null )
	{
		if (_userTile == null) _userTile = _entity.getTile();
		if (!onVerifyTarget(_userTile, _targetTile)) return false;
		local d = _userTile.getDistanceTo(_targetTile);
		local levelDifference = _userTile.Level - _targetTile.Level;
		if (d < 3 || d > 5) return false;
		return true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty) return false;

		if (::Math.abs(_targetTile.Level - _originTile.Level) > 3) return false;

		local myPos = _originTile.Pos;
		local targetPos = _targetTile.Pos;
		local distance = _originTile.getDistanceTo(_targetTile);
		local Dx = (targetPos.X - myPos.X) / distance;
		local Dy = (targetPos.Y - myPos.Y) / distance;

		for( local i = 0; i < distance; i = ++i )
		{
			local x = myPos.X + Dx * i;
			local y = myPos.Y + Dy * i;
			local tileCoords = ::Tactical.worldToTile(this.createVec(x, y));
			local tile = ::Tactical.getTile(tileCoords);

			if (!tile.IsOccupiedByActor && !tile.IsEmpty) return false;
		}

		return true;
	}

	//////////////////////////////////////////////////////////////////////////////
	// Hunt Strike Targeter
	//////////////////////////////////////////////////////////////////////////////

	function pick_hunt( _entity )
	{
		local result = {
			Tiles = [],
			User = _entity,
			Num = 0
		};

		local onQueryTilesHit = function( _tile, result )
		{
			if (_tile.IsEmpty) return;
			if (_tile.getEntity() == null) return;
			if (!_tile.getEntity().isAlive()) return;
			if (!_tile.getEntity().isAttackable()) return;
			if (result.User.isAlliedWith(_tile.getEntity())) return;

			result.Tiles.push(_tile);
			result.Num += 1;
		};

		this.Tactical.queryTilesInRange(_entity.getTile(), 1, 6, false, [], onQueryTilesHit, result);
		local targets = [];
		foreach( enemy_tile in result.Tiles )
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

				local safety_factor = next_tile.getDistanceTo(_entity.getTile()) - surrounding_enemies;
				targets.push({
					Tile = next_tile,
					SafetyFactor = safety_factor
				});
			}
		}
		if (targets.len() == 0) return null;

		//This comparator fn sorts by descending
		local comparator_SafetyFactor = function ( _a, _b )
		{
			if (_a.SafetyFactor > _b.SafetyFactor) return -1;
			else if (_a.SafetyFactor < _b.SafetyFactor) return 1;
			return 0;
		};
		targets.sort(comparator_SafetyFactor);
		return targets[0].Tile; //pick the furthest, safest tile to attack.
	}

});

