::mods_hookExactClass("entity/world/locations/orc_ruins_location", function(o) {
	o.getDescription = function()
	{
		local isSouthern = this.getTile().Type == ::Const.World.TerrainType.Desert || this.getTile().Type == ::Const.World.TerrainType.Steppe || this.getTile().Type == ::Const.World.TerrainType.Oasis || this.getTile().TacticalType == ::Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern)
		{
			return "These ancient ruins cast their shadows far over the surrounding sands.";
		}
		else
		{
			return "A once proud fortress now lying in ruins.";
		}
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.orc_ruins";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Template[1] = "tactical.orc_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.setDefenderSpawnList(::Const.World.Spawn.YoungOrcsAndBerserkers);
		this.m.Resources = 150;
		this.m.NamedWeaponsList = ::Const.Items.NamedOrcWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedOrcShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.Ruins);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		local treasure = [
			"loot/bead_necklace_item",
			"loot/bead_necklace_item",
			"loot/signet_ring_item"
		];

		if (::Const.DLC.Unhold)
		{
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);

			treasure.push("misc/legend_ancient_scroll_item");
			treasure.push("misc/tome");
		}

		this.dropTreasure(1, treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local isSouthern = this.getTile().Type == ::Const.World.TerrainType.Desert || this.getTile().Type == ::Const.World.TerrainType.Steppe || this.getTile().Type == ::Const.World.TerrainType.Oasis || this.getTile().TacticalType == ::Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern)
		{
			body.setBrush("world_desert_ruins_0" + this.Math.rand(1, 2));

			if (::Const.DLC.Desert)
			{
				this.m.CombatLocation.Template[0] = "tactical.southern_ruins";
			}
		}
		else
		{
			body.setBrush("world_ruins_0" + this.Math.rand(1, 3));
		}
	}

});

