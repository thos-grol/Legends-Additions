::mods_hookExactClass("entity/world/locations/nomad_tents_location", function(o) {
	o.getDescription = function()
	{
		return "A small camp of nomad tents that can be packed up and moved quickly.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.nomad_tents";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Passive;
		this.m.CombatLocation.Template[0] = "tactical.desert_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.IsShowingBanner = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(::Const.World.Spawn.NomadDefenders);
		this.m.Resources = 70;
		this.m.VisibilityMult = 0.8;
		this.m.NamedShieldsList = ::Const.Items.NamedSouthernShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.NomadTents);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(0, 75), _lootTable);
		this.dropArmorParts(::Math.rand(0, 5), _lootTable);
		this.dropAmmo(::Math.rand(0, 10), _lootTable);
		this.dropMedicine(::Math.rand(0, 3), _lootTable);
		local treasure = [
			"loot/bead_necklace_item",
			"loot/bead_necklace_item",
			"trade/furs_item"
		];
		this.dropTreasure(1, treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_nomad_camp_02");
	}

});

