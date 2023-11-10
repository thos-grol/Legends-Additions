::mods_hookExactClass("entity/world/locations/undead_hideout_location", function(o) {
	o.getDescription = function()
	{
		return "An abandoned homestead with a collapsed roof.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.undead_hideout";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Passive;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.IsDespawningDefenders = false;
		this.m.IsShowingBanner = false;
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.setDefenderSpawnList(::Const.World.Spawn.ZombiesOrZombiesAndGhouls);
		}
		else if (r == 2)
		{
			this.setDefenderSpawnList(::Const.World.Spawn.ZombiesOrZombiesAndGhosts);
		}

		this.m.Resources = 80;
		this.m.RoamerSpawnList = ::Const.World.Spawn.Zombies;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.Hideout);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 100), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 5), _lootTable);
		this.dropAmmo(this.Math.rand(0, 5), _lootTable);
		this.dropFood(this.Math.rand(1, 2), [
			"strange_meat_item",
			"strange_meat_item",
			"ground_grains_item",
			"dried_fruits_item"
		], _lootTable);
		this.dropTreasure(1, [
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/silverware_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_homestead_01");
		local isSouthern = this.getTile().Type == ::Const.World.TerrainType.Desert || this.getTile().Type == ::Const.World.TerrainType.Steppe || this.getTile().Type == ::Const.World.TerrainType.Oasis || this.getTile().TacticalType == ::Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern)
		{
			if (::Const.DLC.Desert)
			{
				this.m.CombatLocation.Template[0] = "tactical.southern_ruins";
			}
		}
	}

});

