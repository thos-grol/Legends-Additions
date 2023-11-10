::mods_hookExactClass("entity/world/locations/undead_buried_castle_location", function(o) {
	o.getDescription = function()
	{
		return "Sunken into the ground, this castle has been long abandoned, only to give refuge to much darker creatures.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.undead_buried_castle";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.setDefenderSpawnList(::Const.World.Spawn.UndeadArmy);
		this.m.NamedWeaponsList = ::Const.Items.NamedUndeadWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedUndeadShields;
		this.m.Resources = 350;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.BuriedCastle);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/white_pearls_item",
			"loot/golden_chalice_item",
			"loot/gemstones_item",
			"loot/ancient_gold_coins_item",
			"loot/jeweled_crown_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/white_pearls_item",
			"loot/golden_chalice_item",
			"loot/gemstones_item",
			"loot/ancient_gold_coins_item",
			"loot/jeweled_crown_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"misc/legend_ancient_scroll_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local flipped = this.Math.rand(0, 1) == 1;
		local body = this.addSprite("body");
		body.setBrush("world_buried_castle");
		local isSouthern = this.getTile().Type == ::Const.World.TerrainType.Desert || this.getTile().Type == ::Const.World.TerrainType.Steppe || this.getTile().Type == ::Const.World.TerrainType.Oasis || this.getTile().TacticalType == ::Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern && ::Const.DLC.Desert)
		{
			this.m.CombatLocation.Template[0] = "tactical.southern_ruins";
		}
	}

});

