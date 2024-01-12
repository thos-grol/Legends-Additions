::mods_hookExactClass("entity/world/locations/undead_vampire_coven_location", function(o) {
	o.getDescription = function()
	{
		return "Hidden for centuries, this ancient place became a safe haven for a coven of hemovores.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.undead_vampire_coven";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		local r = ::Math.rand(1, 3);

		if (r == 1)
		{
			this.setDefenderSpawnList(::Const.World.Spawn.Vampires);
		}
		else if (r == 2)
		{
			this.setDefenderSpawnList(::Const.World.Spawn.VampiresAndSkeletons);
		}
		else if (r == 3)
		{
			this.setDefenderSpawnList(::Const.World.Spawn.Mummies);
		}

		this.m.Resources = 250;
		this.m.RoamerSpawnList = ::Const.World.Spawn.Vampires;
		this.m.NamedWeaponsList = ::Const.Items.NamedUndeadWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedUndeadShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.VampireCoven);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropFood(::Math.rand(1, 3), [
			"strange_meat_item",
			"wine_item"
		], _lootTable);
		this.dropTreasure(::Math.rand(2, 4), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local isSouthern = this.getTile().Type == ::Const.World.TerrainType.Desert || this.getTile().Type == ::Const.World.TerrainType.Steppe || this.getTile().Type == ::Const.World.TerrainType.Oasis || this.getTile().TacticalType == ::Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern && ::Const.DLC.Desert)
		{
			body.setBrush("world_vampire_coven_02");
			this.m.CombatLocation.Template[0] = "tactical.southern_ruins";
		}
		else
		{
			body.setBrush("world_vampire_coven");
		}
	}

});

