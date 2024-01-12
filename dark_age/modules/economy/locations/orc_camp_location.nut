::mods_hookExactClass("entity/world/locations/orc_camp_location", function(o) {
	o.getDescription = function()
	{
		return "A small camp erected by Orcs, either as part of a large horde in the vicinity or a small tribes of its own. They\'ll eventually move on to hunt and pillage elsewhere.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.orc_camp";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Mobile;
		this.m.CombatLocation.Template[0] = "tactical.orc_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.setDefenderSpawnList(::Const.World.Spawn.OrcDefenders);
		this.m.Resources = 140;
		this.m.NamedWeaponsList = ::Const.Items.NamedOrcWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedOrcShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.GreenskinCamp);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropTreasure(::Math.rand(0, 1), [
			"trade/furs_item",
			"trade/copper_ingots_item",
			"trade/iron_ingots_item",
			"trade/tin_ingots_item",
			// "trade/gold_ingots_item"
		], _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		this.setVisibleInFogOfWar(true);
		local body = this.addSprite("body");
		body.setBrush("world_orc_camp_01");
	}

});

