::mods_hookExactClass("entity/world/locations/goblin_camp_location", function(o) {
	o.getDescription = function()
	{
		return "A makeshift encampment erected by goblins for shelter and stashing supplies.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_camp";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.Palisade;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.GoblinBoss);
		this.m.Resources = 120;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.GoblinCamp);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(0, 10), _lootTable);
		this.dropAmmo(this.Math.rand(0, 40), _lootTable);
		this.dropMedicine(this.Math.rand(0, 2), _lootTable);
		this.dropFood(this.Math.rand(1, 3), [
			"strange_meat_item",
			"roots_and_berries_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(1, 2), [
			"trade/salt_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/goblin_minted_coins_item",
			"loot/goblin_rank_insignia_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_goblin_camp_01");
	}

});

