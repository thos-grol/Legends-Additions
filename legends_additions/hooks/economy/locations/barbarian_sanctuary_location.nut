::mods_hookExactClass("entity/world/locations/barbarian_sanctuary_location", function(o) {
	o.getDescription = function()
	{
		return "Barbarians have flocked to this place and set up camp around a site of worship. A lot of fierce northern warriors are likely to be found nearby.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.barbarian_sanctuary";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.barbarian_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.Barbarians);
		this.m.Resources = 325;
		this.m.NamedWeaponsList = this.Const.Items.NamedBarbarianWeapons;
		this.m.NamedArmorsList = this.Const.Items.NamedBarbarianArmors;
		this.m.NamedHelmetsList = this.Const.Items.NamedBarbarianHelmets;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.BarbarianSanctuary);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(300, 700), _lootTable);
		this.dropArmorParts(this.Math.rand(25, 50), _lootTable);
		this.dropAmmo(this.Math.rand(0, 50), _lootTable);
		this.dropMedicine(this.Math.rand(5, 15), _lootTable);
		local treasure = [
			"trade/furs_item",
			"trade/furs_item",
			"trade/amber_shards_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/bone_figurines_item",
			"loot/valuable_furs_item",
			"loot/bead_necklace_item",
			"loot/looted_valuables_item"
		];
		this.dropFood(this.Math.rand(4, 8), [
			"bread_item",
			"beer_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
			"mead_item",
			
			
		], _lootTable);
		this.dropTreasure(this.Math.rand(2, 3), treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local isOnSnow = this.getTile().Type == this.Const.World.TerrainType.Snow;

		for( local i = 0; i != 6; i = i )
		{
			if (this.getTile().hasNextTile(i) && this.getTile().getNextTile(i).Type == this.Const.World.TerrainType.Snow)
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

