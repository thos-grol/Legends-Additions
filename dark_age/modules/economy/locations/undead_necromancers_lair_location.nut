::mods_hookExactClass("entity/world/locations/undead_necromancers_lair_location", function(o) {
	o.getDescription = function()
	{
		return "A necromancer has made this lair his refuge for practicing dark rituals undisturbed.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.undead_necromancers_lair";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.graveyard";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.setDefenderSpawnList(::Const.World.Spawn.Necromancer);
		this.m.Resources = 150;
		this.m.RoamerSpawnList = ::Const.World.Spawn.Zombies;
		this.m.NamedShieldsList = ::Const.Items.NamedUndeadShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.NecromancerLair);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(50, 125), _lootTable);
		this.dropFood(this.Math.rand(0, 1), [
			"wine_item",
			"bread_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(1, 2), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/signet_ring_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_necromancers_lair_01");
	}

});

