::mods_hookExactClass("entity/world/locations/orc_hideout_location", function(o) {
	o.getDescription = function()
	{
		return "An abandoned homestead with a collapsed roof.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.orc_hideout";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Passive;
		this.m.CombatLocation.Template[0] = "tactical.orc_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.YoungOrcsOnly);
		this.m.Resources = 70;
		this.m.NamedWeaponsList = this.Const.Items.NamedOrcWeapons;
		this.m.NamedShieldsList = this.Const.Items.NamedOrcShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.Hideout);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 100), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 15), _lootTable);
		this.dropFood(this.Math.rand(2, 3), [
			"strange_meat_item"
		], _lootTable);
		this.dropTreasure(1, [
			"loot/signet_ring_item",
			"trade/amber_shards_item",
			"trade/salt_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_homestead_01");
	}

});

