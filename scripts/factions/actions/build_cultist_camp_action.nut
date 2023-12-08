this.build_cultist_camp_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "build_cultist_camp_action";
		this.m.IsRunOnNewCampaign = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		local settlements = _faction.getSettlements();

		if (this.World.FactionManager.isCivilWar() && this.World.FactionManager.getGreaterEvilStrength() >= 20.0)
		{
			if (settlements.len() > (this.Const.DLC.Wildmen ? 6 : 8))
			{
				return;
			}
		}
		else if (this.World.FactionManager.isGreaterEvil())
		{
			if (settlements.len() > (this.Const.DLC.Wildmen ? 3 : 4))
			{
				return;
			}
		}
		else if (settlements.len() > (this.Const.DLC.Wildmen ? 4 : 8))
		{
			return;
		}

		this.m.Score = 2;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local camp;
		local r = this.Math.rand(1, 2);
		local minY = this.Const.DLC.Desert ? 0.2 : 0.0;
		local maxY = this.Const.DLC.Wildmen ? 0.75 : 1.0;

		if (r == 1)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow
			], 7, 16, 1000, 7, 7, null, minY, maxY);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/cultist_camp_location", tile.Coords);
			}
		}
		else if (r == 2)
		{
			local tile = this.getTileToSpawnLocation(this.Const.Factions.BuildCampTries, [
				this.Const.World.TerrainType.Mountains,
				this.Const.World.TerrainType.Snow
			], 6, 12, 1000, 7, 7, null, minY, maxY);

			if (tile != null)
			{
				camp = this.World.spawnLocation("scripts/entity/world/locations/cultist_hideout_location", tile.Coords);
			}
		}

		if (camp != null)
		{
			local banner = this.getAppropriateBanner(camp, _faction.getSettlements(), 15, this.Const.BanditBanners);
			camp.onSpawned();
			camp.setBanner(banner);
			_faction.addSettlement(camp, false);
		}
	}

});

