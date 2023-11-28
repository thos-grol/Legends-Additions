::mods_hookExactClass("entity/world/locations/barbarian_shelter_location", function(o) {
	o.getDescription = function()
	{
		return "A couple of simple barbarian fur huts huddled down in a circle.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.barbarian_shelter";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.barbarian_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(::Const.World.Spawn.Barbarians);
		this.m.Resources = 75;
		this.m.NamedWeaponsList = ::Const.Items.NamedBarbarianWeapons;
		this.m.NamedArmorsList = ::Const.Items.NamedBarbarianArmors;
		this.m.NamedHelmetsList = ::Const.Items.NamedBarbarianHelmets;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.BarbarianShelter);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 75), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 10), _lootTable);
		this.dropAmmo(this.Math.rand(0, 10), _lootTable);
		this.dropMedicine(this.Math.rand(0, 5), _lootTable);
		local treasure = [
			"loot/bead_necklace_item",
			"loot/bead_necklace_item",
			"loot/furs_item"
		];
		this.dropTreasure(this.Math.rand(1, 2), treasure, _lootTable);
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
			body.setBrush("world_wildmen_01_snow");
		}
		else
		{
			body.setBrush("world_wildmen_01");
		}
	}

});

