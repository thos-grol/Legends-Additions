::mods_hookExactClass("entity/world/locations/bandit_hideout_location", function(o) {
	o.getDescription = function()
	{
		return "An abandoned homestead with a collapsed roof.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.bandit_hideout";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Passive;
		this.m.CombatLocation.Template[0] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(::Const.World.Spawn.BanditDefenders);
		this.m.Resources = 70;
		this.m.NamedShieldsList = ::Const.Items.NamedBanditShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.Hideout);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(50, 150), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 10), _lootTable);
		this.dropAmmo(this.Math.rand(0, 10), _lootTable);
		local treasure = [
			"loot/signet_ring_item",
			"trade/amber_shards_item",
			"trade/cloth_rolls_item",
			"trade/salt_item"
		];
		this.dropFood(this.Math.rand(1, 2), [
			"bread_item",
			"beer_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
			
		], _lootTable);
		this.dropTreasure(1, treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_homestead_01");
	}

});

