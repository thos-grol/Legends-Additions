::mods_hookExactClass("entity/world/locations/barbarian_sanctuary_location", function(o) {
	o.getDescription = function()
	{
		return "Barbarians have flocked to this place and set up camp around a site of worship. A lot of fierce northern warriors are likely to be found nearby.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.barbarian_sanctuary";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.barbarian_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(::Const.World.Spawn.Barbarians);
		this.m.Resources = 325;
		this.m.NamedWeaponsList = ::Const.Items.NamedBarbarianWeapons;
		this.m.NamedArmorsList = ::Const.Items.NamedBarbarianArmors;
		this.m.NamedHelmetsList = ::Const.Items.NamedBarbarianHelmets;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.BarbarianSanctuary);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(0, 400), _lootTable);
		this.dropArmorParts(::Math.rand(0, 25), _lootTable);
		this.dropAmmo(::Math.rand(0, 25), _lootTable);
		this.dropMedicine(::Math.rand(0, 10), _lootTable);
		local treasure = [
			"trade/furs_item",
			"trade/furs_item",
			"loot/signet_ring_item"

		];
		this.dropTreasure(::Math.rand(2, 3), treasure, _lootTable);
		//FEATURE_9: drop intersting loot in camps?
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local isOnSnow = this.getTile().Type == ::Const.World.TerrainType.Snow;

		for( local i = 0; i != 6; i = i )
		{
			if (this.getTile().hasNextTile(i) && this.getTile().getNextTile(i).Type == ::Const.World.TerrainType.Snow)
			{
				isOnSnow = true;
				break;
			}

			i = ++i;
		}

		if (isOnSnow)
		{
			body.setBrush("world_wildmen_03_snow");
		}
		else
		{
			body.setBrush("world_wildmen_03");
		}
	}

});

