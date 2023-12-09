//solution from davkul rising
this.build_cultist_camp_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "build_cultist_camp_action";
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.getSettlementSpawn()) return;
		this.m.Score = 100;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local camp;
		local minY = this.Const.DLC.Desert ? 0.2 : 0.0;
		local tile;
		local result = findSettlementAndTile(_faction)
		if (result == null) return;
		local tile = result.Tile

		if (tile != null)
		{
			if (::Math.rand(1,100) <= 33)
				camp = this.World.spawnLocation("scripts/entity/world/locations/cultist_camp_location", tile.Coords);
			else camp = this.World.spawnLocation("scripts/entity/world/locations/cultist_hideout_location", tile.Coords);
			
			camp.setBanner("banner_13")
			_faction.addSettlement(camp, false);
		}
	}

	function findSettlementAndTile(_faction)
	{
		local tile;
		local targetSettlement;
		local avoidTerrain = [
		this.Const.World.TerrainType.Mountains, 
		this.Const.World.TerrainType.Swamp,	
		this.Const.World.TerrainType.Hills,
		this.Const.World.TerrainType.Forest,
		this.Const.World.TerrainType.SnowyForest,
		this.Const.World.TerrainType.LeaveForest,
		this.Const.World.TerrainType.AutumnForest
		]
		local villages = []
		local cultistVillages = []
		local alreadyTargetedVillages = []
		local biggestVillageToTarget = this.Math.max(1, this.Math.floor(_faction.getLairs().len()/2)) // scales targetable villages with number of cultist locations

		foreach (settlement in _faction.getLairs())
		{
			cultistVillages.push(settlement);
		}

		foreach (settlement in this.World.EntityManager.getSettlements())
		{
			if (settlement.isMilitary() || settlement.isSouthern() || settlement.isIsolated() || settlement.m.Size >  biggestVillageToTarget || alreadyTargetedVillages.find(settlement.getID()) != null){
				continue
			}
			villages.push(settlement)
		}
		//failsave, can choose any size village
		if (villages.len() == 0)
		{
			foreach (settlement in this.World.EntityManager.getSettlements())
			{
				if (!settlement.isMilitary() && !settlement.isIsolated() && !alreadyTargetedVillages.find(settlement.getID())) villages.push(settlement)
			}
		}

		//last resort failsave
		if (villages.len() == 0) return

		local tries = 0
		while (tile == null && tries < 100)
		{
			tries++
			if (cultistVillages.len() > 0)
			{
				//choose closest settlement to a random cultist location
				local cultistTile = cultistVillages[this.Math.rand(0, cultistVillages.len() -1)].getTile()
				local closestDist = 9999
				foreach (village in villages){
					local d = cultistTile.getDistanceTo(village.getTile());
					if (d < closestDist)
					{
						targetSettlement = village;
						closestDist = d;
					}

				}

			}
			else{
				//if no cultist location, choose random settlement
				targetSettlement = villages[this.Math.rand(0, villages.len() -1)]				
			}
			tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, avoidTerrain, 7, 10, 1000, 7, 7, targetSettlement.getTile());
		}
		return {Tile = tile, Settlement = targetSettlement}

	}



});

