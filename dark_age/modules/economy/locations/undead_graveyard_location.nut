::mods_hookExactClass("entity/world/locations/undead_graveyard_location", function(o) {
	o.getDescription = function()
	{
		return "A place where people have buried their dead, placing them down for their last rest. Or at least they hoped so.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.undead_graveyard";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.graveyard";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			this.setDefenderSpawnList(::Const.World.Spawn.ZombiesAndGhosts);
		}
		else
		{
			this.setDefenderSpawnList(::Const.World.Spawn.Zombies);
		}

		this.m.Resources = 260;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.Graveyard);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(1, 200), _lootTable);
		this.dropTreasure(this.Math.rand(0, 1), [
			"loot/bead_necklace_item",
			"loot/bead_necklace_item",
			"loot/signet_ring_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_graveyard_01");
	}

});

