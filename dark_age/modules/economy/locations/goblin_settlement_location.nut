::mods_hookExactClass("entity/world/locations/goblin_settlement_location", function(o) {
	o.getDescription = function()
	{
		return "The gates to a great underground Goblin city, its maze-like tunnels teeming with vicious greenskins.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_settlement";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(::Const.World.Spawn.GoblinBoss);
		this.m.Resources = 350;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.GoblinBase);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(::Math.rand(0, 5), _lootTable);
		this.dropAmmo(::Math.rand(10, 25), _lootTable);
		this.dropMedicine(::Math.rand(0, 3), _lootTable);
		this.dropTreasure(::Math.rand(2, 3), [
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item",
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item",
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item",
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item",
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item",
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item",
			"misc/scroll",
			"misc/tome",
			"misc/potion_of_oblivion_item",
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		this.setVisibleInFogOfWar(true);
		local body = this.addSprite("body");
		local inSteppe = this.getTile().Type == ::Const.World.TerrainType.Steppe;

		for( local i = 0; i != 6; i = ++i )
		{
			if (this.getTile().hasNextTile(i) && this.getTile().getNextTile(i).Type == ::Const.World.TerrainType.Steppe)
			{
				inSteppe = true;
				break;
			}
		}

		if (inSteppe)
		{
			body.setBrush("world_goblin_camp_steppe_02");
		}
		else
		{
			body.setBrush("world_goblin_camp_02");
		}
	}

});

